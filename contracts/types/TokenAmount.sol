pragma solidity ^0.8.10;

import { MathError, MathType } from "./Math.sol";

type TokenAmount is uint256;

error LowTokenAmount(TokenAmount have, TokenAmount required);

library TokenAmountMath {
    function add(TokenAmount a, TokenAmount b) internal pure returns(TokenAmount) {
        unchecked {
            if(TokenAmount.unwrap(a) + TokenAmount.unwrap(b) < TokenAmount.unwrap(a)) {
                revert MathError(MathType.ADD, TokenAmount.unwrap(a), TokenAmount.unwrap(b));
            }
            return TokenAmount.wrap(
                TokenAmount.unwrap(a) + TokenAmount.unwrap(b)
            );
        }
    }

    function sub(TokenAmount a, TokenAmount b) internal pure returns(TokenAmount) {
        unchecked {
            if(TokenAmount.unwrap(a) < TokenAmount.unwrap(b)) {
                revert LowTokenAmount(a, b);
            }
            return TokenAmount.wrap(
                TokenAmount.unwrap(a) - TokenAmount.unwrap(b)
            );
        }
    }

    function mul(TokenAmount a, uint256 b) internal pure returns(TokenAmount) {
        unchecked {
            if(TokenAmount.unwrap(a) * b < b) {
                revert MathError(MathType.MUL, TokenAmount.unwrap(a), b);
            }
            return TokenAmount.wrap(
                TokenAmount.unwrap(a) * b
            );
        }
    }

    function div(TokenAmount a, uint256 b) internal pure returns(TokenAmount) {
        unchecked {
            if(b == 0) {
                revert MathError(MathType.DIV, TokenAmount.unwrap(a), b);
            }
            return TokenAmount.wrap(
                TokenAmount.unwrap(a) / b
            );
        }
    }
}
