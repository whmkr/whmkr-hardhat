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

import "../../types/TokenAmount.sol";

contract ERC20 is IERC20 {
    using TokenAmountMath for TokenAmount;

    string public override name;

    string public override symbol;

    uint8 public immutable decimals;

    uint256 public override totalSupply;

    mapping(address => TokenAmount) private _balances;

    mapping(address => mapping(address => TokenAmount)) private _allowances;

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
        balance = TokenAmount.unwrap(_balances[_user]);
    }

    function allowance(address _owner, address _spender) external view override returns(uint256){
        return TokenAmount.unwrap(_allowances[_owner][_spender]);
    }

    function approve(address _spender, uint256 _amount) external override returns(bool success) {
        _allowances[msg.sender][_spender] = TokenAmount.wrap(_amount);
        emit Approval(msg.sender, _spender, _amount);
        success = true;
    }

    function transfer(address _to, uint256 _amount) external override returns(bool success) {
        success = _transfer(msg.sender, _to, TokenAmount.wrap(_amount));
    }
    
    function transferFrom(address _from, address _to, uint256 _amount) external override returns(bool success) {
        _allowances[_from][msg.sender] = _allowances[_from][msg.sender].sub(TokenAmount.wrap(_amount));
        emit Approval(_from, msg.sender, TokenAmount.unwrap(_allowances[_from][msg.sender]));
        success = _transfer(_from, _to, TokenAmount.wrap(_amount));
    }

    function _transfer(address _from, address _to, TokenAmount _amount) internal returns(bool success) {
        _balances[_from] = _balances[_from].sub(_amount);
        _balances[_to] = _balances[_to].add(_amount);
        emit Transfer(_from, _to, TokenAmount.unwrap(_amount));
        success = true;
    }
}
