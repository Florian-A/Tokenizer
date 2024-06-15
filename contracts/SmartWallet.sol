// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SmartWallet is Ownable {
    using Math for uint256;

    struct Transfer {
        address to;
        uint256 value;
        uint256 approvals;
        bool executed;
        mapping(address => bool) approvedBy;
    }

    IERC20 public token;
    mapping(bytes32 => Transfer) private transfers;
    mapping(address => bool) public signers;
    address[] public signerList;

    event Withdrawal(address indexed to, uint256 value);
    event TransferRequested(bytes32 indexed transferId, address indexed to, uint256 value);
    event TransferApproved(bytes32 indexed transferId, address indexed approver);
    event TransferExecuted(bytes32 indexed transferId, address indexed to, uint256 value);

    modifier onlySigner() {
        require(signers[msg.sender], "Sender is not authorized");
        _;
    }

    constructor(address _tokenAddress, address[] memory _initialSigners) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
        for (uint256 i = 0; i < _initialSigners.length; i++) {
            signers[_initialSigners[i]] = true;
            signerList.push(_initialSigners[i]);
        }
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function withdraw(uint256 value) public onlyOwner {
        require(value > 0, "Withdrawal value must be greater than 0");
        uint256 walletBalance = token.balanceOf(address(this));
        require(walletBalance >= value, "Insufficient balance in wallet");

        require(token.transfer(msg.sender, value), "Transfer failed");
        emit Withdrawal(msg.sender, value);
    }

    function requestTransfer(address to, uint256 value) public returns (bytes32 transferId) {
        require(to != address(0), "Invalid recipient");
        require(value > 0, "Transfer value must be greater than 0");

        transferId = keccak256(abi.encodePacked(msg.sender, to, value, block.timestamp));
        Transfer storage newTransfer = transfers[transferId];
        newTransfer.to = to;
        newTransfer.value = value;
        newTransfer.approvals = 0;
        newTransfer.executed = false;

        emit TransferRequested(transferId, to, value);
    }

    function approveTransfer(bytes32 transferId) public onlySigner {
        Transfer storage transfer = transfers[transferId];
        require(transfer.to != address(0), "Transfer does not exist");
        require(!transfer.approvedBy[msg.sender], "Transfer already approved by this signer");
        require(!transfer.executed, "Transfer already executed");

        transfer.approvedBy[msg.sender] = true;
        transfer.approvals += 1;

        emit TransferApproved(transferId, msg.sender);

        // If a majority of signers approve, execute the transfer
        if (transfer.approvals > (signerList.length / 2)) {
            executeTransfer(transferId);
        }
    }

    function executeTransfer(bytes32 transferId) internal {
        Transfer storage transfer = transfers[transferId];
        require(transfer.to != address(0), "Transfer does not exist");
        require(transfer.approvals > (signerList.length / 2), "Not enough approvals");
        require(!transfer.executed, "Transfer already executed");
        
        uint256 walletBalance = token.balanceOf(address(this));
        require(walletBalance >= transfer.value, "Insufficient balance in wallet");

        transfer.executed = true;

        require(token.transfer(transfer.to, transfer.value), "Transfer failed");
        emit TransferExecuted(transferId, transfer.to, transfer.value);
    }

    function getSignerCount() public view returns (uint256) {
        return signerList.length;
    }
}
