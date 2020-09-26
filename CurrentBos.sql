----------
Select 
  "Store" ,
  "Pn" ,
  "Buyer" ,
  "Team" ,
  "Name" ,
  "Supplier" ,
  "Soh Avail." ,
  "Nbr. Bos" ,
  "Qty. Bos" ,
  "Value Bos" ,
  "Weight Bos",
  "Age Bos" ,
  "Open Po" ,
  "Qty. Invoiced" ,
  "W. Req" ,
  Case 
    When "W. Prom" = 1000000
    Then 0
    Else "W. Prom"
  End as "W. Prom",
  "Rns Qty."
  
From
(
--
Select 
	wy.wystor as "Store" ,
	cast( wy.wypno as int) as "Pn" ,
	wy.wybuy as "Buyer" ,
	vh.vhadr1 as "Name" ,
	vh.vhadr3 as "Team" ,
	wy.wyspno as "Supplier" ,
	gq.gqqys - gq.gqqpi as "Soh Avail." ,
	count ( distinct concat ( wy.wyonoc , concat ( wy.wylinc , wy.wylind ) ) ) as "Nbr. Bos" ,
	sum( wy.wyqtd ) as "Qty. Bos" ,
	sum( wy.wyzcos ) as "Value Bos" ,
	sum( g1.g1netw * wy.wyqtd ) as "Weight Bos" ,
	max( wy.wywant ) as "Age Bos" ,
	gq.gqqyp as "Open Po" ,
  ifnull ( Pos."Qty. Invoiced" , 0 ) as "Qty. Invoiced" ,
	min ( cast ( wy.wywrq as int ) ) as "W. Bo" ,
	ifnull ( Pos."W. Req" , 0 ) as "W. Req" ,
	ifnull ( Pos."W. Prom" , 0 ) as "W. Prom" ,
	gq.gqqopn as "Rns Qty."
  
From rexndcdta.alcowy wy
	left join rexndcdta.alicgq gq on wy.wypno = gq.gqpno and wy.wystor = gq.gqstor
	left join rexndcdta.alicg1 g1 on wy.wypno = g1.g1pno
	left join rexndcshr.algevh vh on vh.vhbuy = g1.g1buy
	left join (
----------
SELECT
	m1.m1stor as "Wh",
	m2.m2pno as "Pn",
  SUM ( m2.m2qtin ) as "Qty. Invoiced",
	MIN ( m2.m2wreq ) as "W. Req",
	MIN ( case 
	when m2.m2wpro = 0
	then 1000000
	else m2.m2wpro
	end ) as "W. Prom"
  
FROM rexndcdta.alpum2 m2
	LEFT JOIN rexndcdta.alpum1 m1 on m1.m1onop = m2.m2onop and m1.m1xact = '1'

WHERE m2.m2xact = '1' 
	and m1.m1xpst in ( '2' , '4' )
	and m2.m2qost <> '0' 
	and m2.m2otp in ( '45' , '80' )
GROUP BY 
	m1.m1stor,
	m2.m2pno
----------
	) Pos on Pos."Pn" = wy.wypno and Pos."Wh" = wy.wystor
Where wy.wystor in ( '05' , 'CEE' , 'ADC' , '11' )
	and wy.wybotp in ( 'BO' )
	and vh.vhadr3 in ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )		
Group by 
	wy.wypno, 
	wy.wystor, 
	wy.wybuy,
	vh.vhadr1,
	vh.vhadr3,
	wy.wyspno, 
	gq.gqqys - gq.gqqpi, 
	gq.gqqyp,
  Pos."Qty. Invoiced",
	Pos."W. Req",
	Pos."W. Prom",
	gq.gqqopn
