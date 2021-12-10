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

contract ERC20 is IERC20 {
    string public override name;

    string public override symbol;

    uint8 public immutable decimals;

    uint256 public override totalSupply;

    mapping(address => uint256) private _balances;

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
        balance = _balances[_user];
    }

    function approve(address _spender, uint256 _amount) external override returns(bool success) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        success = true;
    }

    function transfer(address _to, uint256 _amount) external override returns(bool success) {
        success = _transfer(msg.sender, _to, _amount);
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
        success = _transfer(_from, _to, _amount);
    }

    function _transfer(address _from, address _to, uint256 _amount) internal returns(bool success) {
        uint256 balance = _balances[_from];
        if(balance < _amount) {
            revert LowBalance({
                have : balance,
                required : _amount
            });
        }
        _balances[_from] = balance - _amount;
        _balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        success = true;
    }
}
