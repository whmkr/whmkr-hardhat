pragma solidity ^0.8.10;

import { MathError, MathType } from "./Math.sol";

type Balance is uint256;

error LowBalance(Balance have, Balance required);

library BalanceMath {
    function add(Balance a, Balance b) internal pure returns(Balance) {
        unchecked {
            if(Balance.unwrap(a) + Balance.unwrap(b) < Balance.unwrap(a)) {
                revert MathError(MathType.ADD, Balance.unwrap(a), Balance.unwrap(b));
            }
            return Balance.wrap(
                Balance.unwrap(a) + Balance.unwrap(b)
            );
        }
    }

    function sub(Balance a, Balance b) internal pure returns(Balance) {
        unchecked {
            if(Balance.unwrap(a) < Balance.unwrap(b)) {
                revert LowBalance(a, b);
            }
            return Balance.wrap(
                Balance.unwrap(a) - Balance.unwrap(b)
            );
        }
    }

    function mul(Balance a, uint256 b) internal pure returns(Balance) {
        unchecked {
            if(Balance.unwrap(a) * b < b) {
                revert MathError(MathType.MUL, Balance.unwrap(a), b);
            }
            return Balance.wrap(
                Balance.unwrap(a) * b
            );
        }
    }

    function div(Balance a, uint256 b) internal pure returns(Balance) {
        unchecked {
            if(b == 0) {
                revert MathError(MathType.DIV, Balance.unwrap(a), b);
            }
            return Balance.wrap(
                Balance.unwrap(a) / b
            );
        }
    }
}
