# Additional Comments
1. Why do **'spending'** and **'net_revenue'** have negative values sometimes?
	- Does a negative **'spending'** mean a refund from a marketing channel, because a budget that was allocated to that channel was not fully used? (I notice it's always on the first of a month.)
	- Does a negative 'net_revenue' mean a customer subscription was refunded?

I will be assuming that I can include the negative values in the totals / averages of **'spending'** and **'net_revenue'**. 

(e.g. If a marketing channel didn't use all the funds 'spent' previously and refunded the unused money back, then I assume that contributes to lesser overall spending.)


2. With Docker, I was able to connect to the container from psql with:
```bash
docker exec -it data_analyst_case_postgres_1 psql -h 127.0.0.1 -p 5432 -U data_analyst_case
```

However, I had trouble actually creating the tables with `dbt seed --profiles-dir .`.

Error message:
```
ERROR: Database Error
 FATAL:  role "data_analyst_case" does not exist
```

After some playing around, I just created the tables in Postgres directly, and submit the SQL code directly.

