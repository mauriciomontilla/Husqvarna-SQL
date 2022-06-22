/*
This query shows the current open PO lines for the warehouse in Europe, Asia, the UK and South Africa

Author: Mauricio Montilla
*/
SELECT  
  m1.m1stor AS "Wh"
  , g1.g1buy AS "Buyer"
  , m1.m1spno AS "Supp. Nr." 
  , m1.m1podm AS "Mode"
  , m2.m2onop AS "PO nr."
  , m2.m2linp AS "PO line"
  , m2.m2xpst AS "Status"
  , CAST ( m2.m2pno AS INT ) AS "Pn"
  , LEFT ( g2.g2de1 , 20 ) AS "Descr."
  , m2.m2pnon AS "Supplier pn"
  , m2.m2stfa AS "Sent?"
  , m2.m2qord AS "Qty. Ordered"
  , CASE
    WHEN ( m2.m2qrec - m2.m2qsto ) <= 0 then 0
    ELSE ( m2.m2qrec - m2.m2qsto )
  END AS "Qty. Received" 
  , m2.m2qsto AS "Qty. Stored" 
  , CASE
    WHEN m1.m1stor = 'LAIC' THEN cd.cdqtd
    ELSE IFNULL ( og2.g2qtin , aa.aaqtp ) 
    END AS "Qty. Invoiced"
  , CASE 
    WHEN m1.m1stor = 'LAIC' THEN cd.cdvin
    ELSE IFNULL ( og2.g2vin , aa.aavshp )
    END AS "Inv. Date"
  , og2.g2xblnr AS "Inv. Nr."
  , m2.m2wreq AS "Week req."
  , m2.m2wpro AS "Week prom."
  , m2.m2wprd AS "Day prom."
  , m2.m2vcre AS "Date created"
  , g1.g1netw * m2.m2qord AS "Order weight"
  , Bos."Nr. Bos"
  , Bos."Qty. Bos"
  , m3.m3vrcv AS "Date received"
  , CASE
    WHEN m1.m1stor = '05' THEN g2.g2ara 
    ELSE ''
  END AS "Prepacking"
  , gm.gmp1tx AS "Comments"

FROM rexndcdta.alpum2 m2
  LEFT JOIN rexndcdta.alpum1 m1 ON m1.m1onop = m2.m2onop
  LEFT JOIN rexndcdta.alpum3 m3 ON m3.m3onop = m2.m2onop AND m3.m3linp = m2.m2linp AND m3.m3xfld <> '1' AND m3.m3xdlt <> '1' AND (m3.m3qrec - m3.m3qsto) <> 0
  LEFT JOIN rexndcdta.alicg1 g1 ON g1.g1pno = m2.m2pno
  LEFT JOIN rexndcdta.alicg2 g2 ON g2.g2pno = m2.m2pno
  LEFT JOIN rexndcdta.alpugm gm ON m2.m2onop = gm.gmonop AND m2.m2linp = gm.gmlinp AND gm.gmtype = '2' AND gm.gmline = '1'
  LEFT JOIN rexndcdta.almog2 og2 ON og2.g2onop = m2.m2onop AND og2.g2linp = m2.m2linp AND og2.g2qtin > 0
  LEFT JOIN rexndcshr.algtaa aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 
  LEFT JOIN rexndcdta.alcocd cd ON cd.cdonoc = m2.m2onoc AND cd.cdlinc = m2.m2linc AND cd.cdcus = '   100155'
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
  LEFT JOIN (
    SELECT 
      wy.wystor
      , wy.wypno
      , COUNT ( wy.wyonoc || wy.wypno || wy.wylinc ) AS "Nr. Bos"
      , SUM ( wy.wyqtd ) AS "Qty. Bos"
    FROM rexndcdta.alcowy wy
    WHERE wy.wybotp = 'BO'
    GROUP BY 
      wy.wystor
      , wy.wypno ) Bos ON Bos.wystor = m1.m1stor AND Bos.wypno = m2.m2pno

