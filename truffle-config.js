require('babel-register');
require('babel-polyfill');
require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    goerli: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, 
        `https://goerli.infura.io/v3/${process.env.INFURA_API_KEY}`),
      network_id: 5,
      gas: 4000000,
      gasPrice: 40000000000
    },
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      optimizer: { 
        enabled: true,
        runs: 200
      },
      version: '^0.8.0'
    }
  }
}
