/* Table creations in PostgreSQL 
*/
CREATE TABLE spendings (
	report_date DATE NOT NULL,
	country_code VARCHAR(10),
	platform VARCHAR(10),
	marketing_channel_id INTEGER,
	is_paid_channel BOOLEAN,	/* if FALSE, spendings is guaranteed to be 0 */
	spendings DECIMAL
);
COPY spendings FROM '/Users/jamiesu/Desktop/main/projects/data_analyst_case/data/spendings.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE subscriptions (
	signup_country_code VARCHAR(10),
	marketing_channel_id INTEGER,
	signup_platform VARCHAR(10),
	gender VARCHAR(10),
	is_paid_channel BOOLEAN,
	subscription_date DATE,
	net_revenue DECIMAL,
	subscription_count INTEGER
);
COPY subscriptions FROM '/Users/jamiesu/Desktop/main/projects/data_analyst_case/data/subscriptions.csv' DELIMITER ',' CSV HEADER;


/*	Challenge #1: How much did we spent per channel in December? 

	Assumptions: 1. Because the data is given to be from Q4/2016 - 01/2017,
					year does not need to be checked
*/
SELECT  marketing_channel_id, 
		ROUND(SUM(spendings), 2) as total_spendings
FROM spendings
WHERE DATE_PART('month', report_date) = 12
GROUP BY marketing_channel_id;


/*	Challenge #2: What is the average cost of acquisition 
				for a subscription per country?

	Assumptions: 1. 'cost' is analogous to 'spendings'
				2. A 'NULL' cost-of-acquisition represents 0 subscriptions
				in a country where marketing efforts were made.
				Presumable, this is still important to know
				(countries where marketing efforts failed), 
				so 'NULL' values in this regard shall remain.

	Process: 1. Calculate total spendings per valid country
			2. Calculate total subscriptions per valid country
			3. Divide the two to get an average

   Note: Used '\copy' on this query in psql to output it as a CSV, 
   	and play around with the spreadsheet as potential presentation material
*/
SELECT  group_spend.country_code,
		ROUND(group_spend.total_cost, 2) AS total_cost,
		ROUND(group_subs.total_subs, 2) AS total_subs,
		ROUND(group_spend.total_cost / group_subs.total_subs, 2) AS cost_of_acquisition
FROM (
	SELECT country_code, SUM(spendings) AS total_cost
	FROM spendings
	WHERE country_code IS NOT NULL 
	AND country_code != 'UNKNOWN'
	GROUP BY country_code) group_spend
FULL OUTER JOIN (
	SELECT  signup_country_code, SUM(subscription_count) AS total_subs
	FROM subscriptions
	WHERE signup_country_code IS NOT NULL
	AND signup_country_code != 'UNKNOWN'
	GROUP BY signup_country_code) group_subs
ON group_spend.country_code = group_subs.signup_country_code
ORDER BY cost_of_acquisition DESC;


/* 	Challenge #3: What is our average revenue and spending 
				per day of the week (Monday, Tuesday...)?

	Assumptions: 1. Aggregated spending is determined by report_date,
				and aggregated revenue is determined by subscription_date
				2. Revenue from non-paid channels will still be counted, 
				since no limitation in this regard was given

	Process: 1. Query a table of average revenue by day-of-week, from subscriptions
			2. Query a table of average spendings by day-of-week, from spendings
			3. Full Outer Join the two on day-of-week

	Note for day-of-week: 0 = Sun, 1 = Mon,..., 6 = Sat
*/
SELECT  group_subs.day_of_week,
		group_subs.avg_revenue, 
		group_spend.avg_spendings
FROM (
	SELECT  DATE_PART('dow', subscription_date) AS day_of_week, 
			ROUND(AVG(net_revenue), 2) AS avg_revenue
	FROM subscriptions
	GROUP BY day_of_week) group_subs
FULL OUTER JOIN (
	SELECT  DATE_PART('dow', report_date) AS day_of_week, 
			ROUND(AVG(spendings), 2) AS avg_spendings
	FROM spendings 
	GROUP BY day_of_week) group_spend
ON group_subs.day_of_week = group_spend.day_of_week
ORDER BY group_subs.day_of_week;

