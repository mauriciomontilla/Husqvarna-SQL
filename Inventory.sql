-------------------------------------			
SELECT  			
  gq.gqstor AS "Wh"			
  , CAST ( gq.gqpno AS INT ) AS "Pn"
  , g1.g1buy AS "Buyer"
  , vh.vhadr1 AS "Buyer Name"
  , gm.gmspno AS "Supplier"
  , LEFT ( k1.k1ys01 , 15 ) AS "Supplier Name"
  , gmwh.gmspno AS "Supplier wh"
  , g1.g1atyp AS "Type"
  , g1.g1vcre AS "Date created"
  , gj.gjzcp AS "Stk"		
  , gq.gqqys AS "SOH (Q)"			
  , gq.gqqyp AS "PO (Q)"			
  , gq.gqqyr AS "CO (Q)"
  , gq.gqqsrg AS "GR (Q)"
  , gq.gqqys - gq.gqqyr + gq.gqqyp AS "Av. (Q)"
  , gq.gqqys * gj.gjzcp AS "Stock value"
  , ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) AS "Roll. Dem. Y (Q)"
  , ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) * gj.gjzcp AS "Value Roll. Dem."
  , g1.g1xrpc || g1.g1xrpw AS "Rpl code"	
  , hu.huxrpc || hu.huxrpw AS "Pipeline"	
FROM  rexndcdta.alicgq gq			
   JOIN rexndcdta.alicg1 g1 ON g1.g1pno = gq.gqpno AND g1.g1xact = '1'
   JOIN rexndcdta.alicg2 g2 ON g2.g2pno = g1.g1pno AND g1.g1xact = '1'	
   LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = gq.gqpno AND gj.gjxps = '1' AND gj.gjtype = '1'			
   LEFT JOIN rexndcdta.alicgm gm ON gm.gmpno = gq.gqpno AND gm.gmstor = '****' AND gm.gmspri = 1
   LEFT JOIN rexndcdta.alicgm gmwh ON gmwh.gmpno = gq.gqpno AND gmwh.gmstor = gq.gqstor AND gmwh.gmspri = 1	
   LEFT JOIN rexndcdta.alpuk1 k1 ON k1.k1spno = gm.gmspno
   LEFT JOIN rexndcdta.alichu hu ON hu.hupno = gq.gqpno
   LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
	 LEFT JOIN (
			--Start, this query aims to bring a rolling demand FROM B509
			SELECT
				gq.gqstor AS "Store"
				, gq.gqpno AS "Pn"
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
			
      FROM rexndcdta.alicgq gq		
				LEFT JOIN rexndcdta.alicgt current_year ON current_year.gtpno = gq.gqpno AND current_year.gtstor = gq.gqstor AND current_year.gtyear = YEAR(NOW())
				LEFT JOIN rexndcdta.alicgt previous_year ON previous_year.gtpno = gq.gqpno AND previous_year.gtstor = gq.gqstor AND previous_year.gtyear = (YEAR(NOW()) - 1)
			--End, this query aims to bring a rolling demand FROM B509
	 ) RollDem ON RollDem."Store" = gq.gqstor AND RollDem."Pn" = gq.gqpno				
WHERE  gq.gqstor IN ( '05' , 'LAIC' , 'CEE' , 'ADC' , '11' )			
   AND (gq.gqqys > 0 OR gq.gqqyp > 0 OR gq.gqqyr > 0)
   AND vh.vhadr3 IN ( 'SP' , 'ACC' )		
-------------------------------------			
UNION ALL			
-------------------------------------			
SELECT  			
	gq.gqstor AS "Wh"			
  , CAST ( gq.gqpno AS INT ) AS "Pn"
	, g1.g1buy AS "Buyer"
  , vh.vhadr1 AS "Buyer Name"
	, gm.gmspno AS "Supplier"
  , LEFT ( k1.k1ys01 , 15 ) AS "Supplier Name"
	, gmwh.gmspno AS "Supplier wh"
	, g1.g1atyp AS "Type"
	, g1.g1vcre AS "Date created"
	, gj.gjzcp AS "Stk"		
  , gq.gqqys AS "SOH (Q)"			
  , gq.gqqyp AS "PO (Q)"			
  , gq.gqqyr AS "CO (Q)"
  , gq.gqqsrg AS "GR (Q)"
  , gq.gqqys - gq.gqqyr + gq.gqqyp AS "Av. (Q)"
	, gq.gqqys * gj.gjzcp AS "Stock value"
	, ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) AS "Roll. Dem. Y"
	, ( "Month - 12" + "Month - 11" + "Month - 10" + "Month - 09" + "Month - 08" + "Month - 07" + "Month - 06" + "Month - 05" + "Month - 04" + "Month - 03" + "Month - 02" + "Month - 01" ) * gj.gjzcp AS "Value Roll. Dem."
	, g1.g1xrpc || g1.g1xrpw AS "Rpl code"	
	, hu.huxrpc || hu.huxrpw AS "Pipeline"		
FROM rexhgbdta.alicgq gq			
   JOIN rexhgbdta.alicg1 g1 ON g1.g1pno = gq.gqpno AND g1.g1xact = '1'
   JOIN rexhgbdta.alicg2 g2 ON g2.g2pno = g1.g1pno AND g1.g1xact = '1'
   LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = gq.gqpno AND gj.gjxps = '1' AND gj.gjtype = '1'			
   LEFT JOIN rexhgbdta.alicgm gm ON gm.gmpno = gq.gqpno AND gm.gmstor = '****' AND gm.gmspri = 1
   LEFT JOIN rexhgbdta.alicgm gmwh ON gmwh.gmpno = gq.gqpno AND gmwh.gmstor = gq.gqstor AND gmwh.gmspri = 1
   LEFT JOIN rexndcdta.alpuk1 k1 ON k1.k1spno = gm.gmspno 
   LEFT JOIN rexhgbdta.alichu hu ON hu.hupno = gq.gqpno 			
   LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
	 LEFT JOIN (
			--Start, this query aims to bring a rolling demand FROM B509
			SELECT
				gq.gqstor AS "Store"
				, gq.gqpno AS "Pn"
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
			
			FROM rexhgbdta.alicgq gq		
				LEFT JOIN rexhgbdta.alicgt current_year ON current_year.gtpno = gq.gqpno AND current_year.gtstor = gq.gqstor AND current_year.gtyear = YEAR(NOW())
				LEFT JOIN rexhgbdta.alicgt previous_year ON previous_year.gtpno = gq.gqpno AND previous_year.gtstor = gq.gqstor AND previous_year.gtyear = (YEAR(NOW()) - 1)
			--End, this query aims to bring a rolling demand FROM B509
	 ) RollDem ON RollDem."Store" = gq.gqstor AND RollDem."Pn" = gq.gqpno				
WHERE  gq.gqstor IN ( 'DON1' )			
   AND (gq.gqqys > 0 OR gq.gqqyp > 0 OR gq.gqqyr > 0)
   AND vh.vhadr3 IN ( 'SP' , 'ACC'  )		
-------------------------------------
