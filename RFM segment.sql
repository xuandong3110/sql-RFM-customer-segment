select *
from csp.customer c 

select  *
from csp.sales s 

select  * from segment_scores ss 


-- calculate RFM

with RFM_1 as (
select c.`Customer ID` as 'Customer_id', c.`Customer Name` as ' Customer_name', 
datediff('2017-12-31',max(s.`Order Date`)) as Recency,
count(distinct s.`Order ID`) as Frequency,
round(sum(s.Sales),1) as Monetary
from csp.customer c  join csp.sales s on c.`Customer ID`  = s .`Customer ID` 
group by c.`Customer ID`
), RFM_Score as(
select *,
ntile (5) over(order by Recency desc ) as R_Score,
ntile (5) over(order by Frequency asc ) as F_score,
ntile (5) over(order by Monetary asc ) as M_score
from RFM_1
), RFM_overall as (
select *, CONCAT(R_Score,F_score,M_score) as RFM_total
from RFM_Score
)
select *
from RFM_overall join csp.segment_scores ss on RFM_overall.RFM_total = ss.Scores 






 

