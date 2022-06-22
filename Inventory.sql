/*
This query shows the current situation on stock value and rolling demand for the warehouse in Europe, Asia, the UK and South Africa

Author: Mauricio Montilla
*/
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
	, w7.w7ytd  AS "Roll. Dem. Y"
	, w7.w7ytd * gj.gjzcp AS "Value Roll. Dem."
	, g1.g1xrpc || g1.g1xrpw AS "Rpl code"	
	, hu.huxrpc || hu.huxrpw AS "Pipeline"

FROM  rexndcdta.alicgq gq			
  LEFT JOIN rexndcdta.alicg1 g1 ON g1.g1pno = gq.gqpno AND g1.g1xact = '1'
  LEFT JOIN rexndcdta.alicg2 g2 ON g2.g2pno = g1.g1pno AND g1.g1xact = '1'	
  LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = gq.gqpno AND gj.gjxps = '1' AND gj.gjtype = '1'			
  LEFT JOIN rexndcdta.alicgm gm ON gm.gmpno = gq.gqpno AND gm.gmstor = '****' AND gm.gmspri = 1
  LEFT JOIN rexndcdta.alicgm gmwh ON gmwh.gmpno = gq.gqpno AND gmwh.gmstor = gq.gqstor AND gmwh.gmspri = 1	
  LEFT JOIN rexndcdta.alpuk1 k1 ON k1.k1spno = gm.gmspno
  LEFT JOIN rexndcdta.alichu hu ON hu.hupno = gq.gqpno
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy
	LEFT JOIN rexndcdta.alpxw7 w7 ON w7.w7stor = gq.gqstor AND w7.w7pno = gq.gqpno	

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
	, w7.w7ytd  AS "Roll. Dem. Y"
	, w7.w7ytd * gj.gjzcp AS "Value Roll. Dem."
	, g1.g1xrpc || g1.g1xrpw AS "Rpl code"	
	, hu.huxrpc || hu.huxrpw AS "Pipeline"

FROM rexhgbdta.alicgq gq			
  LEFT JOIN rexhgbdta.alicg1 g1 ON g1.g1pno = gq.gqpno AND g1.g1xact = '1'
  LEFT JOIN rexhgbdta.alicg2 g2 ON g2.g2pno = g1.g1pno AND g1.g1xact = '1'
  LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = gq.gqpno AND gj.gjxps = '1' AND gj.gjtype = '1'			
  LEFT JOIN rexhgbdta.alicgm gm ON gm.gmpno = gq.gqpno AND gm.gmstor = '****' AND gm.gmspri = 1
  LEFT JOIN rexhgbdta.alicgm gmwh ON gmwh.gmpno = gq.gqpno AND gmwh.gmstor = gq.gqstor AND gmwh.gmspri = 1
  LEFT JOIN rexhgbdta.alpuk1 k1 ON k1.k1spno = gm.gmspno 
  LEFT JOIN rexhgbdta.alichu hu ON hu.hupno = gq.gqpno
  LEFT JOIN rexhgbdta.alpxw7 w7 ON w7.w7stor = gq.gqstor AND w7.w7pno = gq.gqpno		 			
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy

WHERE  gq.gqstor IN ( 'DON1' )			
  AND (gq.gqqys > 0 OR gq.gqqyp > 0 OR gq.gqqyr > 0)
  AND vh.vhadr3 IN ( 'SP' , 'ACC'  )		
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
	, w7.w7ytd  AS "Roll. Dem. Y"
	, w7.w7ytd * gj.gjzcp AS "Value Roll. Dem."
	, g1.g1xrpc || g1.g1xrpw AS "Rpl code"	
	, hu.huxrpc || hu.huxrpw AS "Pipeline"

FROM rexhzadta.alicgq gq			
  LEFT JOIN rexhzadta.alicg1 g1 ON g1.g1pno = gq.gqpno AND g1.g1xact = '1'
  LEFT JOIN rexhzadta.alicg2 g2 ON g2.g2pno = g1.g1pno AND g1.g1xact = '1'
  LEFT JOIN rexndcdta.alicgj gj ON gj.gjpno = gq.gqpno AND gj.gjxps = '1' AND gj.gjtype = '1'			
  LEFT JOIN rexhzadta.alicgm gm ON gm.gmpno = gq.gqpno AND gm.gmstor = '****' AND gm.gmspri = 1
  LEFT JOIN rexhzadta.alicgm gmwh ON gmwh.gmpno = gq.gqpno AND gmwh.gmstor = gq.gqstor AND gmwh.gmspri = 1
  LEFT JOIN rexhzadta.alpuk1 k1 ON k1.k1spno = gm.gmspno 
  LEFT JOIN rexhzadta.alichu hu ON hu.hupno = gq.gqpno
  LEFT JOIN rexhzadta.alpxw7 w7 ON w7.w7stor = gq.gqstor AND w7.w7pno = gq.gqpno		 			
  LEFT JOIN rexndcshr.algevh vh ON vh.vhbuy = g1.g1buy

WHERE  gq.gqstor IN ( '139A' )			
  AND (gq.gqqys > 0 OR gq.gqqyp > 0 OR gq.gqqyr > 0)
  AND vh.vhadr3 IN ( 'SP' , 'ACC' )		
-------------------------------------
