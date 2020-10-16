pragma solidity ^0.5.10;

interface ICKBSpv {
    function proveTxExist(bytes calldata txProofData) external view returns(bool);
}