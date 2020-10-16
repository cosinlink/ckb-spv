pragma solidity ^0.5.10;
import {TypedMemView} from "./TypedMemView.sol";
import {ViewCKB} from "./ViewCKB.sol";
import {SafeMath} from "./SafeMath.sol";

library ViewSpv {
    using TypedMemView for bytes29;
    using SafeMath for uint;

    enum SpvTypes {
        Unknown,                // 0x0
        TransactionProof,
        MekleProof
    }
}