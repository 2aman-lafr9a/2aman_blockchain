// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AgreementContract {
    address public teamManager;
    address public agency;
    address public aman;

    struct ContractDetails {
        uint256 offerPrice;
        string offerName;
    }

    ContractDetails public contractDetails;

    event ContractSigned(address teamManager, address agency, address aman, string offerName, uint256 offerPrice);


    constructor() {
        teamManager = msg.sender;
        aman = 0x1aC9b5E8731619803c755B729847268fb8961180; // Adresse statique
    }

    function signContract(address _agency, string memory _offerName, uint256 _offerPrice) external payable  {
        
        require(_agency != address(0), "Adresse d'agence invalide");
        require(teamManager != _agency, "Le gestionnaire d equipe et l agence ne peuvent pas avoir la meme adresse");
        require(_offerPrice > 0, "Le prix de l offre doit etre superieur a 0");

        uint256 commission = (_offerPrice * 10) / 100;
        require(commission > 0 , "Commission incorrecte");

        (bool transferToAmanSuccess, ) = payable(aman).call{value: commission}("");
        require(transferToAmanSuccess, "Echec du transfert a Aman");

        (bool transferToAgencySuccess, ) = payable(_agency).call{value: _offerPrice - commission}("");
        require(transferToAgencySuccess, "Echec du transfert a l agence");

        agency = _agency;
        contractDetails.offerName = _offerName;
        contractDetails.offerPrice = _offerPrice;

        emit ContractSigned(teamManager, agency, aman, _offerName, _offerPrice);
    }

    function getContractDetails() external view returns (address, address, address, uint256, string memory, string memory) {
        return (teamManager, agency, aman, contractDetails.offerPrice, contractDetails.offerName,"contract signed" );
    }
}
//0x5428d444F3BADf2b9C20648282EBBA38d4556AbA