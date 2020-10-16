pragma solidity ^0.5.10;
import {TypedMemView} from "./TypedMemView.sol";
import {CKBCrypto} from "./CKBCrypto.sol";
import {SafeMath} from "./SafeMath.sol";
import {ViewCKB} from "./ViewCKB.sol";

contract CKBChain {
    // Minimal information about the submitted block.
    struct BlockInfo {
        uint64 blockNumber;
        uint64 epoch;
        uint256 timestamp;
        bytes32 hash;
        bytes32 transactionsRoot;
        bytes32 unclesHash;
        bytes32 next_hash;
    }

    struct EpochExt {
        uint64 number;
        uint64 base_block_reward;
        uint64 remainder_reward;
        uint256 previous_epoch_hash_rate;
        bytes32 last_block_hash_in_previous_epoch;
        uint64 start_number;
        uint64 length;
        uint32 compact_target;
    }
    // Whether the contract was initialized.
    bool public initialized;

    // The most recent epoch used to calc next epoch info
    EpochExt public currentEpoch;

    // using previous and current epoch hash rate to calc adjusted_epoch_hash_rate
    uint256 PreviousEpochHashRate;

    mapping(uint64 => bytes32) blockHashes_;
    mapping(uint64 => uint256) totalDifficulty_;
    mapping(uint64 => uint256) totalUnclesCount_;
    mapping(uint64 => bytes32) blockTransactionsRoots_;

    function calculateTxHash() internal view returns (bytes32) {
        
    }

    function submitHeaders() external view returns(bool) {

    }

    function next_epoch_ext(BlockInfo header) internal {
        // calc next_epoch_ext to currentEpoch
    }

}
