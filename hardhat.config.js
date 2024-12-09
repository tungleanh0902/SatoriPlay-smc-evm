require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: __dirname + "/.env" });

const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    klaytn: {
      chainId: 1001,
      url: "https://kaia-kairos.blockpi.network/v1/rpc/public",
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      klaytn: "unnecessary",
    },
    customChains: [
      {
        network: "klaytn",
        chainId: 1001,
        urls: {
          apiURL: "https://api-baobab.klaytnscope.com/api",
          browserURL: "https://kairos.kaiascope.com"
        }
      }
    ]
  },
};
