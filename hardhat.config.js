require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */


const ALCHEMY_API_KEY = "H-FwX251cT9bcftFtBV-Ah4Fe3mu6oPB";
const SEPOLIA_PRIVATE_KEY = "432802b1319fdfa0546e25618a6bf564558d47e05a98ec508d084b928af18c82";
module.exports = {
  solidity: "0.8.20",
  etherscan: {
    apiKey: "QJKREJYZHNCWFI2JCEWHH7SSAJ7AWZUF87",
    
  },
  networks: {
    sepolia:{
      url:`https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts:[SEPOLIA_PRIVATE_KEY]
    }
  }
};



