

-- Basic Questions
-- What is the total number of customers? 
SELECT 
    COUNT(*) AS total_customers
FROM
    customers;

-- What is the average age of customers?
SELECT 
    AVG(age) AS average_age
FROM
    customers;

-- What is the distribution of spending scores?
SELECT 
    MIN(spending_score) AS min_score,
    MAX(spending_score) AS max_score,
    AVG(spending_score) AS avg_score
FROM
    customers;


-- Intermediate Questions
-- How can customers be segmented by spending score?
SELECT 
    CASE
        WHEN spending_score BETWEEN 1 AND 20 THEN 'Low'
        WHEN spending_score BETWEEN 21 AND 60 THEN 'Medium'
        ELSE 'High'
    END AS spending_score_segment,
    COUNT(*) AS customer_count
FROM
    customers
GROUP BY spending_score_segment;


-- How can customers be segmented by income?
SELECT 
    CASE
        WHEN income < 30000 THEN 'Low Income'
        WHEN income BETWEEN 30000 AND 70000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_segment,
    COUNT(*) AS customer_count
FROM
    customers
GROUP BY income_segment;


-- What is the age distribution of customers?
SELECT 
    CASE
        WHEN age < 25 THEN 'Young'
        WHEN age BETWEEN 25 AND 45 THEN 'Adult'
        ELSE 'Senior'
    END AS age_segment,
    COUNT(*) AS customer_count
FROM
    customers
GROUP BY age_segment;

-- What is the average purchase frequency by gender?
SELECT 
    gender, AVG(purchase_frequency) AS avg_purchase_frequency
FROM
    customers
GROUP BY gender;

-- Advanced Questions
-- How can customers be segmented by multiple factors (e.g., age, income, spending score)?
SELECT 
    age_segment,
    income_segment,
    spending_score_segment,
    COUNT(*) AS customer_count
FROM
    (SELECT 
        *,
            CASE
                WHEN age < 25 THEN 'Young'
                WHEN age BETWEEN 25 AND 45 THEN 'Adult'
                ELSE 'Senior'
            END AS age_segment,
            CASE
                WHEN income < 30000 THEN 'Low Income'
                WHEN income BETWEEN 30000 AND 70000 THEN 'Middle Income'
                ELSE 'High Income'
            END AS income_segment,
            CASE
                WHEN spending_score BETWEEN 1 AND 20 THEN 'Low'
                WHEN spending_score BETWEEN 21 AND 60 THEN 'Medium'
                ELSE 'High'
            END AS spending_score_segment
    FROM
        customers) AS segmented_customers
GROUP BY age_segment , income_segment , spending_score_segment;

-- What are the top 5 preferred categories by average spending score?
SELECT 
    preferred_category,
    AVG(spending_score) AS avg_spending_score
FROM
    customers
GROUP BY preferred_category
ORDER BY avg_spending_score DESC
LIMIT 5;

-- What are the monthly trends in average last purchase amount?
-- Assuming you have a 'last_purchase_date' column in the format YYYY-MM-DD
SELECT 
    EXTRACT(YEAR FROM last_purchase_date) AS year,
    EXTRACT(MONTH FROM last_purchase_date) AS month,
    AVG(last_purchase_amount) AS avg_last_purchase_amount
FROM
    customers
GROUP BY year , month
ORDER BY year , month;

-- What is the estimated customer lifetime value (CLV)?
-- Assuming 'purchase_frequency' and 'last_purchase_amount' can be used for CLV estimation
SELECT 
    id,
    (purchase_frequency * last_purchase_amount) AS estimated_clv
FROM
    customers;

-- What is the correlation between income and spending score?
SELECT 
    CORR(income, spending_score) AS correlation
FROM
    customers;



