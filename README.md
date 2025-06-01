 Fox Staking dApp – Contracts Overview

This repository includes two smart contracts:

foxToken: A custom ERC20 token with a buy() function to mint tokens in exchange for Ether.

staking: A staking contract where users can stake and unstake foxToken.

📄 foxToken.sol – ERC20 Token with Buy Functionality
solidity
Copy
Edit
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
SPDX-License-Identifier: License declaration to avoid compiler warnings.

pragma solidity ^0.8.0: Ensures the contract is compiled with Solidity version 0.8.0 or above.

ERC20: OpenZeppelin’s implementation of the ERC20 token standard.

✅ Contract Overview
solidity
Copy
Edit
contract foxToken is ERC20 {
    uint public constant price_per_token = 0.0001 ether;
Inherits ERC20 behavior.

Sets a fixed price for each token (not currently used in buy, but reserved for future logic).

solidity
Copy
Edit
constructor() ERC20("Fox Token", "ft") {
    _mint(msg.sender, 100000000 * (10 ** 18));
}
Initializes the token with the name "Fox Token" and symbol "ft".

Mints an initial supply of 100 million tokens to the contract deployer.

💸 buy() Function
solidity
Copy
Edit
function buy() external payable {
    require(msg.value > 0, "value to be proper");
    uint amountToMint = (msg.value * 10 ** decimals());
    _mint(msg.sender, amountToMint);
}
payable: Allows the function to accept Ether.

Validates that the user sends some Ether.

Calculates the number of tokens to mint based on the Ether sent (1 ETH → 1e18 tokens).

Mints tokens directly to the sender's wallet.

📝 Note: You can later multiply msg.value by a custom price_per_token for real-world use.

📄 staking.sol – Token Staking Contract
solidity
Copy
Edit
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
Uses OpenZeppelin’s ERC20 interface for safe interaction with the token.

✅ Contract Overview
solidity
Copy
Edit
contract staking {
    address public owner;
    IERC20 public token;
    mapping(address => uint) public staked_amount;
owner: Admin address (typically the deployer).

token: The ERC20 token being staked (foxToken).

staked_amount: Tracks how many tokens each user has staked.

solidity
Copy
Edit
constructor(address _token) {
    owner = msg.sender;
    token = IERC20(_token);
}
Initializes the contract with the staking token's address.

📥 _stake() Function
solidity
Copy
Edit
function _stake(uint _amount) external {
    require(_amount >= 100, "amount should be either equal to or more than 100");
    token.transferFrom(msg.sender, address(this), _amount);
    staked_amount[msg.sender] += _amount;
}
Requires a minimum stake of 100 tokens.

Transfers tokens from the user to the contract.

Updates the user’s stake balance.

🔒 Make sure users approve the staking contract beforehand using approve() in the token contract.

📤 Unstake() Function
solidity
Copy
Edit
function Unstake(uint _amount) external {
    require(_amount > 0, "amount should be valid");
    require(staked_amount[msg.sender] >= _amount, "user should not be able to unstake more than the staked balance");
    token.transfer(msg.sender, _amount);
    staked_amount[msg.sender] -= _amount;
}
Allows users to unstake some or all of their tokens.

Validates they don't unstake more than they’ve staked.

Transfers tokens back to the user.

🔍 getStake() Function
solidity
Copy
Edit
function getStake(address user) external view returns (uint) {
    return staked_amount[user];
}
Allows anyone to view the staked balance of any user.

✅ How to Use (Summary)
Deploy foxToken.sol – You'll receive initial supply and enable token buying with Ether.

Deploy staking.sol – Pass the foxToken address to the constructor.

Buy tokens – Call buy() and send Ether.

Approve staking contract – From user wallet, call approve(staking_contract_address, amount).

Stake tokens – Call _stake(amount) on the staking contract.

Unstake tokens – Call Unstake(amount).

📦 Technologies Used
Solidity ^0.8.0

OpenZeppelin Contracts

MetaMask / WalletConnect

Hardhat / Ethers.js (for deployment and interaction)

