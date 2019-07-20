SELECT app_train.*,bureau_loan,bad_debt,active_bureau,delays FROM home_credit.application_train app_train

left join (select 
				SK_ID_CURR
                ,count(SK_ID_BUREAU) bureau_loan
                ,sum(case when CREDIT_ACTIVE = 'Bad debt' then 1 else 0 end) bad_debt 
                ,sum(case when CREDIT_ACTIVE = 'Active' then 1 else 0 end) active_bureau
                from home_credit.bureau group by SK_ID_CURR) b on b.SK_ID_CURR = app_train.SK_ID_CURR
left join (SELECT SK_ID_CURR
					,sum(case when (DAYS_INSTALMENT - DAYS_ENTRY_PAYMENT)>0 then 1 else 0 end) delays 
                    FROM home_credit.installments_payments group by SK_ID_CURR) prev on prev.SK_ID_CURR = app_train.SK_ID_CURR;