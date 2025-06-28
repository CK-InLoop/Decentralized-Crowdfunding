require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

const { PRIVATE_KEY, GOERLI_RPC_URL, SEPOLIA_RPC_URL } = process.env;

module.exports = {
  solidity: "0.8.20",
  networks: {
    hardhat: {},
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    },
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    },
  },
};
