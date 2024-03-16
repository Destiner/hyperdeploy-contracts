// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// solhint-disable-next-line no-empty-blocks
interface IPostDispatchHook { }

interface IMailbox {
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

    function quoteDispatch(
        uint32 destinationDomain,
        bytes32 recipientAddress,
        bytes calldata body,
        bytes calldata customHookMetadata,
        IPostDispatchHook customHook
    )
        external
        view
        returns (uint256 protocolFee);
}

contract BytecodeRouter {
    IMailbox public immutable MAILBOX;

    constructor(IMailbox mailbox) {
        MAILBOX = mailbox;
    }

    function deploy(
        bytes calldata bytecode,
        bytes32 salt,
        // TODO make an immutable chainId => recipient mapping
        bytes32[] calldata recipientAddresses,
        uint256[] calldata chains,
        bytes[] calldata customHookMetadatas,
        IPostDispatchHook[] calldata customHooks
    )
        external
        payable
        returns (bytes32[] memory messageIds)
    {
        bytes memory messageBody = abi.encode(bytecode, salt);
        messageIds = new bytes32[](chains.length);
        for (uint256 i = 0; i < chains.length; i++) {
            uint256 protocolFee = MAILBOX.quoteDispatch(
                uint32(chains[i]), recipientAddresses[i], messageBody, customHookMetadatas[i], customHooks[i]
            );
            messageIds[i] = MAILBOX.dispatch{ value: protocolFee }(
                uint32(chains[i]), recipientAddresses[i], messageBody, customHookMetadatas[i], customHooks[i]
            );
        }
    }

    receive() external payable { }
}
