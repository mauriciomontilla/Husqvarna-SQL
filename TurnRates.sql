/*
This query takes the weekly snapshots of Stock On Hand and Rolling Demand 12 Months in Europe, Asia, the UK and South Africa
Then, it calculates the turn rates. The granularity: warehouse / buyer code / supplier / ( year - week )

Author: Mauricio Montilla
*/
SELECT
  CASE 
    WHEN CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) = 53 THEN ( w8.w8year - 1 )
    ELSE w8.w8year 
  END AS "Year"
  , CAST ( SUBSTRING ( w8.w8peri , 1 , 4 ) || '-' || SUBSTRING ( w8.w8peri , 5 , 2 ) || '-' || '01' AS DATE ) AS "Month"
  , CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) AS "Week"
  , w8.w8stor AS "Wh"
  , w8.w8buy AS "Buyer"
  , vh.vhadr1 as "Name"
  , vh.vhadr3 AS "Team"
  , w8.w8spno AS "Supplier"
	, k1.k1ys01 as "Supplier Name"
  , k6.k6lt1 AS "Transport LT" -- As in G11, third screen
  , IFNULL ( vl.vllnam , 0 ) AS "Country"
  , w8.w8tsv AS "Stock Value"
  , w8.w8cos AS "Cost of Sales"

FROM rexndcdta.alpxw8 w8
  LEFT JOIN rexndcdta.alpuk1 k1 ON k1.k1spno = w8.w8spno
  LEFT JOIN rexndcdta.alpuk6 AS k6 ON k6.k6stor = w8.w8stor AND k6.k6spno = w8.w8spno
  LEFT JOIN rexndcshr.algevh vh on vh.vhbuy = w8.w8buy
  LEFT JOIN rexndcshr.algevl vl on vl.vlland = k1.k1land
  
WHERE w8.w8rec = 'R01'
  AND w8.w8stor IN ( '05' , 'LAIC' , 'CEE' , 'ADC' , '11' )
  AND w8.w8year IN ( YEAR ( NOW () ) , YEAR ( NOW () ) - 1 , YEAR ( NOW () ) - 2 )
  AND ( w8.w8tsv > 0 OR w8.w8cos > 0 )
  AND vh.vhadr3 in ( 'SP' , 'SP - OBS' , 'ACC' , 'ACC - OBS' , 'SPECIAL' )
----------
UNION ALL
----------
SELECT
  CASE 
    WHEN CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) = 53 THEN ( w8.w8year - 1 )
    ELSE w8.w8year 
  END AS "Year"
  , CAST ( SUBSTRING ( w8.w8peri , 1 , 4 ) || '-' || SUBSTRING ( w8.w8peri , 5 , 2 ) || '-' || '01' AS DATE ) AS "Month"
  , CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) AS "Week"
  , w8.w8stor AS "Wh"
  , w8.w8buy AS "Buyer"
  , vh.vhadr1 as "Name"
  , vh.vhadr3 AS "Team"
  , w8.w8spno AS "Supplier"
	, k1.k1ys01 as "Supplier Name"
  , k6.k6lt1 AS "Transport LT" -- As in G11, third screen
  , IFNULL ( vl.vllnam , 0 ) AS "Country"
  , w8.w8tsv AS "Stock Value"
  , w8.w8cos AS "Cost of Sales"

FROM rexhgbdta.alpxw8 w8
  LEFT JOIN rexhgbdta.alpuk1 k1 ON k1.k1spno = w8.w8spno
  LEFT JOIN rexhgbdta.alpuk6 AS k6 ON k6.k6stor = w8.w8stor AND k6.k6spno = w8.w8spno
  LEFT JOIN rexndcshr.algevh vh on vh.vhbuy = w8.w8buy
  LEFT JOIN rexhgbshr.algevl vl on vl.vlland = k1.k1land
  
WHERE w8.w8rec = 'R01'
  AND w8.w8stor IN ( 'DON1' )
  AND w8.w8year IN ( YEAR ( NOW () ) , YEAR ( NOW () ) - 1 , YEAR ( NOW () ) - 2 )
  AND ( w8.w8tsv > 0 OR w8.w8cos > 0 )
  AND vh.vhadr3 in ( 'SP' , 'SP - OBS' , 'ACC' , 'ACC - OBS' , 'SPECIAL' )
----------
UNION ALL
----------
SELECT
  CASE 
    WHEN CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) = 53 THEN ( w8.w8year - 1 )
    ELSE w8.w8year 
  END AS "Year"
  , CAST ( SUBSTRING ( w8.w8peri , 1 , 4 ) || '-' || SUBSTRING ( w8.w8peri , 5 , 2 ) || '-' || '01' AS DATE ) AS "Month"
  , CAST ( SUBSTRING ( w8.w8week , 5 , 2 ) AS INT ) AS "Week"
  , w8.w8stor AS "Wh"
  , w8.w8buy AS "Buyer"
  , vh.vhadr1 as "Name"
  , vh.vhadr3 AS "Team"
  , w8.w8spno AS "Supplier"
	, k1.k1ys01 as "Supplier Name"
  , k6.k6lt1 AS "Transport LT" -- As in G11, third screen
  , IFNULL ( vl.vllnam , 0 ) AS "Country"
  , w8.w8tsv AS "Stock Value"
  , w8.w8cos AS "Cost of Sales"

FROM rexhzadta.alpxw8 w8
  LEFT JOIN rexhzadta.alpuk1 k1 ON k1.k1spno = w8.w8spno
  LEFT JOIN rexhzadta.alpuk6 AS k6 ON k6.k6stor = w8.w8stor AND k6.k6spno = w8.w8spno
  LEFT JOIN rexndcshr.algevh vh on vh.vhbuy = w8.w8buy
  LEFT JOIN rexhgbshr.algevl vl on vl.vlland = k1.k1land
  
WHERE w8.w8rec = 'R01'
  AND w8.w8stor IN ( '139A' )
  AND w8.w8year IN ( YEAR ( NOW () ) , YEAR ( NOW () ) - 1 , YEAR ( NOW () ) - 2 )
  AND ( w8.w8tsv > 0 OR w8.w8cos > 0 )
  AND vh.vhadr3 in ( 'SA' , 'SP' )
----------
