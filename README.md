# 在bnb的测试网中，使用brownie框架实现简单的重入攻击
___________________________________________________

## 随便准备两个新注册的钱包并且获取bnb测试网的测试币
## 想了解合约重入攻击的逻辑请移步WTF学院的：[重入攻击]（https://mirror.xyz/wtfacademy.eth/SrNu6LLzwH7qlTVKbJY6lkTpmadGqUXw0L8iUMzfMxo）

___________________________________________________

建议在文本中创建虚拟环境，在虚拟环境中安装brownie :kissing_closed_eyes:
`pip install eth-brownie`

添加钱包的作为账户（需要两个）
`brownie accounts new xxx`

先执行bank_deploy.py获取合约地址作为参数传入bank_attack.py再执行
遇到问题请留言 :kissing_closed_eyes:
