// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "https://github.com/Vectorized/solady/tree/main/src/auth/Ownable.sol";

import {ERC20} from "https://github.com/saurabhnaoris/solmate/tree/main/src/tokens/ERC20.sol";

import {ERC20Boost} from "https://github.com/saurabhnaoris/2023-05-maia/tree/main/src/erc-20/ERC20Boost.sol";

import {IbHermesUnderlying} from "../interfaces/IbHermesUnderlying.sol";

/**
 * @title bHermesBoost: Earns rights to boosted Hermes yield
 *  @author Maia DAO (https://github.com/Maia-DAO)
 *  @notice An ERC20 with an embedded attachment mechanism to
 *          keep track of boost allocations to gauges.
 */
contract bHermesBoost is ERC20Boost, IbHermesUnderlying {
    /// @inheritdoc IbHermesUnderlying
    address public immutable bHermes;

    constructor(address _owner) ERC20("bHermes Boost", "bHERMES-B", 18) {
        _initializeOwner(_owner);
        bHermes = msg.sender;
    }

    /// @inheritdoc IbHermesUnderlying
    function mint(address to, uint256 amount) external onlybHermes {
        _mint(to, amount);
    }

    modifier onlybHermes() {
        if (msg.sender != bHermes) revert NotbHermes();
        _;
    }
}
