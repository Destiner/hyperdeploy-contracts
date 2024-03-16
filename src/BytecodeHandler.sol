pragma solidity 0.8.23;

interface IHandler {
    function handle(bytes calldata message) external;
}

interface ICreateX {
    function deployCreate2(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate2(bytes memory initCode) external payable returns (address newContract);

    function deployCreate3(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate3(bytes memory initCode) external payable returns (address newContract);
}

contract BytecodeHandler is IHandler {
    event Deployed(address newContract);

    ICreateX public immutable CREATEX;

    constructor(ICreateX createx) {
        CREATEX = createx;
    }

    function handle(bytes calldata message) external {
        (bytes memory bytecode, bytes32 salt) = abi.decode(message, (bytes, bytes32));
        address newContract = CREATEX.deployCreate2(salt, bytecode);
        emit Deployed(newContract);
    }
}
