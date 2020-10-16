pragma solidity ^0.5.10;
import {TypedMemView} from "./libraries/TypedMemView.sol";
import {CKBCrypto} from "./libraries/CKBCrypto.sol";
import {SafeMath} from "./libraries/SafeMath.sol";
import {ViewSpv} from "./libraries/ViewSpv.sol";

library CKBSpv {
    function prove(bytes memory transactionProof) public view returns(bool) {
        return true;
    }
}