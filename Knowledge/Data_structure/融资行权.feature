Feature: 融资行权
   自主行权菜单下的融资行权,通过股票进行期权融资

  Scenario: 融资行权_深圳场景（单原子）
     Given 在自主行权股东名册里找满足代码和数量条件的账户
        | hs_asset.soptreg  | 自主行权股东名册表  | a |
        | hs_user.soptcode  | 自主行权代码表  | b |
        | hs_asset.stockholder  | 证券账户表  | c |
        | hs_asset.fund  | 存管资金表  | d |
        | hs_asset.ARPCRQUOTA  | 约定购回授信表  | e |
        When a和b自主行权代码关联
           | sopt_code |
        And a表数量匹配,包括登记数量、已使用数量和确认数量
           | register_amount>used_amount   |
           | confirm_amount>used_amount   |
        And b行权截止日期大于当前日期
        And 资金、账户关联、权限满足公共条件
           | holder_rights like '%J%' |
        And 授信表里有记录关联
           | fund_account |
     Then  UI
        | client_id | | fund_account | | stock_account | | sopt_code |
     Then  API
        | client_id | | fund_account | | stock_account | | sopt_code |

     Example: SQL
        """
         select b.fund_account,b.client_id,a.stock_account,a.sopt_code,c.apply_end_date
         from hs_asset.stockholder b,hs_asset.soptreg a,hs_user.soptcode@tstuf1 c,hs_asset.fund d,hs_asset.ARPCRQUOTA e
         where a.stock_account = b.stock_account
         and a.sopt_code = c.sopt_code
         and b.fund_account = d.fund_account
         and a.register_amount >a.used_amount
         and a.confirm_amount >a.used_amount
         and c.apply_end_date >to_char(sysdate,'yyyymmdd')
         and （d.current_balance - d.frozen_balance） > 10000
         and b.holder_rights LIKE '%J%'
         and a.exchange_type = '2'
         and b.fund_account=e.fund_account
         and e.en_cbpbusi_type = '!' AND rownum <= 1