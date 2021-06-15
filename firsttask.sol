// SPDX-License-Identifier: MIT   
pragma solidity^0.8.4;

contract PartyFactory{
    address[] listParty;
    
    
    function createParty (uint minimum) public {
        address newParty = address(new Party(minimum, msg.sender));
        listParty.push(newParty);
    }
    
    function getListParty () public view returns (address[] memory) {
        return listParty;
    }
}

contract Party{
    
    struct Request {
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
        mapping(address=>bool) approvals;
    }
    mapping (uint => Request) requests;
    address public manager;
    uint minimumContribution;
    mapping (address => bool) member;
    uint contributor;
    address[] memberList;
    
    constructor(uint contribution, address creator) public {
        manager = creator;
        minimumContribution = contribution;
    }
    function contribute() public payable {
        require(msg.value > minimumContribution);
        if(!member[msg.sender]){
            memberList.push(msg.sender);
        }
        member[msg.sender] = true;
    }
    function getSummary() public view returns(uint, uint, uint, address){
        return(
            minimumContribution,
            address(this).balance,
            contributor,
            manager
        );
    }
    function getMemberList() public view returns (address[] memory){
        return memberList;
    }
    modifier onlyManager {
        require(msg.sender == manager);
        _;
    }
}
