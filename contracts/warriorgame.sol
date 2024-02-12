// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract WarGame is ERC20, Pausable, ReentrancyGuard {
    address public owner;

    constructor() ERC20("BB", "BattleBucks") {

        owner=msg.sender;
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "only owner can access");
        _;
    }

    mapping(address => uint[]) public warriorAssets;
    mapping(uint => GameItem) public gameItems;
    uint public totalItemTypes = 0;

    struct GameItem {
        string name;
        uint typeId;
        uint256 price;
    }

    event GameItemCreated(string name, uint typeId, uint256 price);
    event TokensMinted(address to, uint256 amount);
    event TokensBurned(address from, uint256 amount);
    event GameItemAcquired(address player, uint typeId, uint256 price);
    event ContractPaused(address pauser);
    event ContractUnpaused(address unpauser);

    modifier onlyValidItemType(uint typeId) {
        require(typeId > 0 && typeId <= totalItemTypes, "Invalid item type");
        _;
    }

    function mintBBTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function createGameItem(string memory name, uint256 price) external onlyOwner {
        totalItemTypes += 1;
        uint typeId = totalItemTypes;
        gameItems[typeId] = GameItem(name, typeId, price);
        emit GameItemCreated(name, typeId, price);
    }

    function getPlayerBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function acquireGameItem(uint typeId) external whenNotPaused nonReentrant onlyValidItemType(typeId) {
        require(balanceOf(msg.sender) >= gameItems[typeId].price, "Insufficient funds");
        approve(msg.sender, gameItems[typeId].price);
        transferFrom(msg.sender, address(this), gameItems[typeId].price);
        warriorAssets[msg.sender].push(gameItems[typeId].typeId);
        emit GameItemAcquired(msg.sender, typeId, gameItems[typeId].price);
    }

    function transferTokens(address to, uint256 amount) external whenNotPaused nonReentrant {
        require(balanceOf(msg.sender) >= amount, "Insufficient funds");
        approve(msg.sender, amount);
        transferFrom(msg.sender, to, amount);
    }

    function burnTokens(uint256 amount) external whenNotPaused nonReentrant {
        require(balanceOf(msg.sender) >= amount, "Insufficient funds");
        approve(msg.sender, amount);
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    // Additional functions for emergency pausing and resuming the contract
    function emergencyPause() external onlyOwner {
        _pause();
        emit ContractPaused(msg.sender);
    }

    function emergencyUnpause() external onlyOwner {
        _unpause();
        emit ContractUnpaused(msg.sender);
    }
}