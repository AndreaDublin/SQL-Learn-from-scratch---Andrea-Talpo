
/*
How many sources and how many campaigns does Cool-Tshirts.com use and how do these relate? - slide 5 in the deck
*/

SELECT DISTINCT utm_source AS 'Traffic source', 
 utm_campaign AS 'Campaign name'
FROM page_visits
ORDER BY 1,2;

/*
What pages 
are on Cool-Tshirts.com? - slide 6 in the deck
*/

SELECT DISTINCT page_name AS 'Page name'
FROM page_visits;

/*
How many first touches is each campaign responsible for? - slides 8 and 16 in the deck
*/

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_campaign AS 'First Touch Campaign',
       COUNT(*) AS 'Total'
FROM ft_attr
GROUP BY 1
ORDER BY 2 DESC;

/*
How many last touches is each campaign responsible for? - slide 9 in the deck
*/

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_campaign AS 'Last Touch Campaign',
       COUNT(*) AS 'Total'
FROM lt_attr
GROUP BY 1
ORDER BY 2 DESC;

/*
How many visitors make a purchase? - slide 10 in the deck (first query)
*/

SELECT COUNT(DISTINCT user_id) AS 'Total Users Reached'
FROM page_visits;

/*
How many visitors make a purchase? - slide 10 in the deck (second query)
*/

SELECT
COUNT(DISTINCT user_id) AS 'Total Converters'
FROM page_visits
WHERE page_name = '4 - purchase';

/*
How many last touches on the purchase page is each campaign responsible for? slides 11, 13 and 15 and 16 in the deck.
*/

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
      FROM page_visits
  WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_campaign AS 'Last Touch Campaign',
       COUNT(*) AS 'Total'
FROM lt_attr
GROUP BY 1
ORDER BY 2 DESC;

/*
How many unique users go through each step of the funnel? - slide 13 in the deck.
*/

SELECT page_name AS 'Page name',
 COUNT(DISTINCT user_id) AS 'Total'
  FROM page_visits
  GROUP BY 1
  ORDER BY 2 DESC;

/*
How many of the users reached by the campaigns made a purchase? - not used in the deck.
*/

SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';

/* 
How many unique users visited the website after being exposed to the campaigns? - not used in the deck.
*/

SELECT COUNT(DISTINCT user_id)
FROM page_visits;
























