require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();
const FUJI_URL = process.env.FUJI_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
 
  solidity: "0.8.9",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData
    },
    fuji: {
      url: FUJI_URL,
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [PRIVATE_KEY]
    },
    mainnet: {
      url:FUJI_URL,
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [PRIVATE_KEY]
    }
  }
}