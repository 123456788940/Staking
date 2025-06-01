require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    chiado: {
      url: process.env.Base_rpc_url,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
