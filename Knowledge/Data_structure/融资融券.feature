Feature: 融资融券
   融资买入、融券卖出、买券还券、卖券还款等业务

  Scenario: 买券还券（单原子）
     Given 需要有融券卖出合约
       | hs_crdt.compact |
       When 创建合约日期等，小于当前日期
            |curr_date < to_char(sysdate , 'yyyymmdd') |
            | interest_date < to_char(sysdate , 'yyyymmdd') |
            | interest_date < to_char(sysdate , 'yyyymmdd') |
            | create_date < to_char(sysdate , 'yyyymmdd')   |
       And 其它条件
            |合约类别、合约来源、合约状态...|
       And Update参考日期条件
            | to_char(sysdate-1,'yyyymmdd') |
     Then UI
       | client_id | | fund_account | | stock_account | | stock_code |
     Then API
       | client_id | | fund_account | | stock_account | | stock_code |