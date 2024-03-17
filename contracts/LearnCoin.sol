// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract LearningCoin is ERC20, AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant TEACHER_ROLE = keccak256("TEACHER_ROLE");

    constructor() ERC20("LearningCoin", "LRCN") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _mint(msg.sender, 1_000_000_000_000 * 10**18); // Preminting tokens
    }

    function mint(address to, uint256 amount) public onlyRole(ADMIN_ROLE) {
        _mint(to, amount);
    }

    function grantTeacherRole(address teacher) public onlyRole(ADMIN_ROLE) {
        _grantRole(TEACHER_ROLE, teacher);
    }

    function revokeTeacherRole(address teacher) public onlyRole(ADMIN_ROLE) {
        _revokeRole(TEACHER_ROLE, teacher);
    }
}

