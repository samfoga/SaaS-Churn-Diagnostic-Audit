CREATE DATABASE saas_project;
USE saas_project;
------------------------------------
CREATE TABLE stg_customers AS 
SELECT * FROM customers;

CREATE TABLE stg_revenue AS
SELECT * FROM revenue;

CREATE TABLE stg_subscriptions AS
SELECT * FROM subscriptions;
-------------------------------------
SELECT *
FROM stg_customers;

ALTER TABLE stg_customers
ADD COLUMN signup_date_clean DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE stg_customers
SET signup_date_clean = STR_TO_DATE(signup_date, '%Y-%m-%d');

ALTER TABLE stg_customers
DROP COLUMN signup_date;
--------------------------------------
SELECT *
FROM stg_customers;

ALTER TABLE stg_customers
ADD COLUMN churn_date_clean DATE;

UPDATE stg_customers
SET churn_date_clean = CASE 
    WHEN churn_date = '' OR churn_date IS NULL THEN NULL
    ELSE STR_TO_DATE(churn_date, '%Y-%m-%d')
END;

ALTER TABLE stg_customers
DROP COLUMN churn_date;
--------------------------------------------
SELECT 
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS null_customer_id,
    COUNT(CASE WHEN plan_type IS NULL THEN 1 END) AS null_plan_type,
    COUNT(CASE WHEN monthly_fee IS NULL THEN 1 END) AS null_monthly_fee,
    COUNT(CASE WHEN acquisition_cost IS NULL THEN 1 END) AS null_acquisition_cost
FROM stg_customers;
--------------------------------------------
SELECT 
    COUNT(CASE WHEN customer_id = '' THEN 1 END) AS blank_customer_id,
    COUNT(CASE WHEN plan_type = '' THEN 1 END) AS blank_plan_type,
    COUNT(CASE WHEN monthly_fee = '' THEN 1 END) AS blank_monthly_fee,
    COUNT(CASE WHEN acquisition_cost = '' THEN 1 END) AS blank_acquisition_cost
FROM stg_customers;
---------------------------------------------
SELECT
  customer_id,
  COUNT(*) AS occurance_count
FROM stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
--------------------------------------------
SELECT *
FROM stg_revenue;

ALTER TABLE stg_revenue
ADD COLUMN revenue_date_clean DATE;

UPDATE stg_revenue
SET revenue_date_clean = STR_TO_DATE(CONCAT(`month`, '-01'), '%Y-%m-%d');

ALTER TABLE stg_revenue
DROP COLUMN `month`;
----------------------------------------------
SELECT *
FROM stg_subscriptions;

ALTER TABLE stg_subscriptions
ADD COLUMN subscription_date_clean DATE;

UPDATE stg_subscriptions
SET subscription_date_clean = STR_TO_DATE(CONCAT(`month`, '-01'), '%Y-%m-%d');

ALTER TABLE stg_subscriptions
DROP COLUMN `month`;
---------------------------------------------
