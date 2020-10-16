pragma solidity ^0.5.10;
import {TypedMemView} from "./TypedMemView.sol";
import {SafeMath} from "./SafeMath.sol";
import {CKBCrypto} from "./CKBCrypto.sol";
import {ViewCKB} from "./ViewCKB.sol";

 interface IHeaderVerifier {
    function verifyPow() internal view returns (bool);
    function verifyTimestamp()  internal view returns (bool);
    function verifyVersion() internal view returns (bool);
    function verifyNumber() internal view returns (bool);
    function verifyHeader() internal view returns(bool);
 }