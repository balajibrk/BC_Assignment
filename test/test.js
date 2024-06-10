async function main() {
  const [deployer, farmer1, farmer2, farmer3] = await ethers.getSigners();

  const FarmToken = await ethers.getContractFactory("FarmToken");
  const farmToken = await FarmToken.deploy();
  await farmToken.deployed();

  const VotingManager = await ethers.getContractFactory("VotingManager");
  const votingManager = await VotingManager.deploy();
  await votingManager.deployed();

  // Propose a solution
  await votingManager
    .connect(farmer1)
    .proposeSolution("Solution for pest control");
  console.log("Solution proposed by farmer1");

  // Vote on the solution
  await votingManager.connect(farmer2).vote(1, true);
  console.log("Farmer2 voted positively");

  await votingManager.connect(farmer3).vote(1, true);
  console.log("Farmer3 voted positively");

  // Verify the solution
  await votingManager.connect(deployer).verifySolution(1);
  console.log("Solution verified");

  // Reward the proposer
  await farmToken.mint(farmer1.address, ethers.utils.parseUnits("100.0", 18));
  console.log("Reward minted to farmer1");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
