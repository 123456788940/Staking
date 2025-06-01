// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract foxToken is ERC20 {
    uint public constant price_per_token = 0.0001 ether;
    constructor() ERC20("Fox Token", "ft") {
        _mint(msg.sender, 100000000 * (10 ** 18));
    }

    function buy() external payable {
        require(msg.value>0, "value to be proper");
        uint amountToMint = (msg.value * 10 ** decimals());
        _mint(msg.sender, amountToMint);
    }

    
}