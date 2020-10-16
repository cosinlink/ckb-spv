pragma solidity ^0.5.10;
import {TypedMemView} from "./libraries/TypedMemView.sol";
import {CKBCrypto} from "./libraries/CKBCrypto.sol";
import {SafeMath} from "./libraries/SafeMath.sol";
import {ViewCKB} from "./libraries/ViewCKB.sol";
import {ICKBChain} from "./interfaces/ICKBChain.sol";
import {ICKBSpv} from "./interfaces/ICKBSpv.sol";
import {IHeaderVerifier} from "./interfaces/IHeaderVerifier.sol";

contract CKBChain is ICKBChain, ICKBSpv, IHeaderVerifier {

    /// We store the hashes of the blocks for the past `HashesGcThreshold` headers.
    /// Events that happen past this threshold cannot be verified by the client.
    /// It is desirable that this number is larger than 7 days worth of headers, which is roughly
    /// 40k ckb blocks. So this number should be 40k in production.
    uint64 public constant HashesGcThreshold = 40000;
    /// We store full information about the headers for the past `FinalizedGcThreshold` blocks.
    /// This is required to be able to adjust the canonical chain when the fork switch happens.
    /// The commonly used number is 500 blocks, so this number should be 500 in production.
    uint64 public constant FinalizedGcThreshold = 500;
    /// Number of `NumConfirmations` that applications can use to consider the transaction safe.
    /// For most use cases 25 should be enough, for super safe cases it should be 500.
    uint64 public NumConfirmations = 25;

    // Minimal information about the submitted block.
    struct BlockHeader {
        uint64 number;
        uint64 epoch;
        uint256 timestamp;
        uint256 totalDifficulty;
        bytes32 parentHash;
    }

    // Whether the contract was initialized.
    bool public initialized;

    /// Hashes of the canonical chain mapped to their numbers. Stores up to `hashes_gc_threshold`
    /// entries.
    /// header number -> header hash
    mapping(uint64 => bytes32) activeHeaderHashes;
    mapping(uint64 => bytes32) activeTransactionRoots;


    /// All known header hashes. Stores up to `finalized_gc_threshold`.
    /// header number -> hashes of all headers with this number.
    mapping(uint64 => bytes32[]) allHeaderHashes;

    /// Known headers. Stores up to `finalized_gc_threshold`.
    mapping(bytes32 => BlockHeader) blockHeaders;

    /// Remove hashes from the active chain that are at least as old as the given header number.
    function gcActiveChain(uint64 blockNumber) internal {
    }

    /// Remove information about the headers that are at least as old as the given header number.
    function gcHeaders(uint64 blockNumber) internal {
    }

}
