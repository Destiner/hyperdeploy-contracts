pragma solidity 0.8.23;

import { BytecodeRecipient } from "./BytecodeRecipient.sol";

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

contract BytecodeRouter {
    IMalibox public immutable MALIBOX;
    address public immutable RECIPIENT_ADDRESS;

    constructor(IMalibox mailbox, BytecodeRecipient recipient) {
        MALIBOX = mailbox;
        RECIPIENT_ADDRESS = address(recipient);
    }

    function deploy(
        bytes calldata bytecode,
        bytes32 salt,
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
                bytes32(uint256(uint160(RECIPIENT_ADDRESS))),
                abi.encode(bytecode, salt),
                customHookMetadatas[i],
                customHooks[i]
            );
        }
    }
}
