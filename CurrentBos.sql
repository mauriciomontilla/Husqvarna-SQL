/* 
This query shows the back orders per item for the warehouse in Europe, Asia, the UK and South Africa
It adds additional important information such as Prom. Weeks and Received Not Stored

Author: Mauricio Montilla
*/
SELECT
  "Wh"
  , "Pn"
  , LEFT ( "Desc." , 20 ) AS "Desc."  --Each description has 20 characters
  , "Year Created"
  , "Buyer"
  , "Comm. Ref"
  , "Team" 
  , "Name" 
  , "Supplier" 
  , "Soh Avail." 
  , "Nbr. Bos" 
  , "Qty. Bos" 
  , "Value Bos" 
  , "Weight Bos"
  , "Age Bos" 
  , "Open Po"
  , GREATEST ( "Qty. Invoiced" , "Qty. Shipped" ) AS "Qty. in Transit" 
  , "W. Req" 
  , CASE
    WHEN "W. Prom" = 1000000 THEN 0
    ELSE "W. Prom"
    END AS "W. Prom"
  , "Rns Qty."
  , CASE
    WHEN "Reason + Action B/Os B" IS NULL THEN REPLACE ( UPPER( LEFT ( "Reason + Action B/Os A" , 1 ) ) || LOWER( SUBSTRING( "Reason + Action B/Os A" , 2 , 200 ) ) , '   ' , '' )
    WHEN TRIM ( "Reason + Action B/Os A" ) IS NULL OR TRIM ( "Reason + Action B/Os A" ) = ' ' THEN "Reason + Action B/Os B"
    ELSE "Reason + Action B/Os B" || '. ' || REPLACE( UPPER( LEFT ( "Reason + Action B/Os A" , 1 ) ) || LOWER( SUBSTRING( "Reason + Action B/Os A" , 2 , 200 ) ) , '   ' , '' )
    END AS "Reason + Action B/Os" --Each line has 40 spaces, and we have 5 lines involved

