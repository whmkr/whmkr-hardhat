//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GreeterNew {
    struct A {
        uint128 a;
        uint64 b;
        bool c;
        uint128 d;
    }
    string public name;
    string private greeting;

    A public a;

    uint256 public count;

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
        a = A({
            a:1,
            b:2,
            c: true,
            d:128
        });
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }

    function setName(string memory _name) public {
        name = _name;
    }
}
