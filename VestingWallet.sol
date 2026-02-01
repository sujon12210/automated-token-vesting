// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VestingWallet is Ownable {
    event TokensReleased(address token, uint256 amount);

    address public immutable beneficiary;
    uint256 public immutable start;
    uint256 public immutable duration;
    mapping(address => uint256) private _released;

    constructor(
        address _beneficiary,
        uint256 _startTimestamp,
        uint256 _durationSeconds
    ) Ownable(msg.sender) {
        require(_beneficiary != address(0), "Beneficiary is zero address");
        beneficiary = _beneficiary;
        start = _startTimestamp;
        duration = _durationSeconds;
    }

    function release(address token) public {
        uint256 releasable = vestedAmount(token, uint256(block.timestamp)) - _released[token];
        require(releasable > 0, "No tokens are due");

        _released[token] += releasable;
        IERC20(token).transfer(beneficiary, releasable);

        emit TokensReleased(token, releasable);
    }

    function vestedAmount(address token, uint256 timestamp) public view returns (uint256) {
        uint256 totalAllocation = IERC20(token).balanceOf(address(this)) + _released[token];

        if (timestamp < start) {
            return 0;
        } else if (timestamp >= start + duration) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start)) / duration;
        }
    }

    function released(address token) public view returns (uint256) {
        return _released[token];
    }
}
