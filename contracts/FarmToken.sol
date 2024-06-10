// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FarmToken is ERC20 {
    address public admin;

    constructor() ERC20("FarmToken", "FTK") {
        admin = msg.sender;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin can mint tokens");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        require(msg.sender == admin, "Only admin can burn tokens");
        _burn(from, amount);
    }

    function transferAdmin(address newAdmin) external {
        require(msg.sender == admin, "Only admin can transfer admin role");
        admin = newAdmin;
    }
}
