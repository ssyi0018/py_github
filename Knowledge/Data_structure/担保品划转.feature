Feature: 担保品划转
   融资融券业务菜单下进行,信用划普通有点构造难道，普通到信用有可用持仓即可

  Scenario: 信用账户划转到普通账户（单原子）
     Given 保证信用账户有持仓，要划转的代码没有融资合约负债（否则合约负债超过持仓有数量，可划转数为0）
        | hs_crdt.compact  | 实时合约表  |
        | hs_crdt.crdtstockreal  | 股份交易信息表  |
        When  查询的crdtstockreal表里的代码没有融资合约负债
           | stock_code not in hs_crdt.compact where xxx |
        And 其它合约类别、合约状态
        |...|
     Then  UI
        | client_id | | fund_account | | stock_account | | stock_code |
     Then  API
        | client_id | | fund_account | | stock_account | | stock_code |