WITH customer_total AS (
    SELECT
      COUNT(*) AS total_customers
    FROM stg_customers
)
SELECT total_customers
FROM customer_total;
---------------------------------------
WITH churn_total AS (
    SELECT
      COUNT(*) AS total_churned_customers
    FROM stg_customers
    WHERE churn_date_clean IS NOT NULL
)
SELECT total_churned_customers
FROM churn_total;
--------------------------------------
SELECT
  AVG(days_of_tenure) AS avg_days_of_tenure
FROM 
(SELECT
  customer_id,
  DATEDIFF(churn_date_clean, signup_date_clean) AS days_of_tenure
FROM stg_customers
WHERE churn_date_clean IS NOT NULL) AS customer_lifespans;
---------------------------------------
WITH metric_counts AS (
    SELECT 
        COUNT(customer_id) AS total_customers,
        COUNT(CASE WHEN churn_date_clean IS NOT NULL THEN 1 END) AS churned_customers
    FROM stg_customers
)
SELECT 
    total_customers,
    churned_customers,
    ROUND((churned_customers / total_customers) * 100, 2) AS churn_rate_percentage
FROM metric_counts;
-----------------------------------------
SELECT *
FROM stg_customers;
----------------------------------------
WITH insights_counts AS (
    SELECT 
        COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
        COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
        COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
    FROM stg_customers
)
SELECT
  basic_plan_churned,
  ROUND((basic_plan_churned / 168) * 100, 2) AS basic_churn_rate_percentage,
  pro_plan_churned,
  ROUND((pro_plan_churned / 168) * 100, 2) AS pro_churn_rate_percentage,
  enterprise_plan_churned,
  ROUND((enterprise_plan_churned / 168) * 100, 2) AS enterprise_churn_rate_percentage
FROM insights_counts;
----------------------------------------
SELECT
  YEAR(signup_date_clean) AS customer_sign_up_year,
  COUNT(YEAR(churn_date_clean)) AS total_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
FROM stg_customers
WHERE churn_date_clean IS NOT NULL
GROUP BY YEAR(signup_date_clean);
-----------------------------------------
SELECT
  MONTH(signup_date_clean) AS customer_sign_up_month,
  COUNT(MONTH(churn_date_clean)) AS total_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
FROM stg_customers
WHERE churn_date_clean IS NOT NULL AND YEAR(signup_date_clean) = 2024 AND YEAR(churn_date_clean) = 2025
GROUP BY MONTH(signup_date_clean)
ORDER BY MONTH(signup_date_clean);
-----------------------------------------
SELECT
  YEAR(churn_date_clean) AS customer_churn_year,
  COUNT(YEAR(churn_date_clean)) AS total_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
FROM stg_customers
WHERE churn_date_clean IS NOT NULL
GROUP BY YEAR(churn_date_clean);
-----------------------------------------
SELECT
  MONTH(churn_date_clean) AS customer_churn_month_2024,
  COUNT(MONTH(churn_date_clean)) AS total_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
FROM stg_customers
WHERE churn_date_clean IS NOT NULL AND YEAR(churn_date_clean) = 2024
GROUP BY MONTH(churn_date_clean)
ORDER BY MONTH(churn_date_clean);
------------------------------------------
SELECT
  MONTH(churn_date_clean) AS customer_churn_month_2025,
  COUNT(MONTH(churn_date_clean)) AS total_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Basic'THEN 1 END) AS basic_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Pro'THEN 1 END) AS pro_plan_churned,
  COUNT(CASE WHEN churn_date_clean IS NOT NULL AND plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_churned
FROM stg_customers
WHERE churn_date_clean IS NOT NULL AND YEAR(churn_date_clean) = 2025
GROUP BY MONTH(churn_date_clean)
ORDER BY MONTH(churn_date_clean);
------------------------------------------
SELECT *
FROM stg_customers;
-----------------------------------------
SELECT
  MONTH(signup_date_clean) AS customer_signup_month_2024,
  COUNT(MONTH(signup_date_clean)) AS total_signups,
  COUNT(CASE WHEN plan_type = 'Basic'THEN 1 END) AS basic_plan_signups,
  COUNT(CASE WHEN plan_type = 'Pro'THEN 1 END) AS pro_plan_signups,
  COUNT(CASE WHEN plan_type = 'Enterprise'THEN 1 END) AS enterprise_plan_signups
FROM stg_customers
WHERE YEAR(churn_date_clean) = 2025 AND churn_date_clean IS NOT NULL
GROUP BY MONTH(signup_date_clean)
ORDER BY MONTH(signup_date_clean);
