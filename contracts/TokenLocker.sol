pragma solidity ^0.5.10;

import "./interfaces/IERC20.sol";
import {TypedMemView} from "./libraries/TypedMemView.sol";
import {SafeMath} from "./libraries/SafeMath.sol";
import {ViewCKB} from "./libraries/ViewCKB.sol";
import {ViewSpv} from "./libraries/ViewSpv.sol";
import {Address} from "./libraries/Address.sol";
import {ICKBSpv} from "./interfaces/ICKBSpv.sol";
import {IWETH} from "./interfaces/IWETH.sol";

contract TokenLocker {
    using SafeMath for uint256;
    using Address for address;

    using TypedMemView for bytes;
    using TypedMemView for bytes29;
    using ViewCKB for bytes29;
    using ViewSpv for bytes29;

    uint64 public numConfirmations_;
    ICKBSpv public ckbSpv_;

    // txHash -> Used
    mapping(bytes32 => bool) public usedTx_;

    event Locked(
        address indexed token,
        address indexed sender,
        uint256 amount,
        string accountId
    );

    event Unlocked(
        address indexed token,
        uint128 amount,
        address recipient
    );

    // Function output from burning fungible token on Near side.
    struct BurnResult {
        uint128 amount;
        address token;
        address recipient;
    }

    constructor(address ckbSpvAddress, uint64 numConfirmations) public {
        ckbSpv_ = ICKBSpv(ckbSpvAddress);
        numConfirmations_ = numConfirmations;
    }

    function _decodeBurnResult(bytes memory proofData) internal pure returns (BurnResult memory result) {
        // todo verify burn tx
        result = BurnResult(9999999, address(0), address(0x408F370E997BED9808ADC07fE81486c032b573D3));
    }

    // before lockToken, user should approve -> TokenLocker Contract with 0xffffff token
    function lockToken(address token, uint256 amount, string memory ckbAddress) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        emit Locked(token, msg.sender, amount, ckbAddress);
    }

    function lockETH(uint256 amount, string memory ckbAddress) public payable {
        emit Locked(address(0), msg.sender, msg.value, ckbAddress);
    }

    function unlockToken(bytes memory proofData) public payable {
        require(ckbSpv_.proveTxExist(proofData, numConfirmations_), "tx from proofData should exist");

        // Unpack the proof and extract the execution outcome.
        bytes29 proof = proofData.ref(uint40(ViewSpv.SpvTypes.TransactionProof));
        bytes32 txHash = proof.mockTxHash();
        require(!usedTx_[txHash], "The burn tx cannot be reused");
        usedTx_[txHash] = true;

        BurnResult memory result = _decodeBurnResult(proofData);
        if (result.token == address(0)) {
            // it means token == Eth
            result.recipient.toPayable().transfer(result.amount);
        } else {
            IERC20(result.token).transfer(result.recipient, result.amount);
        }

        emit Unlocked(address(result.token), result.amount, result.recipient);
    }

}
