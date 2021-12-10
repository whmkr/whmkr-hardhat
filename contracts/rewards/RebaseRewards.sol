/*
 ██╗    ██╗██╗  ██╗███╗   ███╗██╗  ██╗██████╗
 ██║    ██║██║  ██║████╗ ████║██║ ██╔╝██╔══██╗
 ██║ █╗ ██║███████║██╔████╔██║█████╔╝ ██████╔╝
 ██║███╗██║██╔══██║██║╚██╔╝██║██╔═██╗ ██╔══██╗
 ╚███╔███╔╝██║  ██║██║ ╚═╝ ██║██║  ██╗██║  ██║
  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
 */
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/ERC20/ERC20Rebase.sol";

/// @title RebaseRewards contract to use for rewarding stakers with deposit token(rewardToken == depositToken)
/// @author whmkr<whmkr@protonmail.com>
contract RebaseRewards is ERC20Rebase {
    
    event Deposit(address _user, uint256 _amount);
    event Withdraw(address _user, uint256 _amount);

    IERC20 public immutable depositToken;

    constructor(
        string memory _name,
        string memory _symbol,
        IERC20 _depositToken
    )
        ERC20Rebase(_name, _symbol, _depositToken.decimals(), 1e8)
    {
        depositToken = _depositToken;
    }

    function deposit(uint256 _amount) external {
        depositToken.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, _amount);
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external {
        depositToken.transfer(msg.sender, _amount);
        _burn(msg.sender, _amount);
        emit Withdraw(msg.sender, _amount);
    }

    function rebase(uint256 _rewardAmount) external {
        depositToken.transferFrom(msg.sender, address(this), _rewardAmount);
        _rebase(depositToken.balanceOf(address(this)));
    }
} 
