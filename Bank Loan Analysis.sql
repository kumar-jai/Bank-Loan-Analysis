select *
from financial_loan;

--total loan applicatons
select count(id) as 'Total Loan Applications'
from financial_loan;

--MTD loan applications

with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date)) as l_month
from financial_loan)
select count(id) as 'MTD Loan Applications'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year


select count(id)
from financial_loan
where year(issue_date) =
(select max(year(issue_date))
from financial_loan) and month(issue_date) = (select max(month(issue_date)) from financial_loan)

--PTMD loan applications
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date))-1 as p_month
from financial_loan)
select count(id) as 'PMTD Loan Applications'
from financial_loan f join cte
on month(issue_date) = p_month and year(issue_date) = l_year;


--'MoM Growth'
with cte as
(select month(issue_date) as 'Month',count(id) as 'Total_Loan_Applications'
from financial_loan
group by month(issue_date)
)
select *,
1.0 *(Total_Loan_Applications -
lag(Total_Loan_Applications,1,Total_Loan_Applications) over(order by Month)) /  lag(Total_Loan_Applications,1,Total_Loan_Applications) over(order by Month) * 100 as 'MoM_Growth'
from cte;


--total funded amount query
select sum(loan_amount) as 'Total_Funded_Amount'
from financial_loan;

--MTD funded amount query
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date)) as l_month
from financial_loan)
select sum(loan_amount) as 'MTD Funded Amount'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year

--PMTD funded amount query
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date))-1 as l_month
from financial_loan)
select sum(loan_amount) as 'PMTD Funded Amount'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year

--'MoM Growth'
with cte as
(select month(issue_date) as 'Month',sum(loan_amount) as 'Total_Loan_Amount'
from financial_loan
group by month(issue_date)
)
select *,
1.0 *(Total_Loan_Amount -
lag(Total_Loan_Amount,1,Total_Loan_Amount) over(order by Month)) /  lag(Total_Loan_Amount,1,Total_Loan_Amount) over(order by Month) * 100 as 'MoM_Growth'
from cte;

--Total Amount Received
select sum(total_payment) as 'Total_Amount_Received'
from financial_loan;

--MTD Amount Received
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date)) as l_month
from financial_loan)
select sum(total_payment) as 'MTD Received Amount'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year

--PMTD Amount Received
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date))-1 as l_month
from financial_loan)
select sum(total_payment) as 'PMTD Received Amount'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year;

--'MoM Growth'
with cte as
(select month(issue_date) as 'Month',sum(total_payment) as 'Total_Amount_Received'
from financial_loan
group by month(issue_date)
)
select *,
1.0 *(Total_Amount_Received -
lag(Total_Amount_Received,1,Total_Amount_Received) over(order by Month)) /  lag(Total_Amount_Received,1,Total_Amount_Received) over(order by Month) * 100 as 'MoM_Growth'
from cte;

--Average Intrest Rate
select avg(int_rate)*100 as 'Average_Intrest_Rate'
from financial_loan;

--MTD Average Intrest Rate
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date)) as l_month
from financial_loan)
select avg(int_rate)*100 as 'MTD Average_Intrest_Rate'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year

--PMTD Average Intrest Rate
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date))-1 as l_month
from financial_loan)
select avg(int_rate)*100 as 'PMTD Average_Intrest_Rate'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year


--MoM Avg Intrest Rate
with cte as
(select month(issue_date) as 'Month',avg(int_rate)*100 as 'Average_Intrest_Rate'
from financial_loan
group by month(issue_date)
)
select *,
1.0 *(Average_Intrest_Rate -
lag(Average_Intrest_Rate,1,Average_Intrest_Rate) over(order by Month)) /  lag(Average_Intrest_Rate,1,Average_Intrest_Rate) over(order by Month) * 100 as 'MoM_Growth'
from cte;

--Avg DTI
select avg(dti)*100 as 'Avg_Debt_to_Income_Ratio'
from financial_loan;

--MTD Avg_Debt_to_Income_Ratio
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date)) as l_month
from financial_loan)
select avg(dti)*100 as 'MTD_Avg_Debt_to_Income_Ratio'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year;

--PMTD Avg_Debt_to_Income_Ratio
with cte as
(select max(year(issue_date)) as l_year ,max(month(issue_date))-1 as l_month
from financial_loan)
select avg(dti)*100 as 'PMTD_Avg_Debt_to_Income_Ratio'
from financial_loan f join cte
on month(issue_date) = l_month and year(issue_date) = l_year;


--MoM Avg_Debt_to_Income_Ratio
with cte as
(select month(issue_date) as 'Month', avg(dti)*100 as 'Avg_Debt_to_Income_Ratio'
from financial_loan
group by month(issue_date)
)
select *,
1.0 *(Avg_Debt_to_Income_Ratio -
lag(Avg_Debt_to_Income_Ratio,1,Avg_Debt_to_Income_Ratio) over(order by Month)) /  lag(Avg_Debt_to_Income_Ratio,1,Avg_Debt_to_Income_Ratio) over(order by Month) * 100 as 'MoM_Growth'
from cte;

--Good Loan Applications %
select 1.0 * count(id) / (select count(id) from financial_loan) * 100 as 'Good Loan Applications %'
from financial_loan
where loan_status in ('Fully Paid','Current')

--Good Loan Applications
select  count(id) as 'Good Loan Applications'
from financial_loan
where loan_status in ('Fully Paid','Current')

--Good loan Funded Amount
select sum(loan_amount) as 'Good loan Funded Amount'
from financial_loan
where loan_status in ('Fully Paid','Current')

--Good loan Total Received Amount
select sum(total_payment) as 'Good loan Total Received Amount'
from financial_loan
where loan_status in ('Fully Paid','Current')


--Bad Loan Applications %
select 1.0 * count(id) / (select count(id) from financial_loan) * 100 as 'Bad Loan Applications %'
from financial_loan
where loan_status = 'Charged off';

--Bad Loan Applications
select  count(id) as 'Bad Loan Applications'
from financial_loan
where loan_status = 'Charged off';

--Bad loan Funded Amount
select sum(loan_amount) as 'Bad loan Funded Amount'
from financial_loan
where loan_status = 'Charged off'

--Bad loan Total Received Amount
select sum(total_payment) as 'Bad loan Total Received Amount'
from financial_loan
where loan_status = 'Charged off'

--Loan Status
select loan_status,
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by loan_status;

--Monthly Trend
select month(issue_date) as 'Month',
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by month(issue_date)
order by month(issue_date)

--State Wise Trend
select address_state as 'State',
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by address_state;

--Loan Term Trend
select term as 'Loan Term',
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by term;

--Loan Purpose Analysis
select purpose as 'Loan Purpose',
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by purpose;

--Home Ownership Analysis
select home_ownership as 'Home Ownership',
count(id) as 'Total Applications',
sum(total_payment) as 'Total Amount Received',
sum(loan_amount) as 'Total Funded Amount',
avg(int_rate) * 100 as 'Avg Intrest Rate',
avg(dti)*100 as 'Avg Debt to Income Ratio'
from financial_loan
group by home_ownership;
