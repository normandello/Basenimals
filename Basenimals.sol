// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BasenimalsToken is ERC20 {
    address public owner;
    uint256 public totalContributions;
    mapping(address => uint256) public contributions;

    constructor() ERC20("Basenimals Token", "BANI") {
        owner = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function contribute(uint256 amount) external {
        require(amount > 0, "Contribution amount must be greater than 0");
        _mint(msg.sender, amount);
        contributions[msg.sender] += amount;
        totalContributions += amount;
    }

    function burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
    }

    function transferOwnership(address newOwner) external {
        require(msg.sender == owner, "Only owner can transfer ownership");
        owner = newOwner;
    }
}
