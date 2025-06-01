// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract staking {
    address public owner;
    IERC20 public token;
    mapping(address=>uint) public staked_amount;
   

    constructor(address _token) {
       owner = msg.sender;
       token = IERC20(_token);
    }

  

    function _stake(uint _amount) external  {
        require(_amount>=100, "amount should be either equal to or more than 100");
        token.transferFrom(msg.sender, address(this), _amount);
        staked_amount[msg.sender] += _amount;
      



    }

    function Unstake(uint _amount) external {
        require(_amount>0, "amount should be valid");
        require(staked_amount[msg.sender] >= _amount, "user should not be able to unstake more than the staked balance");
        token.transfer(msg.sender, _amount);
        staked_amount[msg.sender] -= _amount;

    }

    function getStake(address user) external view returns(uint) {
        return staked_amount[user];
    }

}