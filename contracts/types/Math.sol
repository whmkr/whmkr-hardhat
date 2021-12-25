pragma solidity ^0.8.10;

enum MathType {
    ADD,
    SUB,
    MUL,
    DIV
}

error MathError(MathType math, uint256 a, uint256 b);
