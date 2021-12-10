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

contract ERC20Rebase is IERC20 {

    event LogRebase(uint64 oldIndex, uint64 newInex);

    string public override name;
    
    string public override symbol;

    uint8 public immutable decimals;

    // balanceOf(user) = userGon[_user] / index;
    uint64 public index;

    // totalSupply() = totalGon / index;
    uint256 public totalGon;

    mapping(address => uint256) public userGon;

    mapping(address => mapping(address => uint256)) public override allowance;
    
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint64 _initialIndex
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        index = _initialIndex;
    }

    function totalSupply() external view override returns(uint256) {
        return totalGon / uint256(index);
    }

    function balanceOf(address _user) public view override returns(uint256) {
        return userGon[_user] / uint256(index);
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
        uint256 gonChange = _amount * index;
        uint256 gonHave = userGon[_from];
        if(gonHave < gonChange) {
            revert LowBalance({
                have : gonHave / index,
                required : _amount
            });
        }
        userGon[_from] = gonHave - gonChange;
        userGon[_to] += gonChange;
        emit Transfer(_from, _to, _amount);
        success = true;
    }

    function _mint(address _beneficiary, uint256 _amount) internal {
        totalGon += _amount * index;
        userGon[_beneficiary] += _amount * index;
        emit Transfer(address(0), _beneficiary, _amount);
    }
    
    function _burn(address _target, uint256 _amount) internal {
        totalGon -= _amount * index;
        userGon[_target] -= _amount * index;
        emit Transfer(_target, address(0), _amount);
    }

    function _rebase(uint256 _newTotalSupply) internal {
        uint64 oldIndex = index;
        index = uint64(totalGon / _newTotalSupply);
        emit LogRebase(oldIndex, index);
    }
}
