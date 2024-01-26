// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AgreementContract {
    address public teamManager;
    address public agency;
    address public AmanAccount;
    uint256 public offerPrice;
    string public offerName;
    bool public contractSigned;

    event ContractSigned(address teamManager, address agency, string offerName, uint256 offerPrice);

    modifier onlyTeamManager() {
        require(msg.sender == teamManager, "Only team manager can call this function");
        _;
    }

    constructor() {
        teamManager = msg.sender;
        AmanAccount = 0x1aC9b5E8731619803c755B729847268fb8961180; // Adresse statique
        contractSigned = false;
    }

    // Fonction appelée par le Team Manager pour signer le contrat
    function signContract(address _agency, string memory _offerName, uint256 _offerPrice) external payable {
        require(!contractSigned, "Contract already signed");
        require(_agency != address(0), "Invalid agency address");
        require(teamManager != _agency, "Team manager and agency cannot be the same address");
        require(_offerPrice > 0, "Offer price should be greater than 0");
        // Vous pouvez ajouter d'autres vérifications ici en fonction de vos besoins

        // Calculer la commission (10% du prix de l'offre)
        uint256 commission = (_offerPrice * 10) / 100;
        require(commission > 0, "Commission should be greater than 0");

        // Vérifier que la valeur envoyée est égale à la commission
        require(msg.value == commission, "Incorrect commission amount sent");

        // Effectuer le transfert de la commission à l'adresse AmanAccount
        (bool transferToAmanSuccess, ) = payable(AmanAccount).call{value: commission}("");
        require(transferToAmanSuccess, "Failed to transfer commission to AmanAccount");

        // Calculer le montant à transférer à l'agence (prix de l'offre)
        uint256 amountToAgency = _offerPrice ;

        // Effectuer le transfert de l'argent à l'adresse de l'agence
        (bool transferToAgencySuccess, ) = payable(_agency).call{value: amountToAgency}("");
        require(transferToAgencySuccess, "Failed to transfer amount to agency");

        // Mettre à jour les variables de contrat
        agency = _agency;
        offerName = _offerName;
        offerPrice = _offerPrice;
        contractSigned = true;

        // Émettre l'événement pour notifier la signature du contrat
        emit ContractSigned(teamManager, agency, offerName, offerPrice);
    }

    // Fonction pour récupérer les détails du contrat
    function getContractDetails() external view returns (address, address, address, string memory, uint256, bool) {
        return (teamManager, agency, AmanAccount, offerName, offerPrice, contractSigned);
    }
}


//0x1e07ABcC3222F04Ac5c065598F05a7bd645E0a9f