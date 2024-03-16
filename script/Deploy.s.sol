// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { console } from "forge-std/src/console.sol";

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
    mapping(uint256 chainId => IMailbox mailbox) internal mailboxes;

    constructor() {
        mailboxes[534_351] = IMailbox(0xfFAEF09B3cd11D9b20d1a19bECca54EEC2884766);
        mailboxes[44_787] = IMailbox(0xEf9F292fcEBC3848bF4bB92a96a04F9ECBb78E59);
        mailboxes[11_155_111] = IMailbox(0xfFAEF09B3cd11D9b20d1a19bECca54EEC2884766);
        mailboxes[43_113] = IMailbox(0x5b6CFf85442B851A8e6eaBd2A4E4507B5135B3B0);
        mailboxes[97] = IMailbox(0xF9F6F5646F478d5ab4e20B0F910C92F1CCC9Cc6D);
        mailboxes[1287] = IMailbox(0x76189acFA212298d7022624a4633411eE0d2f26F);
        mailboxes[80_001] = IMailbox(0x2d1889fe5B092CD988972261434F7E5f26041115);
        mailboxes[137] = IMailbox(0x5d934f4e2f797775e53561bB72aca21ba36B96BB);
        mailboxes[56] = IMailbox(0x2971b9Aec44bE4eb673DF1B88cDB57b96eefe8a4);
        mailboxes[42_161] = IMailbox(0x979Ca5202784112f4738403dBec5D0F3B9daabB9);
        mailboxes[10] = IMailbox(0xd4C1905BB1D26BC93DAC913e13CaCC278CdCC80D);
        mailboxes[1284] = IMailbox(0x094d03E751f49908080EFf000Dd6FD177fd44CC3);
        mailboxes[100] = IMailbox(0xaD09d78f4c6b9dA2Ae82b1D34107802d380Bb74f);
        mailboxes[8453] = IMailbox(0xeA87ae93Fa0019a82A727bfd3eBd1cFCa8f64f1D);
        mailboxes[534_352] = IMailbox(0x2f2aFaE1139Ce54feFC03593FeE8AB2aDF4a85A7);
        mailboxes[1101] = IMailbox(0x3a464f746D23Ab22155710f44dB16dcA53e0775E);
        mailboxes[42_220] = IMailbox(0x50da3B3907A08a24fe4999F4Dcf337E8dC7954bb);
        mailboxes[1] = IMailbox(0xc005dc82818d67AF737725bD4bf75435d065D239);
        mailboxes[43_114] = IMailbox(0xFf06aFcaABaDDd1fb08371f9ccA15D73D51FeBD6);
    }

    function run() public broadcast returns (BytecodeRouter router) {
        uint256 chainId = getChainId();
        console.log(chainId);
        IMailbox mailbox = mailboxes[chainId];
        console.log(address(mailbox));
        // Taken as a recipient deployment artifact, dynamic
        router = new BytecodeRouter(mailbox);
    }

    function getChainId() internal view returns (uint256) {
        uint256 id;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            id := chainid()
        }
        return id;
    }
}
