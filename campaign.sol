// SPDX-License-Identifier: MIT   
pragma solidity^0.8.4;

contract CampaignFactory{
    address[] deployedCampaigns;
    
    
    function createCampaign (uint minimum) public {
        address newCampaign = address(new Campaign(minimum, msg.sender));
        deployedCampaigns.push(newCampaign);
    }
    
    function getDeployedCampaigns () public view returns (address[] memory) {
        return deployedCampaigns;
    }
}

contract Campaign{
    
    struct Request {
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
        mapping(address=>bool) approvals;
    }
    uint numRequests;
    mapping (uint => Request) requests;
    address public manager;
    uint public minimumContribution;
    mapping (address => bool) public approvers;
    uint public approversCount;
    
    constructor(uint c, address creator) public {
        manager = creator;
        minimumContribution = c;
    }
    
    function contribute() public payable {
        require(msg.value > minimumContribution);
        if(!approvers[msg.sender]){
            approversCount++;
        }
        approvers[msg.sender] = true;
    }
    
    function createRequest (string memory description, uint value, address payable recipient) public{
                Request storage r = requests[numRequests++];
                r.description = description;
                r.value = value;
                r.recipient = recipient;
                r.complete = false;
                r.approvalCount = 0;
            
        }
    
    function approveRequest (uint index) public {
        
        Request storage request = requests[index];
        
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        require(request.approvalCount > approversCount/2);
        require(!request.complete);
        
        
        request.recipient.transfer(request.value);
        request.complete = true;
    }
    
    function getSummary() public view returns(uint, uint, uint, uint, address){
        return(
            minimumContribution,
            address(this).balance,
            numRequests,
            approversCount,
            manager
        );
    }
    
    function getRequestsCount() public view returns(uint) {
        return numRequests;
    }
    
    modifier restricted {
        require(msg.sender == manager);
        _;
    }
    
    
}