--
UNION ALL
--
Select 
	wy.wystor as "Store" ,
	cast( wy.wypno as int) as "Pn" ,
	wy.wybuy as "Buyer" ,
	vh.vhadr1 as "Name" ,
	vh.vhadr3 as "Team" ,
	wy.wyspno as "Supplier" ,
	gq.gqqys - gq.gqqpi as "Soh Avail." ,
	count ( distinct concat ( wy.wyonoc , concat ( wy.wylinc , wy.wylind ) ) ) as "Nbr. Bos" ,
	sum( wy.wyqtd ) as "Qty. Bos" ,
	sum( wy.wyzcos ) as "Value Bos" ,
	sum( g1.g1netw * wy.wyqtd ) as "Weight Bos" ,
	max( wy.wywant ) as "Age Bos" ,
	gq.gqqyp as "Open Po" ,
  ifnull ( Pos."Qty. Invoiced" , 0 ) as "Qty. Invoiced" ,
	min ( cast ( wy.wywrq as int ) ) as "W. Bo" ,
	ifnull ( Pos."W. Req" , 0 ) as "W. Req" ,
	ifnull ( Pos."W. Prom" , 0 ) as "W. Prom" ,
	gq.gqqopn as "Rns Qty."
  
From rexhgbdta.alcowy wy
	left join rexhgbdta.alicgq gq on wy.wypno = gq.gqpno and wy.wystor = gq.gqstor
	left join rexhgbdta.alicg1 g1 on wy.wypno = g1.g1pno
	left join rexndcshr.algevh vh on vh.vhbuy = g1.g1buy
	left join (
----------
SELECT
	m1.m1stor as "Wh",
	m2.m2pno as "Pn",
  SUM ( m2.m2qtin ) as "Qty. Invoiced",
	MIN ( m2.m2wreq ) as "W. Req",
	MIN ( case 
	when m2.m2wpro = 0
	then 1000000
	else m2.m2wpro
	end ) as "W. Prom"

FROM rexhgbdta.alpum2 m2
	LEFT JOIN rexhgbdta.alpum1 m1 on m1.m1onop = m2.m2onop and m1.m1xact = '1'

WHERE m2.m2xact = '1' 
	and m1.m1xpst in ( '2' , '4' )
	and m2.m2qost <> '0' 
	and m2.m2otp in ( '45' , '80' )
GROUP BY 
	m1.m1stor,
	m2.m2pno
----------
	) Pos on Pos."Pn" = wy.wypno and Pos."Wh" = wy.wystor
Where wy.wystor in ( 'DON1' )
	and wy.wybotp in ( 'BO' )
	and vh.vhadr3 in ( 'SP' , 'ACC' , 'SP - OBS' , 'ACC - OBS' , 'SPECIAL' )
Group by 
	wy.wypno, 
	wy.wystor, 
	wy.wybuy,
	vh.vhadr1,
	vh.vhadr3,
	wy.wyspno, 
	gq.gqqys - gq.gqqpi, 
	gq.gqqyp,
  Pos."Qty. Invoiced",
	Pos."W. Req",
	Pos."W. Prom",
	gq.gqqopn
--
UNION ALL
--
Select 
	wy.wystor as "Store" ,
	cast( wy.wypno as int) as "Pn" ,
	wy.wybuy as "Buyer" ,
	vh.vhadr1 as "Name" ,
	vh.vhadr3 as "Team" ,
	wy.wyspno as "Supplier" ,
	gq.gqqys - gq.gqqpi as "Soh Avail." ,
	count ( distinct concat ( wy.wyonoc , concat ( wy.wylinc , wy.wylind ) ) ) as "Nbr. Bos" ,
	sum( wy.wyqtd ) as "Qty. Bos" ,
	sum( wy.wyzcos ) as "Value Bos" ,
	sum( g1.g1netw * wy.wyqtd ) as "Weight Bos" ,
	max( wy.wywant ) as "Age Bos" ,
	gq.gqqyp as "Open Po" ,
  ifnull ( Pos."Qty. Invoiced" , 0 ) as "Qty. Invoiced" ,
	min ( cast ( wy.wywrq as int ) ) as "W. Bo" ,
	ifnull ( Pos."W. Req" , 0 ) as "W. Req" ,
	ifnull ( Pos."W. Prom" , 0 ) as "W. Prom" ,
	gq.gqqopn as "Rns Qty."
  
