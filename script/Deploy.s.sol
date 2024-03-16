// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { BaseScript } from "./Base.s.sol";
import { ICreateX, BytecodeRecipient } from "../src/BytecodeRecipient.sol";
import { IMailbox, BytecodeRouter } from "../src/BytecodeRouter.sol";

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
        IMailbox mailbox = IMailbox(0xfFAEF09B3cd11D9b20d1a19bECca54EEC2884766);
        // Taken as a recipient deployment artifact, dynamic
        router = new BytecodeRouter(mailbox);
    }
}
