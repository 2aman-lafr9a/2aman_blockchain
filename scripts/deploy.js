const { ethers } = require("hardhat");


async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(`Deploying contracts with the account: ${deployer.address}`);
  const MyToken = await ethers.getContractFactory("AgreementContract");
  const myToken = await MyToken.deploy();

  // Wait for the deployment to be confirmed
  await myToken.waitForDeployment();

  console.log(`AgreementContract deployed to: ${myToken.target}`);
}

main().catch((error) => {
  console.error("Error deploying AgreementContract:", error);
  process.exitCode = 1;
});
