// MyToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract Simple {
    
   string internal  myCity = "Rabat";
   function getMyCity() public view returns(string memory){
       return myCity;
   }
   function SetMyCity(string memory _newCity) public {
       myCity = _newCity;
   }

}