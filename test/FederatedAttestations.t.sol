// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.13;

import "celo/identity/FederatedAttestations.sol";
import "celo/identity/Escrow.sol";
import "ds-test/test.sol";
import "forge-std/Vm.sol";

contract ContractTest is DSTest {
    address constant private VM_ADDRESS =
        address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

    Vm public constant vm = Vm(VM_ADDRESS);

    FederatedAttestations federatedAttestations;
    Escrow escrow;
    bytes32 constant ID1 = keccak256(abi.encodePacked("ID1"));
    bytes32 constant ID2 = keccak256(abi.encodePacked("ID2"));
    address[] trustedIssuers;

    function setUp() public {
        federatedAttestations = new FederatedAttestations(true);
        escrow = new Escrow(true);

        vm.prank(address(1));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(1), address(12), 100);
        vm.prank(address(1));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(1), address(11), 100);
        vm.prank(address(3));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(3), address(11), 100);
        vm.prank(address(4));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(4), address(11), 100);
        vm.prank(address(5));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(5), address(12), 100);
        vm.prank(address(6));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(6), address(11), 100);
        vm.prank(address(7));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(7), address(12), 100);
        vm.prank(address(7));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(7), address(11), 100);
        vm.prank(address(7));
        federatedAttestations.registerAttestationAsIssuer(
            keccak256(abi.encodePacked("ID1")), address(7), address(13), 100);

        trustedIssuers = new address[](7);
        for (uint256 i = 1; i < 8; i ++) {
            trustedIssuers[i-1] = address(i);
        }
    }

    function testNormal() public {
        escrow.addDefaultTrustedIssuer(address(1));
        escrow.addDefaultTrustedIssuer(address(2));
        escrow.addDefaultTrustedIssuer(address(3));
        escrow.addDefaultTrustedIssuer(address(4));
        escrow.addDefaultTrustedIssuer(address(5));
        escrow.addDefaultTrustedIssuer(address(6));
        emit log_bytes(abi.encode(escrow.defaultTrustedIssuers(5)));
    }

    function testLookupAsIs() public {
        federatedAttestations.lookupAttestations(ID1, trustedIssuers);
    }

    function testRevokeTwoTimes() public {
        vm.prank(address(1));
        federatedAttestations.revokeAttestation(ID1, address(1), address(11));

        vm.prank(address(1));
        vm.expectRevert(bytes("Attestation to be revoked does not exist"));
        federatedAttestations.revokeAttestation(ID1, address(1), address(11));
    }
}
