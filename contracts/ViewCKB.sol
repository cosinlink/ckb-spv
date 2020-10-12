pragma solidity ^0.5.10;
import {TypedMemView} from "./TypedMemView.sol";
import {SafeMath} from "./SafeMath.sol";

library ViewCKB {
    using TypedMemView for bytes29;
    using SafeMath for uint;
    uint256 public constant PERIOD_BLOCKS = 24 * 450 * 7;  // 1 week in blocks
    enum CKBTypes {
        Unknown,                // 0x0
        Script,                 // 0x1
        Outpoint,
        CellInput,
        CellOutput,
        Bytes,
        LockHash,
        TypeHash,
        Header,
        HeaderArray,
        Transaction
    }

    /// @notice             requires `memView` to be of a specified type
    /// @param memView      a 29-byte view with a 5-byte type
    /// @param t            the expected type (e.g. CKBTypes.Outpoint, CKBTypes.Script, etc)
    /// @return             passes if it is the correct type, errors if not
    modifier typeAssert(bytes29 memView, CKBTypes t) {
        memView.assertType(uint40(t));
        _;
    }

    /// @notice             extracts the since as an integer from a CellInput
    /// @param _input       the CellInput
    /// @return             the since
    function since(bytes29 _input) internal pure typeAssert(_input, CKBTypes.CellInput) returns (uint64) {
        return uint64(_input.indexLEUint(0, 8));
    }

    /// @notice          extracts the outpoint from a CellInput
    /// @param _input    the CellInput
    /// @return          the outpoint as a typed memory
    function previousOutput(bytes29 _input) internal pure typeAssert(_input, CKBTypes.CellInput) returns (bytes29) {
        return _input.slice(8, 44, uint40(CKBTypes.Outpoint));
    }

    /// @notice         extracts the codeHash from a Script
    /// @param _input   the Script
    /// @return         the codeHash
    function codeHash(bytes29 _input) internal pure typeAssert(_input, CKBTypes.Script) returns (bytes32) {
        uint256 startIndex = _input.indexLEUint(4, 4);
        return _input.index(startIndex, 32);
    }

    /// @notice         extracts the hashType from a Script
    /// @param _input   the Script
    /// @return         the hashType
    function hashType(bytes29 _input) internal pure typeAssert(_input, CKBTypes.Script) returns (uint8) {
        uint256 startIndex = _input.indexLEUint(4, 4);
        return uint8(_input.indexUint(startIndex, 1));
    }

    /// @notice         extracts the args from a Script
    /// @param _input   the Script
    /// @return         the args
    function args(bytes29 _input) internal pure typeAssert(_input, CKBTypes.Script) returns (bytes29) {
        uint256 startIndex = _input.indexLEUint(12, 4);
        uint256 argsLength = _input.indexLEUint(startIndex, 4);
        return _input.slice(startIndex, argsLength, uint40(CKBTypes.Bytes));
    }
}

