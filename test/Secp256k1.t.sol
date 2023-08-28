// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {HuffConfig} from "foundry-huff/HuffConfig.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./utils/NonMatchingSelectorHelper.sol";
import {ISecp256k1} from "../src/Interface/ISecp256k1.sol";

contract Secp256k1Test is Test, NonMatchingSelectorHelper {
    ISecp256k1 public secp256k1;

    function setUp() public {
        secp256k1 = ISecp256k1(HuffDeployer.config().deploy("Secp256k1"));
    }

    function testIsOnCurve() public {
        // Curve with a=2 and b=4: (0, 2)
        bool result = secp256k1.isOnCurve(2, 4, 17, 0, 2);
        assertEq(result, true);

        // secp256k1 curve with isOnCurve
        bool result2 = secp256k1.isOnCurve(
            uint256(0x0000000000000000000000000000000000000000000000000000000000000000),
            uint256(0x0000000000000000000000000000000000000000000000000000000000000007),
            uint256(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F),
            uint256(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798),
            uint256(0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8)
        );
        assertEq(result2, true);
    }

    function testIsOnCurveSecp25k1Curve() public {
        bool result3 = secp256k1.isOnCurveSecp25k1Curve(
            uint256(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798),
            uint256(0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8)
        );
        assertEq(result3, true);
    }

    function testZeroPoint() public view {
        ISecp256k1.Point memory p = secp256k1.ZERO_POINT();
        console.log(p.x);
        console.log(p.y);
    }

    function testGPoint() public view {
        ISecp256k1.Point memory g = secp256k1.G_POINT();
        console.log(g.x);
        console.log(g.y);
    }

    function testOrderOfSecp256k1Curve() public view {
        uint256 n = secp256k1.OrderOfSecp256k1Curve();
        console.logUint(n);
    }

    function testYParity() public {
        uint256 parity = secp256k1.yParity(
            0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
            0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
        );

        assertEq(parity, 0); // even numbers - last byte returns 0, odd returns 1
        console.logUint(parity);
    }

    function testisZeroPoint() public {
        bool result = secp256k1.isZeroPoint(0, 0);
        assertTrue(result);
    }

    function testToAddress() public {
        address addr = secp256k1.toAddress(
            0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
            0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
        );
        console.logAddress(addr);
    }

    function testToJacobian() public {
        ISecp256k1.JacobianPoint memory jacobian = secp256k1.toJacobian(
            0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
            0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
        );
    }

    function testToAffine() public {
        ISecp256k1.Point memory affine = secp256k1.toAffine(
            0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
            0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8,
            1
        );

        emit log_named_uint("Main AffinePoint.x", affine.x);
        emit log_named_uint("Main AffinePoint.y", affine.y);
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = ISecp256k1.isOnCurve.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(secp256k1));
        assert(!success);
    }
}
