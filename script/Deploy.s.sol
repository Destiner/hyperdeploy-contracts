// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { Foo } from "../src/Foo.sol";

import { BaseScript } from "./Base.s.sol";
import { ICreateX, BytecodeHandler } from "../src/BytecodeHandler.sol";
import { IMalibox, IHandler, BytecodeRouter } from "../src/BytecodeRouter.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast returns (Foo foo) {
        foo = new Foo();
    }
}

contract DeployBytecodeHandler is BaseScript {
    function run() public broadcast returns (BytecodeHandler handler) {
        // Well-known static address
        ICreateX createx = ICreateX(0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed);
        handler = new BytecodeHandler(createx);
    }
}

contract DeployBytecodeRouter is BaseScript {
    function run() public broadcast returns (BytecodeRouter router) {
        // Well-known static address
        IMalibox mailbox = IMalibox(0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed);
        // Taken as a handler deployment artifact, dynamic
        IHandler handler = IHandler(0x7bF601DE6a3bf24678ed06282F1C8fEEC019B554);
        router = new BytecodeRouter(mailbox, handler);
    }
}
