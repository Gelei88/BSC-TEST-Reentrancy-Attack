from brownie import Bank,accounts,Wei


# 部署智能合约
def deploy_bank():
    account = accounts.load("gelei")
    bank = Bank.deploy({"from": account})
    return bank


def deposit_bank(bank):
    # 获取已经部署的合约
    account = accounts[0]
    # 调用合约函数
    deposit_amount = Wei("0.01 ether")
    transaction =bank.deposit({"from": account, "value": deposit_amount})
    #等待交易完成
    transaction.wait(1)
    print("Transaction hash:", transaction.txid)


def withdraw_bank(bank):
    account = accounts[0]
    transaction =bank.withdraw({"from": account})
    transaction.wait(1)
    print("Withdraw successful")

def main():
    bank = deploy_bank()
    deposit_bank(bank)