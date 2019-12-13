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

After attempting to play around for a good while, I decided to just created the tables in my Postgres database directly (through pgAdmin), and submit the SQL code as its own file.


### Comment #2
Why do **'spending'** and **'net_revenue'** have negative values sometimes?
	- Does a negative **'spending'** mean a refund from a marketing channel, because a budget that was allocated to that channel was not fully used? (I notice it's always on the first of a month.)
	- Does a negative 'net_revenue' mean a customer subscription was refunded?

I will be assuming that I can include the negative values in the totals / averages of **'spending'** and **'net_revenue'**. 

(e.g. If a marketing channel didn't use all the funds 'spent' previously and refunded the unused money back, then I assume that contributes to lesser overall spending.)


### Comment #3
For personal convenience, I will be evaluating / presenting the currencies as USD. I am aware that the metrics are likely scaled versions of Euros, but in the context of the exercise, the overall analysis shouldn't be affected. 

- UPDATE: Accounting is actually done in USD. 


### Comment #4
I find it interesting that the exercise asks to consider the UK as a possible investment, given that the UK country code isn't mentioned anywhere in the data spreadsheets. 

I will assume this is not a typo, and that the Head of Performance Marketing is asking about perhaps newly penetrating into the UK.

- UPDATE: United Kingdom is actually country code GB (Great Britain)


### Comment #5
I'm a bit unclear as to the level of detail required for the presentation challenge. I'd certainly love to show the different ways I look at data in detail, but I'm always aware that when presenting to upper management, sometimes the data presented shouldn't be TOO overwhelming.

- UPDATE: High-level summary for presentation is enough. More cuts of data are shown in the additional BREAKDOWN tabs in Excel spreadsheet.

