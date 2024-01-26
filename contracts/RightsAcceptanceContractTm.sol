// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RightsAcceptanceContractTM {
    address public owner;
    address public teamManager;
    TeamManagerInfo public teamManagerInfo;
    
    
    string public terms="User Wallet Address: By using our services, you agree to provide and store your cryptocurrency wallet address with DAMAN for transaction and service-related purposes. ";

    struct TeamManagerInfo {
        string name;
        uint256 creationTime;
        bool rightsAccepted ;
    }

    mapping(address => TeamManagerInfo) public teamManagers;

    event RightsAccepted(address teamManager);

    constructor() {
        owner = msg.sender;
    }

    function acceptRights(address _teamManager , string memory _name) external {
        
        teamManager = _teamManager;
        require(!teamManagers[_teamManager].rightsAccepted, "Rights already accepted");
        require(_teamManager != address(0), "Invalid team manager address");
        teamManagers[_teamManager].name = _name;
        teamManagers[_teamManager].rightsAccepted = true;
        teamManagers[_teamManager].creationTime = block.timestamp;
        
        emit RightsAccepted(teamManager);
    }


    function getTeamManagerInfoByAddress(address _teamManagerAddress) external view returns (string memory , uint256) {
        require(_teamManagerAddress != address(0), "Invalid team manager address");
        return (
            teamManagers[_teamManagerAddress].name ,
            teamManagers[_teamManagerAddress].creationTime);
    }
}


//0x5291E4cB954569b70A1Dbd032FE38748AbbdFA35