WHERE m2.m2qost <> 0 
  AND m1.m1xact = '1'
  AND m1.m1xpst <> '5' 
  AND m2.m2xact = '1' 
  AND m2.m2xpst <> '5' 
  AND m1.m1otp IN ( '20' , '45' , '80' )
  AND m1.m1stor IN ( '05' , 'LAIC' , 'CEE' , 'ADC' , 'DS' , '50' )
  AND vh.vhadr3 IN ( 'SP' , 'SP - OBS' , 'ACC' , 'ACC - OBS' )		
-------------------------------------
UNION ALL
-------------------------------------
SELECT  
  m1.m1stor AS "Wh"
  , g1.g1buy AS "Buyer"
  , m1.m1spno AS "Supp. Nr." 
  , m1.m1podm AS "Mode"
  , m2.m2onop AS "PO nr."
  , m2.m2linp AS "PO line"
  , m2.m2xpst AS "Status"
  , CAST ( m2.m2pno AS INT ) AS "Pn"
  , LEFT ( g2.g2de1 , 20 ) AS "Descr."
  , m2.m2pnon AS "Supplier pn"
  , m2.m2stfa AS "Sent?"
  , m2.m2qord AS "Qty. Ordered"
  , CASE
    WHEN ( m2.m2qrec - m2.m2qsto ) <= 0 then 0
    ELSE ( m2.m2qrec - m2.m2qsto )
    END AS "Qty. Received" 
  , m2.m2qsto AS "Qty. Stored" 
  , IFNULL ( og2.g2qtin , aa.aaqtp ) AS "Qty. Invoiced"
  , IFNULL ( og2.g2vin , aa.aavshp )  AS "Inv. Date"
  , og2.g2xblnr AS "Inv. Nr."
  , m2.m2wreq AS "Week req."
  , m2.m2wpro AS "Week prom."
  , m2.m2wprd AS "Day prom."
  , m2.m2vcre AS "Date created"
  , g1.g1netw * m2.m2qord AS "Order weight"
  , Bos."Nr. Bos"
  , Bos."Qty. Bos"
  , m3.m3vrcv AS "Date received"
  , CASE
    WHEN m1.m1stor = '05' THEN g2.g2ara 
    ELSE ''
    END AS "Prepacking"
  , gm.gmp1tx AS "Comments"

FROM rexhgbdta.alpum2 m2
  LEFT JOIN rexhgbdta.alpum1 m1 ON m1.m1onop = m2.m2onop
  LEFT JOIN rexhgbdta.alpum3 m3 ON m3.m3onop = m2.m2onop AND m3.m3linp = m2.m2linp AND m3.m3xfld <> '1' AND m3.m3xdlt <> '1' AND (m3.m3qrec - m3.m3qsto) <> 0
  LEFT JOIN rexhgbdta.alicg1 g1 ON g1.g1pno = m2.m2pno
  LEFT JOIN rexhgbdta.alicg2 g2 ON g2.g2pno = m2.m2pno
  LEFT JOIN rexhgbdta.alpugm gm ON m2.m2onop = gm.gmonop AND m2.m2linp = gm.gmlinp AND gm.gmtype = '2' AND gm.gmline = '1'
  LEFT JOIN rexhgbdta.almog2 og2 ON og2.g2onop = m2.m2onop AND og2.g2linp = m2.m2linp AND og2.g2qtin > 0
  LEFT JOIN rexhgbshr.algtaa AS aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
  LEFT JOIN (
    SELECT 
      wy.wystor
      , wy.wypno
      , COUNT ( wy.wyonoc || wy.wypno || wy.wylinc ) AS "Nr. Bos"
      , SUM ( wy.wyqtd ) AS "Qty. Bos"
    FROM rexhgbdta.alcowy wy
    WHERE wy.wybotp = 'BO'
    GROUP BY 
      wy.wystor
      , wy.wypno ) Bos ON Bos.wystor = m1.m1stor AND Bos.wypno = m2.m2pno

