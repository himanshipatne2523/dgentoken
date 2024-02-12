# Project Title

Welcome to the Battle Bucks

## Description

It is designed to represent a game-related token on the Ethereum blockchain. It utilizes the ERC-20 standard and incorporates features from the OpenZeppelin library, including Pausable and ReentrancyGuard. The contract is initialized with the deployment of the token "BB" (BattleBucks) with an initial supply of 1000 units. The contract owner is set to the deployer's address. The contract includes functionality for minting additional tokens, creating and acquiring game items, checking player balances, transferring tokens, and burning tokens.

The game items are defined by a struct named GameItem, which includes properties such as name, type ID, and price. The contract owner can create new game items and mint additional tokens. Players can acquire game items by spending their tokens, and the ownership of acquired items is tracked in the warriorAssets mapping. The contract also provides emergency pausing and unpausing functions, allowing the owner to halt contract operations if necessary. Events are emitted throughout various contract actions, such as the creation of game items, minting and burning tokens, acquiring game items, and emergency pausing/unpausing. Overall, the contract aims to facilitate token-based interactions within a gaming context while incorporating safety measures like pausing functionality.


### Installing

* Clone the github repo 
* Open it on vs code
* Paste the contract code in the Remix IDE

### Executing program

* Type npm install in the terminal
* type npm install hardhat
* type npx hardhat compile
* type npx hardhat run scripts/deploy.js --network fuji
* Copy the Deployed Contract Address.After the deployment script execution is complete, you will see output containing the deployed contract address. Copy this address.
* Paste the Deployed Address:
In the Remix IDE, navigate to the "Deploy & Run Transactions" tab and find the "At address" field. Paste the copied contract address into this field.



## Authors

Himanshi

## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
