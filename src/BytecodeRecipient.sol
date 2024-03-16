// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface IMessageRecipient {
    function handle(uint32 _origin, bytes32 _sender, bytes calldata _message) external payable;
}

interface ICreateX {
    function deployCreate2(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate2(bytes memory initCode) external payable returns (address newContract);

    function deployCreate3(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate3(bytes memory initCode) external payable returns (address newContract);
}

contract BytecodeRecipient is IMessageRecipient {
    event Deployed(address newContract);

    ICreateX public immutable CREATEX;

    constructor(ICreateX createx) {
        CREATEX = createx;
    }

    function handle(uint32, bytes32, bytes calldata message) external payable override {
        (bytes memory bytecode, bytes32 salt) = abi.decode(message, (bytes, bytes32));
        address newContract = CREATEX.deployCreate2(salt, bytecode);
        emit Deployed(newContract);
    }
}
