require("dotenv").config();
const { ethers } = require("hardhat");

  async function main() {
      // Deploy FoxToken
    const Token = await ethers.getContractFactory("foxToken");
    const token = await Token.deploy();
    await token.deployed();
    console.log("foxToken deployed at:", token.address);
     // Deploy Staking with token address
    const Staking = await ethers.getContractFactory("staking");
    const staking = await Staking.deploy(token.address);
    await staking.deployed();
    console.log("staking contract deployed at:", staking.address);
  }

  main().catch((error)=> {
    console.error(error);
    process.error(1);
  })
 


