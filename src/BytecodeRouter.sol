pragma solidity 0.8.23;

interface IPostDispatchHook { }

interface IMalibox {
    function dispatch(
        uint32 destinationDomain,
        bytes32 recipientAddress,
        bytes calldata body,
        bytes calldata customHookMetadata,
        IPostDispatchHook customHook
    )
        external
        payable
        returns (bytes32 messageId);
}

interface IHandler {
    function handle(bytes calldata message) external;
}

contract BytecodeRouter {
    IMalibox public immutable MALIBOX;
    address public immutable HANDLER_ADDRESS;

    constructor(IMalibox mailbox, IHandler handler) {
        MALIBOX = mailbox;
        HANDLER_ADDRESS = address(handler);
    }

    function deploy(
        bytes calldata bytecode,
        bytes calldata salt,
        uint256[] calldata chains,
        bytes[] calldata customHookMetadatas,
        IPostDispatchHook[] calldata customHooks
    )
        external
        returns (bytes32[] memory messageIds)
    {
        messageIds = new bytes32[](chains.length);
        for (uint256 i = 0; i < chains.length; i++) {
            messageIds[i] = MALIBOX.dispatch(
                uint32(chains[i]),
                bytes32(uint256(uint160(HANDLER_ADDRESS))),
                abi.encode(bytecode, salt),
                customHookMetadatas[i],
                customHooks[i]
            );
        }
    }
}
