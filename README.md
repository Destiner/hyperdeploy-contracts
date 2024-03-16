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
  https://sepolia.etherscan.io/tx/0x3d0304b5a459ad9a96566a869dd027729cd4921744dc9df705c8f4f10c118597
- deployment on scroll sepolia:
  https://sepolia.scrollscan.com/tx/0xd2307bd56123b24a121233dbfffb0b2f35c9f5a4d4fbe69710f095a6bfe5ca9e
- deployment on polygon matic:
  https://mumbai.polygonscan.com/tx/0x405c3a618ff511b767517c3f381b79cd27130b24aba4172213d8b039ecc71471
