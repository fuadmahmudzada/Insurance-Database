
--sirketin partnerlere odediyi orta miqdar
select avg(payment_amount)
from payments
where payment_kind='TO_PARTNER'

-- hec bir pul ucun muraciet etmeyenler
select a.user_id, c.agreement_id
from agreements a
left join claim c on c.agreement_id = a.id
where  c.agreement_id is null


-- en cox yangina gore edilmis odenislerin oldugu bolge
--qerara gore ya premium artir ya da basqa
select c.claimed_amount, h.HOUSE_ADDRESS
from home_insurance_details h 
join agreements a on h.agreement_id = a.id
join claim c on c.agreement_id = a.id
where DBMS_LOB.SUBSTR(c.claim_description, 4000) = 'Yangin'
order by c.claimed_amount asc;

-- en cox odenis edilen musteriler tapib onlarin premiumunu artir
SELECT sum(p.PAYMENT_AMOUNT), p.USER_ID
FROM payments p
JOIN users u ON p.user_id = u.id
WHERE p.payment_kind = 'TO_PARTNER'
GROUP BY p.user_id


-- select (select sum(payment_amount)
-- from payments
-- where payment_kind = 'SUB' and payment_status = 'DONE') - payment_amount
-- from payments
-- where payment_kind = 'TO_PARTNER' and payment_status = 'DONE'

SELECT 
    (SELECT SUM(payment_amount)
     FROM payments
     WHERE payment_kind = 'SUB' AND payment_status = 'DONE') 
    - 
    (SELECT SUM(payment_amount)
     FROM payments
     WHERE payment_kind = 'TO_PARTNER' AND payment_status = 'DONE') AS result
FROM dual;

--musterilerden il erzinde en cox claim teleb edib qebul alani
-- bu ile hansi musterinin muqavilesine xitam verilmeli oldugu mueyyenlesdirilir

create view joined_user_claim
as 
select user_id, count(user_id) as ct
from users u
join claim c on u.id = c.user_id
where c.claim_situation='ACCEPTED' and c.claim_date>=add_months(sysdate, -12)
group by user_id

select t1.user_id, t1.ct, t2.FIRST_NAME
from
(joined_user_claim) t1
join users t2 on  t1.user_id = t2.id

