const path = require("path");
const { mnemonic, API_KEY } = require('./secrets.json');
var HDWalletProvider = require("./node_modules/truffle-hdwallet-provider");

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
      gas: 5000000
    },

    ropsten: {
      provider: () => {
        return new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/v3/' + API_KEY)
      },
      network_id: 3,
      gas: 4000000
    },

    rinkeby: {
      provider: () => {
        return new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/v3/' + API_KEY)
      },
      network_id: 4,
      gas: 4000000
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0",
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 200      // Default: 200
        },
      }
    }
  }
};

