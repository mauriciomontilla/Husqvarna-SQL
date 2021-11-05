/* 
Table alsmxs was designed from the beginning to fit Power BI reports,
The goal is to visualize the development of back orders in different dimensions,
Such as total back orders, value of back orders, quantity in back order,
This information is highly confidential and can only be used internally.
*/
-- This query will get together the graphs from NDC HGB, ad HZA
SELECT
rt."Store"
, rt."Buyer"
, rt."Name"
, rt."Team"
, rt."Supplier"
, rt."Comm. Ref"
, rt."Date"
, rt."Week"
, rt."Year"
, CASE
	WHEN rt."Year" = (YEAR (NOW()) -1) THEN rt."Total Back Orders" ELSE 0
END AS "Total Back Orders Last Year"
, CASE
	WHEN rt."Year" = YEAR (NOW()) THEN rt."Total Back Orders" ELSE 0
END AS "Total Back Orders This Year"
, CASE
	WHEN rt."Year" = (YEAR (NOW()) -1) THEN rt."Value Back Orders" ELSE 0
END AS "Value Back Orders Last Year"
, CASE
	WHEN rt."Year" = YEAR (NOW()) THEN rt."Value Back Orders" ELSE 0
END AS "Value Back Orders This Year"
, CASE
	WHEN rt."Year" = (YEAR (NOW()) -1) THEN rt."New Orders Released" ELSE 0
END AS "New Orders Released Last Year"
, CASE
	WHEN rt."Year" = (YEAR (NOW()) -1) THEN rt."New Back Orders" ELSE 0
END AS "New Back Orders Last Year"
, CASE
	WHEN rt."Year" = YEAR (NOW()) THEN rt."New Orders Released" ELSE 0
END AS "New Orders Released This Year"
, CASE
	WHEN rt."Year" = YEAR (NOW()) THEN rt."New Back Orders" ELSE 0
END AS "New Back Orders This Year"

