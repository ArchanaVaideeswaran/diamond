// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";

contract PersonFacet {
  using Counters for Counters.Counter;

  event PersonAdded(uint id, address wallet, string name, uint8 age);
  function addPerson(address _wallet, string memory _name, uint8 _age) external {
    LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
    Counters.Counter storage _personCounter = ds.personCounter;
    _personCounter.increment();
    uint personId = _personCounter.current();
    LibDiamond.Person storage _person = ds.persons[personId];
    _person.id = personId;
    _person.wallet = _wallet;
    _person.name = _name;
    _person.age = _age;

    emit PersonAdded(personId, _wallet, _name, _age);
  }
}