pragma solidity 0.8.23;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }
}

// General purpose per-address rate limiter
// Requires an offchain sybil protection mechanism (e.g. WorldID) to prevent abuse
contract RateLimiter is Ownable {
    uint256 public rateLimitPeriodSeconds = 10 minutes;

    mapping(address user => uint256 timestamp) public lastUsed;

    function logUsage(address user) external onlyOwner {
        lastUsed[user] = block.timestamp;
    }

    function canUse(address user) public view returns (bool) {
        uint256 timestamp = lastUsed[user];
        if (timestamp == 0) {
            return true;
        }
        return block.timestamp - timestamp < rateLimitPeriodSeconds;
    }
}