FROM (
-- This query will produce the graphs for NDC warehouses
SELECT
    'NDC - ' || sl."Store" AS "Store"
	, sl."Buyer" AS "Buyer"
	, vh.vhadr1 AS "Name"
	, vh.vhadr3 AS "Team"
    , sl."Supplier"
    , sl."Comm. Ref"
    , CAST ( SUBSTRING ( vc.vcv , 1 , 4 ) || '-' || SUBSTRING ( vc.vcv , 5 , 2 ) || '-' || SUBSTRING ( vc.vcv , 7 , 2 ) AS DATE ) AS "Date"
    , ( 'w' || RIGHT ( vc.vcw , 2 ) ) AS "Week"
    , CASE
        WHEN ( RIGHT ( vc.vcw , 2 ) ) = '01' AND vc.vcmm = 12 THEN ( vc.vccc || (vc.vcyy + 1) )
        ELSE ( vc.vccc || vc.vcyy )
    END AS "Year"
    , IFNULL ( bo."Total Back Orders" , 0 ) AS "Total Back Orders"
    , IFNULL ( bo."Value Back Orders" , 0 ) AS "Value Back Orders"
    , sl."New Orders Released"
    , sl."New Back Orders"

FROM rexndcshr.algevc vc -- This table contains all the dates from 1993 up to day
  LEFT JOIN (
  ----------
    SELECT
      xd.xdstor AS "Store"
      , xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"
      , xd.xdyy AS "Year"
      , CAST ( RIGHT ( xd.xdww , 2 ) AS INT ) AS "Week"
      , SUM ( xd.xdolpn ) AS "New Orders Released"
      , SUM ( xd.xdolbn ) AS "New Back Orders"

    FROM rexndcloc.alsmxdnew xd --This table contains the historical service level (X142)

    GROUP BY
      xd.xdstor
      , xd.xdbuy
      , xd.xdspno
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xd.xdyy
      , xd.xdww
  ----------
	UNION ALL
  ----------
    SELECT DISTINCT --This subquery allows to get back orders for the current week on Mondays
			xd.xdstor AS "Store"
			, xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"      
      , xd.xdyy AS "Year"
			,CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN ( WEEK ( NOW () ) - 1 )
				ELSE NULL
			END AS "Week"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Orders Released"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Back Orders"

    FROM rexndcloc.alsmxdnew xd --This table contains the historical service level (X141)

    WHERE xd.xdyy = YEAR ( NOW() )
  ----------
  ) sl ON sl."Year" = ( vc.vccc || vc.vcyy ) AND sl."Week" = CAST ( RIGHT ( vc.vcw , 2 ) AS INT )
  LEFT JOIN (
    SELECT
      xs.xsstor AS "Store"
      , xs.xsbuy AS "Buyer"
	    , xs.xsspno AS "Supplier"
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"
      , CAST ( RIGHT ( xs.xsweek , 2 ) AS INT ) AS "Week"
      , CAST ( LEFT ( xs.xsweek , 4 ) AS INT ) AS "Year"
      , SUM ( xs.xsant ) AS "Total Back Orders"
      , SUM ( xs.xszcp ) AS "Value Back Orders"

    FROM rexndcdta.alsmxs xs --This table contains the historical back orders (X055)

    WHERE xs.xsbotp = 'BO'

    GROUP BY
      xs.xsstor
      , xs.xsbuy
      , xs.xsspno
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xs.xsweek
  ) bo ON bo."Year" = sl."Year"
    AND bo."Week" = sl."Week"
    AND bo."Store" = sl."Store" 
    AND bo."Buyer" = sl."Buyer" 
    AND bo."Supplier" = sl."Supplier"
    AND bo."Comm. Ref" = sl."Comm. Ref"
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = sl."Buyer" --This table contains the teams (G14)

WHERE sl."Store" IN ( '05' , 'ADC' , 'CEE' , '11' ) --Whs to analyze in Back Orders
	AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' ) --Teams to analyze in Back Orders (G14)
	AND ( vc.vccc || vc.vcyy ) IN ( YEAR ( NOW() ) - 1 , YEAR ( NOW() ) ) --Previous year, current year
	AND vc.vcwd = 1 --Back order should be retrieved only on Mondays (1)
----------
UNION ALL
-- This query will produce the graph for HGB warehouse
SELECT
    'HGB - ' || sl."Store" AS "Store"
	, sl."Buyer" AS "Buyer"
	, vh.vhadr1 AS "Name"
	, vh.vhadr3 AS "Team"
    , sl."Supplier"
    , sl."Comm. Ref"
    , CAST ( SUBSTRING ( vc.vcv , 1 , 4 ) || '-' || SUBSTRING ( vc.vcv , 5 , 2 ) || '-' || SUBSTRING ( vc.vcv , 7 , 2 ) AS DATE ) AS "Date"
    , ( 'w' || RIGHT ( vc.vcw , 2 ) ) AS "Week"
	, CASE
		WHEN ( RIGHT ( vc.vcw , 2 ) ) = '01' AND vc.vcmm = 12 THEN ( vc.vccc || (vc.vcyy + 1) )
		ELSE ( vc.vccc || vc.vcyy )
	END AS "Year"
    , IFNULL ( bo."Total Back Orders" , 0 ) AS "Total Back Orders"
    , IFNULL ( bo."Value Back Orders" , 0 ) AS "Value Back Orders"
    , sl."New Orders Released"
    , sl."New Back Orders"

FROM rexndcshr.algevc vc -- This table contains all the dates from 1993 up to day
  LEFT JOIN (
  ----------
    SELECT
      xd.xdstor AS "Store"
      , xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"
      , xd.xdyy AS "Year"
      , CAST ( RIGHT ( xd.xdww , 2 ) AS INT ) AS "Week"
      , SUM ( xd.xdolpn ) AS "New Orders Released"
      , SUM ( xd.xdolbn ) AS "New Back Orders"

    FROM rexhgbloc.alsmxdnew xd --This table contains the historical service level (X142)

    GROUP BY
      xd.xdstor
      , xd.xdbuy
      , xd.xdspno
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xd.xdyy
      , xd.xdww
  ----------
	UNION ALL
  ----------
    SELECT DISTINCT --This subquery allows to get back orders for the current week on Mondays
			xd.xdstor AS "Store"
			, xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"      
      , xd.xdyy AS "Year"
			,CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN ( WEEK ( NOW () ) - 1 )
				ELSE NULL
			END AS "Week"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Orders Released"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Back Orders"

    FROM rexhgbloc.alsmxdnew xd --This table contains the historical service level (X141)

    WHERE xd.xdyy = YEAR ( NOW() )
  ----------
  ) sl ON sl."Year" = ( vc.vccc || vc.vcyy ) AND sl."Week" = CAST ( RIGHT ( vc.vcw , 2 ) AS INT )
  LEFT JOIN (
    SELECT
      xs.xsstor AS "Store"
      , xs.xsbuy AS "Buyer"
	    , xs.xsspno AS "Supplier"
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"
      , CAST ( RIGHT ( xs.xsweek , 2 ) AS INT ) AS "Week"
      , CAST ( LEFT ( xs.xsweek , 4 ) AS INT ) AS "Year"
      , SUM ( xs.xsant ) AS "Total Back Orders"
      , ( SUM ( xs.xszcp ) * 11.61 ) AS "Value Back Orders"

    FROM rexhgbdta.alsmxs xs --This table contains the historical back orders (X055)

    WHERE xs.xsbotp = 'BO'

    GROUP BY
      xs.xsstor
      , xs.xsbuy
      , xs.xsspno
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xs.xsweek
  ) bo ON bo."Year" = sl."Year"
    AND bo."Week" = sl."Week"
    AND bo."Store" = sl."Store" 
    AND bo."Buyer" = sl."Buyer" 
    AND bo."Supplier" = sl."Supplier"
    AND bo."Comm. Ref" = sl."Comm. Ref"
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = sl."Buyer" --This table contains the teams (G14)

WHERE sl."Store" IN ( 'DON1', 'AYC') --Whs to analyze in Back Orders
  AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' ) --Teams to analyze in Back Orders (G14)
	AND ( vc.vccc || vc.vcyy ) IN ( YEAR ( NOW() ) - 1 , YEAR ( NOW() ) ) --Previous year, current year
	AND vc.vcwd = 1 --Back order should be retrieved only on Mondays (1)
----------
UNION ALL
-- This query will produce the graph for HZA warehouse
SELECT
    'HZA - ' || sl."Store" AS "Store"
	, sl."Buyer" AS "Buyer"
	, vh.vhadr1 AS "Name"
	, vh.vhadr3 AS "Team"
    , sl."Supplier"
    , sl."Comm. Ref"
    , CAST ( SUBSTRING ( vc.vcv , 1 , 4 ) || '-' || SUBSTRING ( vc.vcv , 5 , 2 ) || '-' || SUBSTRING ( vc.vcv , 7 , 2 ) AS DATE ) AS "Date"
    , ( 'w' || RIGHT ( vc.vcw , 2 ) ) AS "Week"
	, CASE
		WHEN ( RIGHT ( vc.vcw , 2 ) ) = '01' AND vc.vcmm = 12 THEN ( vc.vccc || (vc.vcyy + 1) )
		ELSE ( vc.vccc || vc.vcyy )
	END AS "Year"
    , IFNULL ( bo."Total Back Orders" , 0 ) AS "Total Back Orders"
    , IFNULL ( bo."Value Back Orders" , 0 ) AS "Value Back Orders"
    , sl."New Orders Released"
    , sl."New Back Orders"

FROM rexndcshr.algevc vc -- This table contains all the dates from 1993 up to day
  LEFT JOIN (
  ----------
    SELECT
      xd.xdstor AS "Store"
      , xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"      
      , xd.xdyy AS "Year"
      , CAST ( RIGHT ( xd.xdww , 2 ) AS INT ) AS "Week"
      , SUM ( xd.xdolpn ) AS "New Orders Released"
      , SUM ( xd.xdolbn ) AS "New Back Orders"

    FROM rexhzaloc.alsmxdnew xd --This table contains the historical service level (X142)

    GROUP BY
      xd.xdstor
      , xd.xdbuy
      , xd.xdspno
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xd.xdyy
      , xd.xdww
  ----------
	UNION ALL
  ----------
    SELECT DISTINCT --This subquery allows to get back orders for the current week on Mondays
			xd.xdstor AS "Store"
			, xd.xdbuy AS "Buyer"
	    , xd.xdspno AS "Supplier"
      , CASE 
        WHEN xd.xdcomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"      
      , xd.xdyy AS "Year"
			,CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN ( WEEK ( NOW () ) - 1 )
				ELSE NULL
			END AS "Week"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Orders Released"
			, CASE 
				WHEN DAYNAME ( NOW () ) = 'Monday' THEN 0
				ELSE NULL
			END AS "New Back Orders"

    FROM rexhzaloc.alsmxdnew xd --This table contains the historical service level (X141)

    WHERE xd.xdyy = YEAR ( NOW() )
  ----------
  ) sl ON sl."Year" = ( vc.vccc || vc.vcyy ) AND sl."Week" = CAST ( RIGHT ( vc.vcw , 2 ) AS INT )
  LEFT JOIN (
    SELECT
      xs.xsstor AS "Store"
      , xs.xsbuy AS "Buyer"
	    , xs.xsspno AS "Supplier"
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END AS "Comm. Ref"
      , CAST ( RIGHT ( xs.xsweek , 2 ) AS INT ) AS "Week"
      , CAST ( LEFT ( xs.xsweek , 4 ) AS INT ) AS "Year"
      , SUM ( xs.xsant ) AS "Total Back Orders"
      , ( SUM ( xs.xszcp ) * 0.56 ) AS "Value Back Orders"

    FROM rexhzadta.alsmxs xs --This table contains the historical back orders (X016)

    WHERE xs.xsbotp = 'BO'

    GROUP BY
      xs.xsstor
      , xs.xsbuy
      , xs.xsspno
      , CASE 
        WHEN xs.xscomr = 'GSPTP' THEN 'GSPTP'
        ELSE ''
      END
      , xs.xsweek
  ) bo ON bo."Year" = sl."Year"
    AND bo."Week" = sl."Week"
    AND bo."Store" = sl."Store" 
    AND bo."Buyer" = sl."Buyer" 
    AND bo."Supplier" = sl."Supplier"
    AND bo."Comm. Ref" = sl."Comm. Ref"
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = sl."Buyer" --This table contains the teams (G14)

WHERE sl."Store" IN ( '139A' ) --Whs to analyze in Back Orders
  AND vh.vhadr3 IN ( 'SP' , 'SA' ) --Teams to analyze in Back Orders (G14)
	AND ( vc.vccc || vc.vcyy ) IN ( YEAR ( NOW() ) - 1 , YEAR ( NOW() ) ) --Previous year, current year
	AND vc.vcwd = 1 --Back order should be retrieved only on Mondays (1)
----------
) rt --Rex Tables
