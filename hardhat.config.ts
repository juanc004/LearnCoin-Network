import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
// import "dotenv/config";

const { PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    sepolia: {
      url: "",
      // accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  solidity: "0.8.24",
};

export default config;
