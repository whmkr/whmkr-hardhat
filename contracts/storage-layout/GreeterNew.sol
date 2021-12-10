//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract GreeterNew {
    string public name;
    string private greetingnew;

    constructor(string memory _greeting) {
        greetingnew = _greeting;
    }

    function greet() public view returns (string memory) {
        return greetingnew;
    }

    function setGreeting(string memory _greeting) public {
        greetingnew = _greeting;
    }

    function setName(string memory _name) public {
        name = _name;
    }
}
