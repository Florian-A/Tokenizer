// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract ShibaWoof is IERC20, ReentrancyGuard {
    using Math for uint256;

    string private _name = "ShibaWoof42";
    string private _symbol = "SW42";
    uint256 private _decimals = 0;
    uint256 private _totalSupply = 0;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _totalSupply = 42;
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint256) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    function transfer(
        address to,
        uint256 value
    ) public override nonReentrant returns (bool) {
        require(value <= _balances[msg.sender], "Insufficient balance");
        require(to != address(0), "Invalid recipient");

        (bool success, uint256 newBalance) = _balances[msg.sender].trySub(
            value
        );
        require(success, "Subtraction resulted in underflow");
        _balances[msg.sender] = newBalance;

        (success, newBalance) = _balances[to].tryAdd(value);
        require(success, "Addition resulted in overflow");
        _balances[to] = newBalance;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override nonReentrant returns (bool) {
        require(_balances[from] >= value, "Insufficient balance");
        require(to != address(0), "Invalid recipient");
        require(
            _allowances[from][msg.sender] >= value,
            "Insufficient allowance"
        );

        uint256 newBalanceFrom = _balances[from] - value;
        require(newBalanceFrom >= 0, "Subtraction resulted in underflow");
        _balances[from] = newBalanceFrom;

        uint256 newBalanceTo = _balances[to] + value;
        require(newBalanceTo >= _balances[to], "Addition resulted in overflow");
        _balances[to] = newBalanceTo;

        uint256 newAllowance = _allowances[from][msg.sender] - value;
        require(newAllowance >= 0, "Subtraction resulted in underflow");
        _allowances[from][msg.sender] = newAllowance;

        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view returns (uint256 remaining) {
        return _allowances[owner][spender];
    }
}