WHERE m2.m2qost <> 0 
  AND m1.m1xact = '1'
  AND m1.m1xpst <> '5' 
  AND m2.m2xact = '1' 
  AND m2.m2xpst <> '5' 
  AND m1.m1otp IN ( '20' , '45' , '80' )
  AND m1.m1stor IN ( 'DON1' )
  AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )
-------------------------------------
UNION ALL
-------------------------------------
SELECT  
  m1.m1stor AS "Wh"
  , g1.g1buy AS "Buyer"
  , m1.m1spno AS "Supp. Nr." 
  , m1.m1podm AS "Mode"
  , m2.m2onop AS "PO nr."
  , m2.m2linp AS "PO line"
  , m2.m2xpst AS "Status"
  , CAST ( m2.m2pno AS INT ) AS "Pn"
  , LEFT ( g2.g2de1 , 20 ) AS "Descr."
  , m2.m2pnon AS "Supplier pn"
  , m2.m2stfa AS "Sent?"
  , m2.m2qord AS "Qty. Ordered"
  , CASE
    WHEN ( m2.m2qrec - m2.m2qsto ) <= 0 then 0
    ELSE ( m2.m2qrec - m2.m2qsto )
    END AS "Qty. Received" 
  , m2.m2qsto AS "Qty. Stored" 
  , IFNULL ( og2.g2qtin , aa.aaqtp ) AS "Qty. Invoiced"
  , IFNULL ( og2.g2vin , aa.aavshp )  AS "Inv. Date"
  , og2.g2xblnr AS "Inv. Nr."
  , m2.m2wreq AS "Week req."
  , m2.m2wpro AS "Week prom."
  , m2.m2wprd AS "Day prom."
  , m2.m2vcre AS "Date created"
  , g1.g1netw * m2.m2qord AS "Order weight"
  , Bos."Nr. Bos"
  , Bos."Qty. Bos"
  , m3.m3vrcv AS "Date received"
  , CASE
    WHEN m1.m1stor = '05' THEN g2.g2ara 
    ELSE ''
    END AS "Prepacking"
  , gm.gmp1tx AS "Comments"

FROM rexhzadta.alpum2 m2
  LEFT JOIN rexhzadta.alpum1 m1 ON m1.m1onop = m2.m2onop
  LEFT JOIN rexhzadta.alpum3 m3 ON m3.m3onop = m2.m2onop AND m3.m3linp = m2.m2linp AND m3.m3xfld <> '1' AND m3.m3xdlt <> '1' AND (m3.m3qrec - m3.m3qsto) <> 0
  LEFT JOIN rexhzadta.alicg1 g1 ON g1.g1pno = m2.m2pno
  LEFT JOIN rexhzadta.alicg2 g2 ON g2.g2pno = m2.m2pno
  LEFT JOIN rexhzadta.alpugm gm ON m2.m2onop = gm.gmonop AND m2.m2linp = gm.gmlinp AND gm.gmtype = '2' AND gm.gmline = '1'
  LEFT JOIN rexhzadta.almog2 og2 ON og2.g2onop = m2.m2onop AND og2.g2linp = m2.m2linp AND og2.g2qtin > 0
  LEFT JOIN rexhzashr.algtaa AS aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
  LEFT JOIN (
    SELECT 
      wy.wystor
      , wy.wypno
      , COUNT ( wy.wyonoc || wy.wypno || wy.wylinc ) AS "Nr. Bos"
      , SUM ( wy.wyqtd ) AS "Qty. Bos"
    FROM rexhzadta.alcowy wy
    WHERE wy.wybotp = 'BO'
    GROUP BY 
      wy.wystor
      , wy.wypno ) Bos ON Bos.wystor = m1.m1stor AND Bos.wypno = m2.m2pno

WHERE m2.m2qost <> 0 
  AND m1.m1xact = '1'
  AND m1.m1xpst <> '5' 
  AND m2.m2xact = '1' 
  AND m2.m2xpst <> '5' 
  AND m1.m1otp IN ( '20' , '45' , '80' )
  AND m1.m1stor IN ( '139A' )
  AND vh.vhadr3 IN ( 'SP' )
-------------------------------------
