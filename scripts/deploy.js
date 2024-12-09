const hre = require("hardhat");

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
   // Unit Deploy&Verify MinimalForwarder contract
  const Badge = await ethers.getContractFactory("Badge");
  const badge = await Badge.deploy("Satori Premium", "SP", "https://res.cloudinary.com/dbcbybvd7/raw/upload/v1731378933/nft_collection_fzxus9.json");
  await badge.waitForDeployment();
  console.log("FruitVoting deployed to:", badge.target);
  await sleep(1000);
  await hre.run("verify:verify", {
    address: badge.target,
    contract: "contracts/Badge.sol:Badge",
    constructorArguments: ["Satori Premium", "SP", "https://res.cloudinary.com/dbcbybvd7/raw/upload/v1731378933/nft_collection_fzxus9.json"]
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
