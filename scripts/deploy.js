async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const FarmToken = await ethers.getContractFactory("FarmToken");
  const farmToken = await FarmToken.deploy();
  await farmToken.deployed();
  console.log("FarmToken deployed to:", farmToken.address);

  const VotingManager = await ethers.getContractFactory("VotingManager");
  const votingManager = await VotingManager.deploy();
  await votingManager.deployed();
  console.log("VotingManager deployed to:", votingManager.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
