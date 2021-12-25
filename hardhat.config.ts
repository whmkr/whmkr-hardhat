import * as dotenv from "dotenv";
import { task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "hardhat-storage-layout";
import "@primitivefi/hardhat-dodoc";

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
task('storage-layout', "print storage layout diff")
  .setAction(async (args, hre) => {
    await hre.storageLayout.export();
  });

const config = {
  solidity: {
    compilers: [
      {
        version: "0.8.11",
        settings: {
          optimizer: {
            enabled: true,
            runs: 1000,
          },
        }
      },
    ],
  },
  networks: {
    mainnet: {
      url: process.env.MAINNET_URL || "",
      accounts:
      process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    ropsten: {
      url: process.env.ROPSTEN_URL || "",
      accounts:
      process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  dodoc: {
    runOnCompile: true
  },
};

export default config;
