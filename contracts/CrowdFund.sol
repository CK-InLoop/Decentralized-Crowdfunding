// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFund {
    struct Campaign {
        address creator;
        string title;
        string description;
        uint goal;
        uint pledged;
        uint32 deadline;
        bool claimed;
    }

    uint public campaignCount;
    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    event CampaignCreated(uint id, address indexed creator, string title, uint goal, uint32 deadline);
    event Pledged(uint indexed campaignId, address indexed caller, uint amount);
    event Claimed(uint indexed campaignId);
    event Refunded(uint indexed campaignId, address indexed caller, uint amount);

    function createCampaign(string calldata title, string calldata description, uint goal, uint32 duration) external {
        require(goal > 0, "Goal must be > 0");
        require(duration > 0, "Duration must be > 0");
        uint32 deadline = uint32(block.timestamp + duration);
        campaigns[campaignCount] = Campaign({
            creator: msg.sender,
            title: title,
            description: description,
            goal: goal,
            pledged: 0,
            deadline: deadline,
            claimed: false
        });
        emit CampaignCreated(campaignCount, msg.sender, title, goal, deadline);
        campaignCount++;
    }

    function donate(uint campaignId) external payable {
        Campaign storage c = campaigns[campaignId];
        require(block.timestamp < c.deadline, "Campaign ended");
        require(msg.value > 0, "No ETH sent");
        c.pledged += msg.value;
        pledgedAmount[campaignId][msg.sender] += msg.value;
        emit Pledged(campaignId, msg.sender, msg.value);
    }

    function claim(uint campaignId) external {
        Campaign storage c = campaigns[campaignId];
        require(msg.sender == c.creator, "Not creator");
        require(block.timestamp >= c.deadline, "Not ended");
        require(c.pledged >= c.goal, "Goal not reached");
        require(!c.claimed, "Already claimed");
        c.claimed = true;
        (bool sent, ) = payable(c.creator).call{value: c.pledged}();
        require(sent, "Failed to send");
        emit Claimed(campaignId);
    }

    function refund(uint campaignId) external {
        Campaign storage c = campaigns[campaignId];
        require(block.timestamp >= c.deadline, "Not ended");
        require(c.pledged < c.goal, "Goal reached");
        uint bal = pledgedAmount[campaignId][msg.sender];
        require(bal > 0, "No funds to refund");
        pledgedAmount[campaignId][msg.sender] = 0;
        (bool sent, ) = payable(msg.sender).call{value: bal}();
        require(sent, "Refund failed");
        emit Refunded(campaignId, msg.sender, bal);
    }
}
