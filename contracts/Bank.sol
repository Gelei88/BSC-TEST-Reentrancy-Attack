//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.12;

contract Bank {
    //mapping是一种用于将键值对关联起来的数据结构，类似于其他编程语言中的字典或哈希表
    mapping(address => uint256) public balance;
    uint256 public totalDeposit;
//查询余额
    function ethBalance() external view returns (uint256) {
        return address(this).balance;
    }
//存款，这行代码将从msg.sender发送的以太币的价值添加到了balance映射中
//这样做确保了在接收到以太币后，合约记录了该地址的存款量
//msg.value中接收到的以太币的价值添加到了合约的总存款量中
    function deposit() external payable {
        balance[msg.sender] += msg.value;
        totalDeposit += msg.value;
    }

    function withdraw() external {
        //在balance中查找该账户地址的键值对也就是value是否>0
        require(balance[msg.sender] > 0, "Bank: no balance");

        //重点：
        //msg.sender它表示当前调用合约或函数的地址。
        //balance[msg.sender] 使用了映射的访问方式，根据 msg.sender 查找对应的余额
        //{value: balance[msg.sender]} 调用函数或合约时可以附带的以太币数量。
        //在这里，它表示要发送的以太币数量，该数量等于 balance[msg.sender]，也就是调用者当前的余额
        //call 是一个低级函数，用于向另一个合约发送以太币和执行代码。在这里，它被用于向 msg.sender 发送以太币。
        //最后的空字符串 "" 表示调用 call 函数时不传递任何数据

        //实现了将balance中自己地址对应的余额提取给自己
        msg.sender.call{value: balance[msg.sender]}("");
        //总余额减去该地址对于的余额
        totalDeposit -= balance[msg.sender];
        //将该地址的余额清零
        balance[msg.sender] = 0;
    }
}
