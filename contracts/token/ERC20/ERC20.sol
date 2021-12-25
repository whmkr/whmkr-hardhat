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

import "./IERC20.sol";

import "../../types/Balance.sol";

contract ERC20 is IERC20 {
    using BalanceMath for Balance;

    string public override name;

    string public override symbol;

    uint8 public immutable decimals;

    uint256 public override totalSupply;

    mapping(address => Balance) private _balances;

    mapping(address => mapping(address => uint256)) public override allowance;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function balanceOf(address _user) external view override returns(uint256 balance) {
        balance = Balance.unwrap(_balances[_user]);
    }

    function approve(address _spender, uint256 _amount) external override returns(bool success) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        success = true;
    }

    function transfer(address _to, uint256 _amount) external override returns(bool success) {
        success = _transfer(msg.sender, _to, Balance.wrap(_amount));
    }
    
    function transferFrom(address _from, address _to, uint256 _amount) external override returns(bool success) {
        uint256 allowed = allowance[_from][msg.sender];
        if(allowed < _amount) {
            revert LowAllowance({
                have : allowed,
                required : _amount
            });
        }
        allowance[_from][msg.sender] = allowed - _amount;
        emit Approval(_from, msg.sender, allowed - _amount);
        success = _transfer(_from, _to, Balance.wrap(_amount));
    }

    function _transfer(address _from, address _to, Balance _amount) internal returns(bool success) {
        _balances[_from] = _balances[_from].sub(_amount);
        _balances[_to] = _balances[_to].add(_amount);
        emit Transfer(_from, _to, Balance.unwrap(_amount));
        success = true;
    }
}
