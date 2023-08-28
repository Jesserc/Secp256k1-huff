// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface ISecp256k1 {
    struct Point {
        uint256 x;
        uint256 y;
    }

    struct JacobianPoint {
        uint256 x;
        uint256 y;
        uint256 z;
    }

    function isOnCurveSecp25k1Curve(uint256 x, uint256 y) external pure returns (bool);
    function isOnCurve(uint256 a, uint256 b, uint256 p, uint256 x, uint256 y) external pure returns (bool);
    function ZERO_POINT() external pure returns (Point memory);
    function G_POINT() external pure returns (Point memory);
    function OrderOfSecp256k1Curve() external pure returns (uint256);
    function yParity(uint256 x, uint256 y) external pure returns (uint256);
    function isZeroPoint(uint256 x, uint256 y) external pure returns (bool);
    function toAddress(uint256 x, uint256 y) external pure returns (address);
    function toJacobian(uint256 x, uint256 y) external pure returns (JacobianPoint memory);
    function toAffine(uint256 x, uint256 y, uint256 z) external pure returns (Point memory);
}
