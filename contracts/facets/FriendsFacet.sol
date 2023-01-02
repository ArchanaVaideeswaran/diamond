// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract FriendsFacet{
  error PersonNotFound();
  function addFriends(uint _personId, uint[] memory _friendsIds) external {
    LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
    if(ds.persons[_personId].wallet == address(0)) revert PersonNotFound(); 
    for(uint i = 0; i < _friendsIds.length; i++) {
      if(ds.persons[_friendsIds[i]].wallet == address(0)) revert PersonNotFound();
      ds.friends[_personId].push(_friendsIds[i]);
    }
  }
}