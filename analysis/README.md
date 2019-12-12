# Additional Comments

### Comment #1
With Docker, I was able to connect to the container from psql with:
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


### Comment #2
Why do **'spending'** and **'net_revenue'** have negative values sometimes?
	- Does a negative **'spending'** mean a refund from a marketing channel, because a budget that was allocated to that channel was not fully used? (I notice it's always on the first of a month.)
	- Does a negative 'net_revenue' mean a customer subscription was refunded?

I will be assuming that I can include the negative values in the totals / averages of **'spending'** and **'net_revenue'**. 

(e.g. If a marketing channel didn't use all the funds 'spent' previously and refunded the unused money back, then I assume that contributes to lesser overall spending.)


### Comment #3
For personal convenience, I will be evaluating the currencies as USD. I am aware that the metrics are perhaps scaled versions of Euros, but in the context of the exercise, the overall analysis shouldn't be affected. 


### Comment #4
I find it interesting that the exercise asks to consider the UK as a possible investment, given that the UK country code isn't mentioned anywhere in the data spreadsheets. 

I will assume this is not a typo, and that the Head of Performance Marketing is asking about perhaps newly penetrating into the UK.

