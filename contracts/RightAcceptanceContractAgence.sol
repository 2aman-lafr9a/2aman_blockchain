// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RightsAcceptanceContractAgence {
    address public owner;
    address public agence;
    

    struct AgenceInfo {
        string name;
        uint256 creationTime;
        string subscription_type;
        bool rightsAccepted ;
    }

    mapping(address => AgenceInfo) public agences;

    event RightsAccepted(address agence);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
      
    }

    function acceptRights(address _agence , string memory _name , uint  _type) external payable  {
       
        
        string memory subscription_type =" ";
         if(_type == 1){
            subscription_type = "Basic";
            require(msg.value >= 0 ether, "Payment should be at least 0 Ether");
            payable(owner).transfer(msg.value);
         }
         else if(_type == 2){
            subscription_type = "Premium";
            require(msg.value >= 0.3 ether, "Payment should be at least 0 Ether");
            
            payable(owner).transfer(msg.value);
         }
         else if(_type == 3){
            subscription_type = "Gold";
            require(msg.value >= 0.5 ether, "Payment should be at least 0 Ether");
            
            payable(owner).transfer(msg.value);
         }
        agence = _agence;
         require(!agences[_agence].rightsAccepted, "Rights already accepted");
        require(_agence != address(0), "Invalid team manager address");
        agences[_agence].rightsAccepted = true;
        agences[msg.sender].creationTime = block.timestamp;
        emit RightsAccepted(agence);
        agences[msg.sender].name = _name;
        agences[msg.sender].subscription_type = subscription_type;
    }


    function getAgenceInfoByAddress(address _agenceAddress) external view returns (string memory , uint256 , string memory) {
        require(_agenceAddress != address(0), "Invalid team manager address");
        return (
            agences[_agenceAddress].name,
            agences[_agenceAddress].creationTime,
            agences[_agenceAddress].subscription_type
            // Ajoutez d'autres champs d'information si nécessaire
        );
    }
}


//0x0705846c5223158fcC5621ed48668adeaDE5A8Cf