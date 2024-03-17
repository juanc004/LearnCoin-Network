// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SchoolTreasury is AccessControl {
    using SafeERC20 for IERC20;

    IERC20 public learningCoin;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant TEACHER_ROLE = keccak256("TEACHER_ROLE");

    mapping(address => uint256) public lastWithdrawTime;
    uint256 public constant TEACHER_WITHDRAW_LIMIT = 1000 * 10**18; // Example limit

    constructor(address _learningCoin) {
        require(_learningCoin != address(0), "Invalid token address");
        learningCoin = IERC20(_learningCoin);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
    }

        function withdrawTokens(address to, uint256 amount) public {
        require(hasRole(ADMIN_ROLE, msg.sender) || hasRole(TEACHER_ROLE, msg.sender), "Caller is not authorized");
        if(hasRole(TEACHER_ROLE, msg.sender)) {
            require(amount <= TEACHER_WITHDRAW_LIMIT, "Withdrawal amount exceeds limit");
            require(block.timestamp - lastWithdrawTime[msg.sender] >= 1 weeks, "Withdrawal too soon");
            lastWithdrawTime[msg.sender] = block.timestamp;
        }
        learningCoin.safeTransfer(to, amount);
    }

    // Admin can update the LearningCoin address if necessary
    function setLearningCoinAddress(address _newAddress) public onlyRole(ADMIN_ROLE) {
        require(_newAddress != address(0), "Invalid address");
        learningCoin = IERC20(_newAddress);
    }
}
