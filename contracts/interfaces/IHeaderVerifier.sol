pragma solidity ^0.5.10;
import {TypedMemView} from "../libraries/TypedMemView.sol";
import {SafeMath} from "../libraries/SafeMath.sol";
import {CKBCrypto} from "../libraries/CKBCrypto.sol";
import {ViewCKB} from "../libraries/ViewCKB.sol";

 interface IHeaderVerifier {
    function verifyPow() internal view returns (bool);
    function verifyTimestamp()  internal view returns (bool);
    function verifyVersion() internal view returns (bool);
    function verifyNumber() internal view returns (bool);
    function verifyHeader() internal view returns(bool);
 }