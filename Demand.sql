/*
This query shows the demand of the last 12 months, excluding current month, i.e., Rolling Demand
For the warehouse in Europe, Asia, the UK and South Africa

Author: Mauricio Montilla
*/
SELECT
  "Pn"
  , "Buyer"
  , "Supplier"
  , "Wh"
  , "Avail."
  , "Po"
  , "Total LT"
  , "Month - 12"
  , "Month - 11"
  , "Month - 10"
  , "Month - 09"
  , "Month - 08"
  , "Month - 07"
  , "Month - 06"
  , "Month - 05"
  , "Month - 04"
  , "Month - 03"
  , "Month - 02"
  , "Month - 01"
  , ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) AS "Roll. Dem. Y"
  
FROM (
  ---------
  SELECT
    CAST ( g1.g1pno AS INT )AS "Pn"
    , g1.g1buy AS "Buyer"
    , gm.gmspno AS "Supplier"
    , gq.gqstor AS "Wh"
    , ( gq.gqqys - gq.gqqyr ) AS "Avail."
    , gq.gqqyp AS "Po"
    , ( gm.gmlt1 + gm.gmlt3 ) AS "Total LT"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN previous_year.gtcb12
    END , 0 ) AS "Month - 12"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb01
    END , 0 ) AS "Month - 11"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb02
    END , 0 ) AS "Month - 10"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb03
    END , 0 ) AS "Month - 09"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb04
    END , 0 ) AS "Month - 08"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb05
    END , 0 ) AS "Month - 07"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb06
    END , 0 ) AS "Month - 06"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb07
    END , 0 ) AS "Month - 05"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb08
    END , 0 ) AS "Month - 04"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb09
    END , 0 ) AS "Month - 03"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb10
    END , 0 ) AS "Month - 02"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb11
    END , 0 ) AS "Month - 01"

  FROM rexndcdta.alicg1 g1
    LEFT JOIN rexndcdta.alicgq gq ON gq.gqpno = g1.g1pno
    LEFT JOIN rexndcdta.alicgm gm ON gm.gmpno = g1.g1pno AND gm.gmstor = '****' AND gm.gmspri = '1'
    LEFT JOIN rexndcdta.alicgt current_year ON current_year.gtpno = gq.gqpno AND current_year.gtstor = gq.gqstor AND current_year.gtyear = YEAR(NOW())
    LEFT JOIN rexndcdta.alicgt previous_year ON previous_year.gtpno = gq.gqpno AND previous_year.gtstor = gq.gqstor AND previous_year.gtyear = (YEAR(NOW()) - 1)
    LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy	

  WHERE vh.vhadr3 in ( 'SP' , 'ACC' )
    AND current_year.gtstor IN ( '05' , 'LAIC' , 'CEE' , 'ADC' )
    AND ( gm.gmlt1  + gm.gmlt3 ) > 0
  ---------
  UNION ALL
  ---------
  SELECT
    CAST ( g1.g1pno AS INT )AS "Pn"
    , g1.g1buy AS "Buyer"
    , gm.gmspno AS "Supplier"
    , gq.gqstor AS "Wh"
    , ( gq.gqqys - gq.gqqyr ) AS "Avail."
    , gq.gqqyp AS "Po"
    , ( gm.gmlt1  + gm.gmlt3 ) AS "Total LT"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN previous_year.gtcb12
    END , 0 ) AS "Month - 12"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb01
    END , 0 ) AS "Month - 11"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb02
    END , 0 ) AS "Month - 10"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb03
    END , 0 ) AS "Month - 09"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb04
    END , 0 ) AS "Month - 08"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb05
    END , 0 ) AS "Month - 07"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb06
    END , 0 ) AS "Month - 06"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb07
    END , 0 ) AS "Month - 05"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb08
    END , 0 ) AS "Month - 04"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb09
    END , 0 ) AS "Month - 03"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb10
    END , 0 ) AS "Month - 02"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb11
    END , 0 ) AS "Month - 01"

  FROM rexhgbdta.alicg1 g1
    LEFT JOIN rexhgbdta.alicgq gq ON gq.gqpno = g1.g1pno
    LEFT JOIN rexhgbdta.alicgm gm ON gm.gmpno = g1.g1pno AND gm.gmstor = '****' AND gm.gmspri = '1'
    LEFT JOIN rexhgbdta.alicgt current_year ON current_year.gtpno = gq.gqpno AND current_year.gtstor = gq.gqstor AND current_year.gtyear = YEAR(NOW())
    LEFT JOIN rexhgbdta.alicgt previous_year ON previous_year.gtpno = gq.gqpno AND previous_year.gtstor = gq.gqstor AND previous_year.gtyear = (YEAR(NOW()) - 1)
    LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy	

  WHERE vh.vhadr3 IN ( 'SP' , 'ACC' )
    AND current_year.gtstor IN ( 'DON1' )
    AND ( gm.gmlt1  + gm.gmlt3 ) > 0
  ---------
  UNION ALL
  ---------
  SELECT
    CAST ( g1.g1pno AS INT )AS "Pn"
    , g1.g1buy AS "Buyer"
    , gm.gmspno AS "Supplier"
    , gq.gqstor AS "Wh"
    , ( gq.gqqys - gq.gqqyr ) AS "Avail."
    , gq.gqqyp AS "Po"
    , ( gm.gmlt1  + gm.gmlt3 ) AS "Total LT"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN previous_year.gtcb12
    END , 0 ) AS "Month - 12"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb01
    END , 0 ) AS "Month - 11"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb02
    END , 0 ) AS "Month - 10"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb03
    END , 0 ) AS "Month - 09"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb04
    END , 0 ) AS "Month - 08"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb05
    END , 0 ) AS "Month - 07"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb06
    END , 0 ) AS "Month - 06"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb07
    END , 0 ) AS "Month - 05"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb08
    END , 0 ) AS "Month - 04"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb09
    END , 0 ) AS "Month - 03"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb11
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb10
    END , 0 ) AS "Month - 02"
    , IFNULL ( CASE
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 1 ) THEN previous_year.gtcb12
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 2 ) THEN current_year.gtcb01
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 3 ) THEN current_year.gtcb02
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 4 ) THEN current_year.gtcb03
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 5 ) THEN current_year.gtcb04
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 6 ) THEN current_year.gtcb05
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 7 ) THEN current_year.gtcb06
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 8 ) THEN current_year.gtcb07
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 9 ) THEN current_year.gtcb08
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 10 ) THEN current_year.gtcb09
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 11 ) THEN current_year.gtcb10
      WHEN ( YEAR ( NOW() ) || MONTH ( NOW() ) ) = ( YEAR ( NOW() ) || 12 ) THEN current_year.gtcb11
    END , 0 ) AS "Month - 01"

  FROM rexhzadta.alicg1 g1
    LEFT JOIN rexhzadta.alicgq gq ON gq.gqpno = g1.g1pno
    LEFT JOIN rexhzadta.alicgm gm ON gm.gmpno = g1.g1pno AND gm.gmstor = '****' AND gm.gmspri = '1'
    LEFT JOIN rexhzadta.alicgt current_year ON current_year.gtpno = gq.gqpno AND current_year.gtstor = gq.gqstor AND current_year.gtyear = YEAR(NOW())
    LEFT JOIN rexhzadta.alicgt previous_year ON previous_year.gtpno = gq.gqpno AND previous_year.gtstor = gq.gqstor AND previous_year.gtyear = (YEAR(NOW()) - 1)
    LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy	

  WHERE vh.vhadr3 IN ( 'SP' )
    AND current_year.gtstor IN ( '139A' )
    AND ( gm.gmlt1  + gm.gmlt3 ) > 0
) DemandTable

WHERE ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) > 0

ORDER BY "Roll. Dem. Y" DESC
--End, this query aims to bring a rolling demand
