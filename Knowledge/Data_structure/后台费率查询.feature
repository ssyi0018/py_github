Feature: 后台费率查询
   自动化计算佣金费率、印花税、过户费、冻结资金等

  Scenario: 股票二级后台费用（单原子可和其它原子组合）
    Given 主要在hs_user.bfare2表中根据根据不同的fare_type值来获得balance_ratio
    """
      同一张表left_jion把需要的相同字段值( balance_ratio)在一行里显示出来
      balance2_ratio | balance3_ratio | ....
    """
       | hs_user.bfare2 |
       | hs_asset.fundaccount |
       | hs_user.stkadfare 冻结资金表|
       When fare_type等于不同的值
         | fare_type=0/1/2/3/x | 佣金/印花税/过户费/委托费/其它费 |
       And hs_asset.fundaccount中fare_kind_str取出费用位数和hs_user.bfare2关联
         | substr(fare_kind_str, 5, 4) |
         |                             |
       And 注意hs_user.bfare2和hs_user.stkadfare都需要exchange_type条件
       """
         其中hs_user.stkadfare表中exchange_type = '!'，可参考交易冻结资金设置菜单
       """
       And 在left join关联表外再嵌套一层SQL查询
       """
         为什么要把所有的fare_type类型值取出来，买入里没有3/x的值，因为自动化脚本里有固定的列
         通过查询不到的数据给标准默认费率值
       """
         | nvl(关联结果,默认查询结果SQL_fare_kind='9999') |
     Then  UI
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """
     Then  API
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """

  Scenario: 基金二级后台费用（单原子可和其它原子组合）
    Given 主要在hs_user.offare2表中根据根据不同的fare_type值来获得balance_ratio
    """
      同一张表left_jion把需要的相同字段值( balance_ratio)在一行里显示出来
      balance2_ratio | balance3_ratio | ....
      fare_kind_str位置不一样
    """
       | hs_user.offare2 |
       | hs_asset.fundaccount |
       | hs_user.stkadfare 冻结资金表|
       When fare_type等于不同的值
         | fare_type=0/1/2/3/x | 佣金/印花税/过户费/委托费/其它费 |
       And hs_asset.fundaccount中fare_kind_str取出费用位数和hs_user.offare2关联
         | substr(fare_kind_str, 13, 4) |
         |                             |
       And 注意hs_user.offare2和hs_user.stkadfare都需要exchange_type条件
       """
         其中hs_user.stkadfare表中exchange_type = '!'，可参考交易冻结资金设置菜单
       """
       And 在left join关联表外再嵌套一层SQL查询
       """
         为什么要把所有的fare_type类型值取出来，买入里没有3/x的值，因为自动化脚本里有固定的列
         通过查询不到的数据给标准默认费率值
       """
         | nvl(关联结果,默认查询结果SQL_fare_kind='9999') |
     Then  UI
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """
     Then  API
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """

  Scenario: 债券二级后台费用（单原子可和其它原子组合）
    Given 主要在hs_user.bfare2表中根据根据不同的fare_type值来获得balance_ratio
    """
      同一张表left_jion把需要的相同字段值( balance_ratio)在一行里显示出来
      balance2_ratio | balance3_ratio | ....
      fare_kind_str位置不一样
    """
       | hs_user.bfare2 |
       | hs_asset.fundaccount |
       | hs_user.stkadfare 冻结资金表|
       When fare_type等于不同的值
         | fare_type=0/1/2/3/x | 佣金/印花税/过户费/委托费/其它费 |
       And hs_asset.fundaccount中fare_kind_str取出费用位数和hs_user.bfare2关联
         | substr(fare_kind_str, 21, 4) |
       And 注意hs_user.bfare2和hs_user.stkadfare都需要exchange_type条件
       """
         其中hs_user.stkadfare表中exchange_type = '!'，可参考交易冻结资金设置菜单
       """
       And 在left join关联表外再嵌套一层SQL查询
       """
         为什么要把所有的fare_type类型值取出来，买入里没有3/x的值，因为自动化脚本里有固定的列
         通过查询不到的数据给标准默认费率值
       """
         | nvl(关联结果,默认查询结果SQL_fare_kind='9999') |
     Then  UI
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """
     Then  API
     """
        | client_id | | fund_account | | balance_ratio | min_fare | frozen_adjustfare | as balance2_ratio |
        | as balance3_ratio | ....| as balance5_ratio |
     """