From rexhzadta.alcowy wy
	left join rexhzadta.alicgq gq on wy.wypno = gq.gqpno and wy.wystor = gq.gqstor
	left join rexndcdta.alicg1 g1 on wy.wypno = g1.g1pno
	left join rexndcshr.algevh vh on vh.vhbuy = wy.wybuy
	left join (
----------
SELECT
	m1.m1stor as "Wh",
	m2.m2pno as "Pn",
  SUM ( m2.m2qtin ) as "Qty. Invoiced",
	MIN ( m2.m2wreq ) as "W. Req",
	MIN ( case 
	when m2.m2wpro = 0
	then 1000000
	else m2.m2wpro
	end ) as "W. Prom"

FROM rexhzadta.alpum2 m2
	LEFT JOIN rexhzadta.alpum1 m1 on m1.m1onop = m2.m2onop and m1.m1xact = '1'

WHERE m2.m2xact = '1' 
	and m1.m1xpst in ( '2' , '4' )
	and m2.m2qost <> '0' 
	and m2.m2otp in ( '45' , '80' )
  
GROUP BY 
	m1.m1stor,
	m2.m2pno
----------
	) Pos on Pos."Pn" = wy.wypno and Pos."Wh" = wy.wystor
Where wy.wystor in ( '139A' )
	and wy.wybotp in ( 'BO' )
	AND vh.vhadr3 in ( 'SE' )

Group by 
	wy.wypno, 
	wy.wystor, 
	wy.wybuy,
	vh.vhadr1,
	vh.vhadr3,
	wy.wyspno, 
	gq.gqqys - gq.gqqpi, 
	gq.gqqyp,
  Pos."Qty. Invoiced",
	Pos."W. Req",
	Pos."W. Prom",
	gq.gqqopn
--
UNION ALL
--
Select 
	wy.wystor as "Store" ,
	cast( wy.wypno as int) as "Pn" ,
	wy.wybuy as "Buyer" ,
	vh.vhadr1 as "Name" ,
	vh.vhadr3 as "Team" ,
	wy.wyspno as "Supplier" ,
	gq.gqqys - gq.gqqpi as "Soh Avail." ,
	count ( distinct concat ( wy.wyonoc , concat ( wy.wylinc , wy.wylind ) ) ) as "Nbr. Bos" ,
	sum( wy.wyqtd ) as "Qty. Bos" ,
	sum( wy.wyzcos ) as "Value Bos" ,
	sum( g1.g1netw * wy.wyqtd ) as "Weight Bos" ,
	max( wy.wywant ) as "Age Bos" ,
	gq.gqqyp as "Open Po" ,
  ifnull ( Pos."Qty. Invoiced" , 0 ) as "Qty. Invoiced" ,
	min ( cast ( wy.wywrq as int ) ) as "W. Bo" ,
	ifnull ( Pos."W. Req" , 0 ) as "W. Req" ,
	ifnull ( Pos."W. Prom" , 0 ) as "W. Prom" ,
	gq.gqqopn as "Rns Qty."
  
From rexkehdta.alcowy wy
	left join rexkehdta.alicgq gq on wy.wypno = gq.gqpno and wy.wystor = gq.gqstor
	left join rexndcdta.alicg1 g1 on wy.wypno = g1.g1pno
	left join rexndcshr.algevh vh on vh.vhbuy = wy.wybuy
	left join (
----------
SELECT
	m1.m1stor as "Wh",
	m2.m2pno as "Pn",
  SUM ( m2.m2qtin ) as "Qty. Invoiced",
	MIN ( m2.m2wreq ) as "W. Req",
	MIN ( case 
	when m2.m2wpro = 0
	then 1000000
	else m2.m2wpro
	end ) as "W. Prom"

FROM rexkehdta.alpum2 m2
	LEFT JOIN rexkehdta.alpum1 m1 on m1.m1onop = m2.m2onop and m1.m1xact = '1'

WHERE m2.m2xact = '1' 
	and m1.m1xpst in ( '2' , '4' )
	and m2.m2qost <> '0' 
	and m2.m2otp in ( '45' , '80' )
  
GROUP BY 
	m1.m1stor,
	m2.m2pno
----------
	) Pos on Pos."Pn" = wy.wypno and Pos."Wh" = wy.wystor
Where wy.wystor in ( 'WAR1' )
	and wy.wybotp in ( 'BO' )
	AND vh.vhadr3 in ( 'SE' )

Group by 
	wy.wypno, 
	wy.wystor, 
	wy.wybuy,
	vh.vhadr1,
	vh.vhadr3,
	wy.wyspno, 
	gq.gqqys - gq.gqqpi, 
	gq.gqqyp,
  Pos."Qty. Invoiced",
	Pos."W. Req",
	Pos."W. Prom",
	gq.gqqopn
--
) Temp

----------
