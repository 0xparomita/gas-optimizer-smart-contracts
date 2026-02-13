// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GasLab
 * @dev Demonstrates gas optimization techniques including storage packing and Yul.
 */
contract GasLab {
    // Optimized: Multiple variables packed into a single 32-byte slot
    // uint64 (8 bytes) + uint64 (8 bytes) + uint128 (16 bytes) = 32 bytes
    uint64 public a;
    uint64 public b;
    uint128 public c;

    error Unauthorized();

    /**
     * @dev Uses Yul (assembly) for high-efficiency addition.
     * Bypasses Solidity's default checked arithmetic (since we manually handle logic).
     */
    function assemblyAdd(uint x, uint y) public pure returns (uint z) {
        assembly {
            z := add(x, y)
        }
    }

    /**
     * @dev Uses Custom Errors which are significantly cheaper than require strings.
     */
    function checkOwner(address owner) public view {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
    }

    /**
     * @dev Efficient bit-mapping example.
     * Checks if the i-th bit is set in a bit-map.
     */
    function isBitSet(uint256 bitMap, uint8 i) public pure returns (bool) {
        return (bitMap >> i) & 1 == 1;
    }
}
