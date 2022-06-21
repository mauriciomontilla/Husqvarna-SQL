/*
This query takes the weekly report of new orders shipped and new order in backlog in Europe, Asia, UK and Africa
Then, it calculates the Service Level. The granularity: warehouse / buyer code / supplier / ( year - week )

Author: Mauricio Montilla
*/
SELECT 
      xd.xdstor AS "Wh"
      , xd.xdprct AS "Category"
      , vh.vhadr1 AS "Name"
      , vh.vhadr3 AS "Team"
      , xd.xdbuy AS "Buyer"
      , xd.xdcus AS "Customer"
      , a1.a1adr1 AS "Customer Name"
      , xd.xdspno AS "Supplier"
      , k1.k1ys01 AS "Supplier Name"
      , xd.xdyy AS "Year"
      , xd.xdww AS "Week"
      , SUM ( XD.XDOLPN ) AS "New order lines" 
      , SUM ( XD.XDOLBN ) AS "New Bos"

FROM rexndcloc.alsmxdnew xd
      LEFT JOIN rexndcdta.alcoa1 a1 ON a1.a1cus = xd.xdcus
      LEFT JOIN rexndcdta.alpuk1 k1 ON k1.k1spno = xd.xdspno
      LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = xd.xdbuy

WHERE xd.xdyy IN ( YEAR( NOW ( ) ) - 2 , YEAR( NOW ( ) ) - 1  , YEAR( NOW ( ) ) )
      AND xd.xdstor IN ( '05' , 'ADC' , 'CEE' , '11' )
      AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )

GROUP BY
      xd.xdstor
      , xd.xdprct
      , vh.vhadr1
      , vh.vhadr3
      , xd.xdbuy
      , xd.xdcus
      , a1.a1adr1
      , xd.xdspno
      , k1.k1ys01
      , xd.xdyy
      , xd.xdww
----------
UNION ALL
----------
SELECT 
      xd.xdstor AS "Wh"
      , xd.xdprct AS "Category"
      , vh.vhadr1 AS "Name"
      , vh.vhadr3 AS "Team"
      , xd.xdbuy AS "Buyer"
      , xd.xdcus AS "Customer"
      , a1.a1adr1 AS "Customer Name"
      , xd.xdspno AS "Supplier"
      , k1.k1ys01 AS "Supplier Name"
      , xd.xdyy AS "Year"
      , xd.xdww AS "Week"
      , SUM ( XD.XDOLPN ) AS "New order lines" 
      , SUM ( XD.XDOLBN ) AS "New Bos"

FROM rexhgbloc.alsmxdnew xd
      LEFT JOIN rexhgbdta.alcoa1 a1 ON a1.a1cus = xd.xdcus
      LEFT JOIN rexhgbdta.alpuk1 k1 ON k1.k1spno = xd.xdspno
      LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = xd.xdbuy

WHERE xd.xdyy IN ( YEAR( NOW ( ) ) - 2 , YEAR( NOW ( ) ) - 1  , YEAR( NOW ( ) ) )
      AND xd.xdstor IN ( 'DON1' )
      AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )

GROUP BY
      xd.xdstor
      , xd.xdprct
      , vh.vhadr1
      , vh.vhadr3
      , xd.xdbuy
      , xd.xdcus
      , a1.a1adr1
      , xd.xdspno
      , k1.k1ys01
      , xd.xdyy
      , xd.xdww
----------
UNION ALL
----------
SELECT 
      xd.xdstor AS "Wh"
      , xd.xdprct AS "Category"
      , vh.vhadr1 AS "Name"
      , vh.vhadr3 AS "Team"
      , xd.xdbuy AS "Buyer"
      , xd.xdcus AS "Customer"
      , a1.a1adr1 AS "Customer Name"
      , xd.xdspno AS "Supplier"
      , k1.k1ys01 AS "Supplier Name"
      , xd.xdyy AS "Year"
      , xd.xdww AS "Week"
      , SUM ( XD.XDOLPN ) AS "New order lines" 
      , SUM ( XD.XDOLBN ) AS "New Bos"

FROM rexhzaloc.alsmxdnew xd
      LEFT JOIN rexhzadta.alcoa1 a1 ON a1.a1cus = xd.xdcus
      LEFT JOIN rexhzadta.alpuk1 k1 ON k1.k1spno = xd.xdspno
      LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = xd.xdbuy

WHERE xd.xdyy IN ( YEAR( NOW ( ) ) - 2 , YEAR( NOW ( ) ) - 1  , YEAR( NOW ( ) ) )
      AND xd.xdstor IN ( '139A' )
      AND vh.vhadr3 IN ( 'SP' , 'SA' )

GROUP BY
      xd.xdstor
      , xd.xdprct
      , vh.vhadr1
      , vh.vhadr3
      , xd.xdbuy
      , xd.xdcus
      , a1.a1adr1
      , xd.xdspno
      , k1.k1ys01
      , xd.xdyy
      , xd.xdww
----------
