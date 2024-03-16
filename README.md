# Hyperdeploy Contracts

## Development

```sh
bun i
bun run build
```

## Deployment

```sh
bun run deploy:router
```

Manually update the BytecodeRouter address in the `script/Deploy.s.sol` file.

```sh
bun run deploy:handler
```

## Example

- source chain (sepolia):
  https://sepolia.etherscan.io/tx/0x8715936d6033a0bee64e333b3d04914606da9312ec02b0f0fc4ea9ed8ba516a9
- deployment on scroll sepolia:
  https://sepolia.scrollscan.com/tx/0x7768913db67d7d795a713a8857f3f36831801b2ced118b633626b215e335b5b0
- deployment on polygon matic:
  https://mumbai.polygonscan.com/tx/0x064fbe0edbbbdca0672ab5d3daf7230d7a4876b738b26a81d067cfac220c02bf
