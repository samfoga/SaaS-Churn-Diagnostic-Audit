# SaaS-Churn-Diagnostic-Audit
End-to-end SaaS churn audit. Used MySQL to clean dates and build cohort metrics. Deployed a Tableau dashboard to isolate a critical 5-month retention cliff likely due to a marketing ICP targeting mismatch starting Q4 2024.

## Repository Structure
* `01_db_setup_and_data_cleaning.sql`: SQL script initializing the schema, staging tables, and standardizing messy date strings.
* `02_cohort_churn_analysis_queries.sql`: Advanced analysis queries utilizing CTEs, aggregations, and tenure calculations to isolate the core insights.
