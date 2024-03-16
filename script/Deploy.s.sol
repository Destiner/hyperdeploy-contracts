// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { Foo } from "../src/Foo.sol";

import { BaseScript } from "./Base.s.sol";
import { ICreateX, BytecodeRecipient } from "../src/BytecodeRecipient.sol";
import { IMalibox, BytecodeRouter } from "../src/BytecodeRouter.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast returns (Foo foo) {
        foo = new Foo();
    }
}

contract DeployBytecodeRecipient is BaseScript {
    function run() public broadcast returns (BytecodeRecipient recipient) {
        // Well-known static address
        ICreateX createx = ICreateX(0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed);
        recipient = new BytecodeRecipient(createx);
    }
}

contract DeployBytecodeRouter is BaseScript {
    function run() public broadcast returns (BytecodeRouter router) {
        // Well-known static address
        IMalibox mailbox = IMalibox(0xfFAEF09B3cd11D9b20d1a19bECca54EEC2884766);
        // Taken as a recipient deployment artifact, dynamic
        BytecodeRecipient recipient = BytecodeRecipient(0x5D23B2dD284a772E31D6142e39a2ca8D24575e96);
        router = new BytecodeRouter(mailbox, recipient);
    }
}
