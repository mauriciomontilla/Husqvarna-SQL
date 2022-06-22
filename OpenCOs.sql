/*
This query shows the current open CO lines for the warehouse in Europe, Asia, and the UK

Author: Mauricio Montilla
*/
SELECT
  c1.c1cus AS "Customer"
  , LEFT ( a1.a1adr1 , 15 ) AS "Customer Name-" 
  , c1.c1cr1 AS "Po Customer"
  , c1.c1otp AS "Order type" 
  , cd.cdstor AS "Wh"
  , g1.g1buy AS "Buyer"
  , gm.gmspno AS "Supplier"
  , cd.cdonoc AS "Order" 
  , cd.cdlinc AS "Line" 
  , CAST (cd.cdpno AS INT ) AS "Pn"
  , cd.cdqtd AS "Qty. Ordered"
  , cd.cdxstd AS "Status"
  , cd.cdwrq AS "Week requested"
  , cd.cdwpr AS "Week promised" 
  , c1.c1vcre AS "Date created"
  , CASE 
    WHEN cd.cdvd5 = 0 THEN cd.cdvchg
    ELSE cd.cdvd5
    END AS "Release date"
  , cd.cdvpic AS "Pick date"
  , cd.cdrnop AS "Stop Reason"
  , (gj.gjzcp * cd.cdqtd) AS "Order value"
  , (g1.g1netw * cd.cdqtd) AS "Order weight"
  , TRIM(d1.d1xpst) || TRIM( d1.d1xist ) AS "Rex Port"
  , TRIM(d1.d1porn) || '-' || TRIM(d1.d1pidx) AS "Portion"

FROM rexndcdta.alcocd cd
  LEFT JOIN rexndcdta.alcoc1 c1 ON c1.c1onoc = cd.cdonoc
  LEFT JOIN rexport.alexd2 d2 ON d2.d2onoc = cd.cdonoc AND d2.d2linc = cd.cdlinc AND d2.d2lind = cd.cdlind AND d2.d2dlid = cd.cddlid
  LEFT JOIN rexport.alexd1 d1 ON TRIM(d1.d1porn) = TRIM(d2.d2porn) AND TRIM(d1.d1pidx) = TRIM(d2.d2pidx) AND d2.d2onoc = d1.d1onoc 
  LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = cd.cdpno AND gj.gjxps = '1' AND gj.gjtype = '1'
  LEFT JOIN rexndcdta.alicg1 g1 ON g1.g1pno = cd.cdpno
  LEFT JOIN rexndcdta.alcoa1 a1 ON a1.a1cus = c1.c1cus
  LEFT JOIN rexndcdta.alicgm gm ON gm.gmpno = cd.cdpno AND gm.gmstor = '****' AND gm.gmspri = 1
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy

WHERE cd.cdstor IN ( '05' , 'CEE' , 'ADC' , '11' )
  AND c1.c1otp IN ( '10' , '44' ,  '40' )
  AND cd.cdxstd IN ( '2' , '5' , '7' )
  AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' )		
-------------------------------------
UNION ALL
-------------------------------------
SELECT  
  c1.c1cus AS "Customer"
  , LEFT ( a1.a1adr1 , 15 ) AS "Customer Name-" 
  , c1.c1cr1 AS "Po Customer"
  , c1.c1otp AS "Order type" 
  , cd.cdstor AS "Wh"
  , g1.g1buy AS "Buyer"
  , gm.gmspno AS "Supplier"
  , cd.cdonoc AS "Order" 
  , cd.cdlinc AS "Line" 
  , CAST (cd.cdpno AS INT ) AS "Pn"
  , cd.cdqtd AS "Qty. Ordered"
  , cd.cdxstd AS "Status"
  , cd.cdwrq AS "Week requested"
  , cd.cdwpr AS "Week promised" 
  , c1.c1vcre AS "Date created"
  , CASE 
    WHEN cd.cdvd5 = 0 THEN cd.cdvchg
    ELSE cd.cdvd5
   END AS "Release date"
  , cd.cdvpic AS "Pick date"
  , cd.cdrnop AS "Stop Reason"
  , (gj.gjzcp * cd.cdqtd) AS "Order value"
  , (g1.g1netw * cd.cdqtd) AS "Order weight"
  , '' AS "Rex Port"
  , '' AS "Portion"

FROM rexhgbdta.alcocd cd
  LEFT JOIN rexhgbdta.alcoc1 c1 ON c1.c1onoc = cd.cdonoc
  LEFT JOIN rexhgbdta.alicgj gj ON gj.gjpno = cd.cdpno  AND gj.gjxps = '1' AND gj.gjtype = '1'
  LEFT JOIN rexhgbdta.alicg1 g1 ON g1.g1pno = cd.cdpno
  LEFT JOIN rexhgbdta.alcoa1 a1 ON a1.a1cus = c1.c1cus
  LEFT JOIN rexhgbdta.alicgm gm ON gm.gmpno = cd.cdpno AND gm.gmstor = '****' AND gm.gmspri = 1
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy

WHERE cd.cdstor IN ( 'DON1' )
  AND c1.c1otp IN ( '10' , '44' ,  '40' )
  AND cd.cdxstd IN ( '2' , '5' , '7' )
  AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' )		
-------------------------------------
