//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GreeterNew {
    string public name;
    string private greetingnew;

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greetingnew = _greeting;
    }

    function greet() public view returns (string memory) {
        return greetingnew;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greetingnew, _greeting);
        greetingnew = _greeting;
    }

    function setName(string memory _name) public {
        name = _name;
    }
}
