async function main() {

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address );

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Wargame = await ethers.getContractFactory("WarGame");
  const contract = await Wargame.deploy();

  console.log("Contract deployed at:", contract.address);
}

main()
.then(() => process.exit(0))
.catch(error => {
  console.error(error);
  process.exit(1);
});