FROM
  (
  --
  SELECT
    wy.wystor AS "Wh" 
    , CAST ( wy.wypno AS INT ) AS "Pn" 
    , g2.g2de1 AS "Desc."
    , SUBSTRING ( g1.g1vcre , 1 , 4 ) AS "Year Created"
    , wy.wybuy AS "Buyer" 
    , CASE
    WHEN g2.g2comr = 'GSPTP' THEN 'Yes'
    ELSE 'No'
    END AS "Comm. Ref"
    , vh.vhadr1 AS "Name" 
    , vh.vhadr3 AS "Team" 
    , wy.wyspno AS "Supplier" 
    , gq.gqqys - gq.gqqpi AS "Soh Avail." 
    , COUNT ( DISTINCT wy.wyonoc || wy.wylinc || wy.wylind ) AS "Nbr. Bos" 
    , SUM ( wy.wyqtd ) AS "Qty. Bos" 
    , SUM ( wy.wyzcos ) AS "Value Bos" 
    , SUM ( g1.g1netw * wy.wyqtd ) AS "Weight Bos" 
    , MAX ( wy.wywant ) AS "Age Bos" 
    , gq.gqqyp AS "Open Po" 
    , IFNULL ( Pos."Qty. Invoiced" , 0 ) AS "Qty. Invoiced"
    , IFNULL ( Pos."Qty. Shipped" , 0 ) AS "Qty. Shipped"
    , IFNULL ( Pos."W. Req" , 0 ) AS "W. Req" 
    , IFNULL ( Pos."W. Prom" , 0 ) AS "W. Prom" 
    , gq.gqqopn AS "Rns Qty."
    , "Reason + Action B/Os A"
    , "Reason + Action B/Os B"

  FROM rexndcdta.alcowy wy
    LEFT JOIN  rexndcdta.alicgq gq ON wy.wypno = gq.gqpno AND wy.wystor = gq.gqstor
    LEFT JOIN  rexndcdta.alicg1 g1 ON wy.wypno = g1.g1pno
    LEFT JOIN  rexndcdta.alicg2 g2 ON wy.wypno = g2.g2pno
    LEFT JOIN  rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
    LEFT JOIN  (
      ----------
      SELECT
        m1.m1stor AS "Wh"
        , m2.m2pno AS "Pn"
        , SUM ( m2.m2qtin ) AS "Qty. Invoiced"
        , SUM ( aa.aaqtp ) AS "Qty. Shipped"
        , MIN ( m2.m2wreq ) AS "W. Req"
        , MIN ( CASE
          WHEN m2.m2wpro = 0 THEN 1000000
          ELSE m2.m2wpro
          END ) AS "W. Prom"
      FROM rexndcdta.alpum2 m2
        LEFT JOIN  rexndcdta.alpum1 m1 ON m1.m1onop = m2.m2onop AND m1.m1xact = '1'
        LEFT JOIN  rexndcshr.algtaa aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 
      WHERE m2.m2xact = '1'
        AND m1.m1xpst IN ( '2' , '4' )
        AND m2.m2qost <> '0'
        AND m2.m2otp IN ( '45' , '80' )
      GROUP BY
        m1.m1stor,
        m2.m2pno
    ----------
    ) Pos ON Pos."Pn" = wy.wypno AND Pos."Wh" = wy.wystor
    LEFT JOIN (
      ----------
      SELECT
        g1.g1pno AS "Pn"
        , TRIM ( IFNULL ( gi_2.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_3.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_4.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_5.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_6.gitext , ' ' ) ) AS "Reason + Action B/Os A"
        , CASE
        WHEN gq.gqqopn > 0 THEN gq.gqqopn || ' pcs in received not stored at torsvik'
        ELSE NULL
        END AS "Reason + Action B/Os B"

      FROM rexndcdta.alicg1 g1
        LEFT JOIN rexndcdta.alicgq gq ON gq.gqpno = g1.g1pno AND gq.gqstor = '05'
        LEFT JOIN rexndcdta.alicgi gi_2 ON gi_2.gipno = g1.g1pno AND gi_2.gixtyp = 'T' AND gi_2.giline = 2
        LEFT JOIN rexndcdta.alicgi gi_3 ON gi_3.gipno = g1.g1pno AND gi_3.gixtyp = 'T' AND gi_3.giline = 3
        LEFT JOIN rexndcdta.alicgi gi_4 ON gi_4.gipno = g1.g1pno AND gi_4.gixtyp = 'T' AND gi_4.giline = 4
        LEFT JOIN rexndcdta.alicgi gi_5 ON gi_5.gipno = g1.g1pno AND gi_5.gixtyp = 'T' AND gi_5.giline = 5
        LEFT JOIN rexndcdta.alicgi gi_6 ON gi_6.gipno = g1.g1pno AND gi_6.gixtyp = 'T' AND gi_6.giline = 6
      ----------
    ) Comments ON Comments."Pn" = wy.wypno

  WHERE wy.wystor IN ( '05' , 'CEE' , 'ADC' , '11' )
    AND wy.wybotp IN ( 'BO' )
    AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )

  GROUP BY
    wy.wystor
    , wy.wypno
    , g2.g2de1
    , SUBSTRING ( g1.g1vcre , 1 , 4 )
    , wy.wybuy
    , g2.g2comr
    , vh.vhadr1
    , vh.vhadr3
    , wy.wyspno
    , gq.gqqys - gq.gqqpi
    , gq.gqqyp
    , Pos."Qty. Invoiced"
    , Pos."Qty. Shipped"
    , Pos."W. Req"
    , Pos."W. Prom"
    , gq.gqqopn
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"
  --
	UNION ALL
	--
	SELECT
    bo.bostor AS "Wh" 
    , CAST ( bo.bopno AS INT ) AS "Pn" 
    , g2.g2de1 AS "Desc."
    , SUBSTRING ( g1.g1vcre , 1 , 4 ) AS "Year Created"
    , bo.bobuy AS "Buyer" 
    , CASE
      WHEN g2.g2comr = 'GSPTP' THEN 'Yes'
      ELSE 'No'
      END AS "Comm. Ref"
    , vh.vhadr1 AS "Name" 
    , vh.vhadr3 AS "Team" 
    , bo.bospno AS "Supplier" 
    , gq.gqqys - gq.gqqpi AS "Soh Avail." 
    , bo.bonobl AS "Nbr. Bos" 
    , bo.boqto AS "Qty. Bos" 
    , bo.bozcos * 10.0 AS "Value Bos" 
    , g1.g1netw * bo.boqto AS "Weight Bos" 
    , bo.bowant AS "Age Bos" 
    , gq.gqqyp AS "Open Po" 
    , IFNULL ( InTransit."Inv. Qty" , 0 ) AS "Qty. Invoiced"
    , IFNULL ( InTransit."Inv. Qty" , 0 ) AS "Qty. Shipped"
    , IFNULL ( Pos."W. Req" , 0 ) AS "W. Req" 
    , IFNULL ( Pos."W. Prom" , 0 ) AS "W. Prom" 
    , gq.gqqopn AS "Rns Qty."
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"

	FROM rexndcloc.alcxbo bo
    LEFT JOIN rexndcdta.alicgq gq ON bo.bopno = gq.gqpno AND bo.bostor = gq.gqstor
    LEFT JOIN rexndcdta.alicg1 g1 ON bo.bopno = g1.g1pno
    LEFT JOIN rexndcdta.alicg2 g2 ON bo.bopno = g2.g2pno
    LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
    LEFT JOIN (
      ----------
      SELECT
        cd.cdpno AS "Pn"
        , SUM ( cd.cdqtd ) AS "Inv. Qty"
        , MIN ( cd.cdvin ) AS "Inv. Date"

      FROM rexndcdta.alcocd cd 
        LEFT JOIN rexndcdta.alcoc1 c1 ON c1.c1onoc = cd.cdonoc
        LEFT JOIN rexndcdta.alpum1 m1 ON substring ( m1.m1onop , 1 , 10 ) = substring ( c1.c1cr1 , 1 , 10)
        LEFT JOIN rexndcdta.alpum2 m2 ON m2.m2onop = m1.m1onop AND m2.m2linp = cd.cdlinc 

      WHERE cd.cdcus = '   100155'
        AND cd.cdxstd = '9'
        AND m1.m1xact = '1'
        AND m1.m1xpst <> '5'
        AND m2.m2xact = '1'
        AND m2.m2xpst <> '5'
      
      GROUP BY 
        cd.cdpno
      ----------
    ) InTransit ON InTransit."Pn" = bo.bopno 
    LEFT JOIN  (
      ----------
      SELECT
        m1.m1stor AS "Wh"
        , m2.m2pno AS "Pn"
        , MIN ( m2.m2wreq ) AS "W. Req"
        , MIN ( CASE
            WHEN m2.m2wpro = 0 THEN 1000000
            ELSE m2.m2wpro
        END ) AS "W. Prom"

      FROM rexndcdta.alpum2 m2
        LEFT JOIN rexndcdta.alpum1 m1 ON m1.m1onop = m2.m2onop AND m1.m1xact = '1'

      WHERE m2.m2xact = '1'
        AND m1.m1xpst IN ( '2' , '4' )
        AND m2.m2qost <> '0'
        AND m2.m2otp IN ( '45' , '80' )

      GROUP BY
        m1.m1stor,
        m2.m2pno
      ----------
    ) Pos ON Pos."Pn" = bo.bopno AND Pos."Wh" = bo.bostor
		LEFT JOIN (
		  ----------
      SELECT
        g1.g1pno AS "Pn"
        , TRIM ( IFNULL ( gi_2.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_3.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_4.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_5.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_6.gitext , ' ' ) ) AS "Reason + Action B/Os A"
        , CASE
        WHEN gq.gqqopn > 0 THEN gq.gqqopn || ' pcs in received not stored at torsvik'
        ELSE NULL
        END AS "Reason + Action B/Os B"

      FROM rexndcdta.alicg1 g1
        LEFT JOIN rexndcdta.alicgq gq ON gq.gqpno = g1.g1pno AND gq.gqstor = '05'
        LEFT JOIN rexndcdta.alicgi gi_2 ON gi_2.gipno = g1.g1pno AND gi_2.gixtyp = 'T' AND gi_2.giline = 2
        LEFT JOIN rexndcdta.alicgi gi_3 ON gi_3.gipno = g1.g1pno AND gi_3.gixtyp = 'T' AND gi_3.giline = 3
        LEFT JOIN rexndcdta.alicgi gi_4 ON gi_4.gipno = g1.g1pno AND gi_4.gixtyp = 'T' AND gi_4.giline = 4
        LEFT JOIN rexndcdta.alicgi gi_5 ON gi_5.gipno = g1.g1pno AND gi_5.gixtyp = 'T' AND gi_5.giline = 5
        LEFT JOIN rexndcdta.alicgi gi_6 ON gi_6.gipno = g1.g1pno AND gi_6.gixtyp = 'T' AND gi_6.giline = 6
		  ----------
		) Comments ON Comments."Pn" = bo.bopno

    WHERE bo.bostor IN ( 'LAIC' )
      AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )
      AND bo.bovcre IN (
      SELECT
        MAX ( bovcre )
      FROM
        rexndcloc.alcxbo
    )
	--
	UNION ALL
	--
	SELECT
    wy.wystor AS "Wh"
    , CAST( wy.wypno AS INT) AS "Pn"
    , g2.g2de1 AS "Desc."
    , SUBSTRING ( g1.g1vcre , 1 , 4 ) AS "Year Created"
    , wy.wybuy AS "Buyer"
    , CASE
      WHEN g2.g2comr = 'GSPTP' THEN 'Yes'
      ELSE 'No'
      END AS "Comm. Ref"
    , CASE 
      WHEN wy.wybuy = 'SESPA' THEN 'TINA TAJIK'
      ELSE vh.vhadr1
      END AS "Name" 
    , vh.vhadr3 AS "Team" 
    , wy.wyspno AS "Supplier" 
    , gq.gqqys - gq.gqqpi AS "Soh Avail." 
    , COUNT ( DISTINCT wy.wyonoc || wy.wylinc || wy.wylind ) AS "Nbr. Bos" 
    , SUM ( wy.wyqtd ) AS "Qty. Bos" 
    , SUM ( wy.wyzcos ) AS "Value Bos" 
    , SUM ( g1.g1netw * wy.wyqtd ) AS "Weight Bos" 
    , MAX ( wy.wywant ) AS "Age Bos" 
    , gq.gqqyp AS "Open Po" 
    , IFNULL ( Pos."Qty. Invoiced" , 0 ) AS "Qty. Invoiced"
    , IFNULL ( Pos."Qty. Shipped" , 0 ) AS "Qty. Shipped"
    , IFNULL ( Pos."W. Req" , 0 ) AS "W. Req"
    , IFNULL ( Pos."W. Prom" , 0 ) AS "W. Prom"
    , gq.gqqopn AS "Rns Qty."
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"

  FROM rexhgbdta.alcowy wy
    LEFT JOIN  rexhgbdta.alicgq gq ON wy.wypno = gq.gqpno AND wy.wystor = gq.gqstor
    LEFT JOIN  rexhgbdta.alicg1 g1 ON wy.wypno = g1.g1pno
    LEFT JOIN  rexndcdta.alicg1 g105 ON wy.wypno = g105.g1pno
    LEFT JOIN  rexndcdta.alicg2 g2 ON wy.wypno = g2.g2pno
    LEFT JOIN  rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
    LEFT JOIN  (
      ----------
      SELECT
        m1.m1stor AS "Wh"
        , m2.m2pno AS "Pn"
        , SUM ( m2.m2qtin ) AS "Qty. Invoiced"
        , SUM ( aa.aaqtp ) AS "Qty. Shipped"
        , MIN ( m2.m2wreq ) AS "W. Req"
        , MIN ( CASE
            WHEN m2.m2wpro = 0 THEN 1000000
            ELSE m2.m2wpro
        END ) AS "W. Prom"

      FROM rexhgbdta.alpum2 m2
        LEFT JOIN  rexhgbdta.alpum1 m1 ON m1.m1onop = m2.m2onop AND m1.m1xact = '1'
        LEFT JOIN  rexhgbshr.algtaa aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 

      WHERE m2.m2xact = '1'
        AND m1.m1xpst IN ( '2' , '4' )
        AND m2.m2qost <> '0'
        AND m2.m2otp IN ( '45' , '80' )

      GROUP BY
        m1.m1stor,
        m2.m2pno
      ----------
		) Pos ON Pos."Pn" = wy.wypno AND Pos."Wh" = wy.wystor
		LEFT JOIN (
      ----------
      SELECT
          g1.g1pno AS "Pn"
          , TRIM ( IFNULL ( gi_2.gitext , ' ' ) ) || ' ' || 
          TRIM ( IFNULL ( gi_3.gitext , ' ' ) ) || ' ' ||
          TRIM ( IFNULL ( gi_4.gitext , ' ' ) ) || ' ' ||
          TRIM ( IFNULL ( gi_5.gitext , ' ' ) ) || ' ' || 
          TRIM ( IFNULL ( gi_6.gitext , ' ' ) ) AS "Reason + Action B/Os A"
          , CASE
          WHEN gq.gqqopn > 0 THEN gq.gqqopn || ' pcs in received not stored at torsvik'
          ELSE NULL
          END AS "Reason + Action B/Os B"

      FROM rexndcdta.alicg1 g1
          LEFT JOIN rexndcdta.alicgq gq ON gq.gqpno = g1.g1pno AND gq.gqstor = '05'
          LEFT JOIN rexndcdta.alicgi gi_2 ON gi_2.gipno = g1.g1pno AND gi_2.gixtyp = 'T' AND gi_2.giline = 2
          LEFT JOIN rexndcdta.alicgi gi_3 ON gi_3.gipno = g1.g1pno AND gi_3.gixtyp = 'T' AND gi_3.giline = 3
          LEFT JOIN rexndcdta.alicgi gi_4 ON gi_4.gipno = g1.g1pno AND gi_4.gixtyp = 'T' AND gi_4.giline = 4
          LEFT JOIN rexndcdta.alicgi gi_5 ON gi_5.gipno = g1.g1pno AND gi_5.gixtyp = 'T' AND gi_5.giline = 5
          LEFT JOIN rexndcdta.alicgi gi_6 ON gi_6.gipno = g1.g1pno AND gi_6.gixtyp = 'T' AND gi_6.giline = 6
      ----------
    ) Comments ON Comments."Pn" = wy.wypno

  WHERE wy.wystor IN ( 'DON1' )
    AND wy.wybotp IN ( 'BO' )
    AND vh.vhadr3 IN ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )

  GROUP BY
    wy.wystor
    , wy.wypno
    , g2.g2de1
    , SUBSTRING ( g1.g1vcre , 1 , 4 )
    , wy.wybuy
    , g2.g2comr
    , vh.vhadr1
    , vh.vhadr3
    , wy.wyspno
    , gq.gqqys - gq.gqqpi
    , gq.gqqyp
    , Pos."Qty. Invoiced"
    , Pos."Qty. Shipped"
    , Pos."W. Req"
    , Pos."W. Prom"
    , gq.gqqopn
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"
	--
	UNION ALL
  --
  SELECT
    wy.wystor AS "Wh"
    , CAST ( wy.wypno AS INT) AS "Pn" 
    , g2.g2de1 AS "Desc."
    , SUBSTRING ( g1.g1vcre , 1 , 4 ) AS "Year Created"
    , wy.wybuy AS "Buyer" 
    , CASE
      WHEN g2.g2comr = 'GSPTP' THEN 'Yes'
      ELSE 'No'
      END AS "Comm. Ref"
    , CASE 
      WHEN wy.wybuy = 'SESPA' THEN 'MAURICIO MONTILLA'
      ELSE vh.vhadr1
      END AS "Name" 
    , vh.vhadr3 AS "Team" 
    , wy.wyspno AS "Supplier" 
    , gq.gqqys - gq.gqqpi AS "Soh Avail." 
    , COUNT ( DISTINCT wy.wyonoc || wy.wylinc || wy.wylind ) AS "Nbr. Bos" 
    , SUM ( wy.wyqtd ) AS "Qty. Bos" 
    , SUM ( wy.wyzcos ) AS "Value Bos" 
    , SUM ( g1.g1netw * wy.wyqtd ) AS "Weight Bos" 
    , MAX ( wy.wywant ) AS "Age Bos" 
    , gq.gqqyp AS "Open Po" 
    , IFNULL ( Pos."Qty. Invoiced" , 0 ) AS "Qty. Invoiced"
    , IFNULL ( Pos."Qty. Shipped" , 0 ) AS "Qty. Shipped"
    , IFNULL ( Pos."W. Req" , 0 ) AS "W. Req" 
    , IFNULL ( Pos."W. Prom" , 0 ) AS "W. Prom" 
    , gq.gqqopn AS "Rns Qty."
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"

  FROM rexhzadta.alcowy wy
    LEFT JOIN  rexhzadta.alicgq gq ON wy.wypno = gq.gqpno AND wy.wystor = gq.gqstor
    LEFT JOIN  rexndcdta.alicg1 g1 ON wy.wypno = g1.g1pno
    LEFT JOIN  rexndcdta.alicg2 g2 ON wy.wypno = g2.g2pno
    LEFT JOIN  rexndcshr.algevh vh ON vh.vhbuy = wy.wybuy
    LEFT JOIN  (
      ----------
      SELECT
        m1.m1stor AS "Wh"
        , m2.m2pno AS "Pn"
        , SUM ( m2.m2qtin ) AS "Qty. Invoiced"
        , SUM ( aa.aaqtp ) AS "Qty. Shipped"
        , MIN ( m2.m2wreq ) AS "W. Req"
        , MIN ( CASE
            WHEN m2.m2wpro = 0 THEN 1000000
            ELSE m2.m2wpro
        END ) AS "W. Prom"

      FROM rexhzadta.alpum2 m2
        LEFT JOIN  rexhzadta.alpum1 m1 ON m1.m1onop = m2.m2onop AND m1.m1xact = '1'
        LEFT JOIN  rexhzashr.algtaa aa ON aa.aaonop = m2.m2onop AND aa.aalinp = m2.m2linp 

      WHERE m2.m2xact = '1'
        AND m1.m1xpst IN ( '2' , '4' )
        AND m2.m2qost <> '0'
        AND m2.m2otp IN ( '45' , '80' )

      GROUP BY
        m1.m1stor,
        m2.m2pno
      ----------
    ) Pos ON Pos."Pn" = wy.wypno AND Pos."Wh" = wy.wystor
    LEFT JOIN (
      ----------
      SELECT
        g1.g1pno AS "Pn"
        , TRIM ( IFNULL ( gi_2.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_3.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_4.gitext , ' ' ) ) || ' ' ||
        TRIM ( IFNULL ( gi_5.gitext , ' ' ) ) || ' ' || 
        TRIM ( IFNULL ( gi_6.gitext , ' ' ) ) AS "Reason + Action B/Os A"
        , CASE
          WHEN gq.gqqopn > 0 THEN gq.gqqopn || ' pcs in received not stored at torsvik'
          ELSE NULL
          END AS "Reason + Action B/Os B"

      FROM rexndcdta.alicg1 g1
        LEFT JOIN rexndcdta.alicgq gq ON gq.gqpno = g1.g1pno AND gq.gqstor = '05'
        LEFT JOIN rexndcdta.alicgi gi_2 ON gi_2.gipno = g1.g1pno AND gi_2.gixtyp = 'T' AND gi_2.giline = 2
        LEFT JOIN rexndcdta.alicgi gi_3 ON gi_3.gipno = g1.g1pno AND gi_3.gixtyp = 'T' AND gi_3.giline = 3
        LEFT JOIN rexndcdta.alicgi gi_4 ON gi_4.gipno = g1.g1pno AND gi_4.gixtyp = 'T' AND gi_4.giline = 4
        LEFT JOIN rexndcdta.alicgi gi_5 ON gi_5.gipno = g1.g1pno AND gi_5.gixtyp = 'T' AND gi_5.giline = 5
        LEFT JOIN rexndcdta.alicgi gi_6 ON gi_6.gipno = g1.g1pno AND gi_6.gixtyp = 'T' AND gi_6.giline = 6
      ----------
    ) Comments ON Comments."Pn" = wy.wypno
    
  WHERE wy.wystor IN ( '139A' )
    AND wy.wybotp IN ( 'BO' )
    AND vh.vhadr3 IN ( 'SP' )

  GROUP BY
    wy.wystor
    , wy.wypno
    , g2.g2de1
    , SUBSTRING ( g1.g1vcre , 1 , 4 )
    , wy.wybuy
    , g2.g2comr
    , vh.vhadr1
    , vh.vhadr3
    , wy.wyspno
    , gq.gqqys - gq.gqqpi
    , gq.gqqyp
    , Pos."Qty. Invoiced"
    , Pos."Qty. Shipped"
    , Pos."W. Req"
    , Pos."W. Prom"
    , gq.gqqopn
    , Comments."Reason + Action B/Os A"
    , Comments."Reason + Action B/Os B"
		--
) BackOrders
----------
