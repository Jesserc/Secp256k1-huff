## Secp256k1 Curve Library In Huff

This is a Huff implementation of Secp256k1 curve based on the [LibSecp256k1 Solidity library](https://github.com/chronicleprotocol/scribe/blob/main/src/libs/LibSecp256k1.sol) by Chronicle Protocol.

### Interface

See: [ISecp256k1.sol](https://github.com/Jesserc/Secp256k1-hufff/blob/main/src/Interface/ISecp256k1.sol)

```solidity
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
```
