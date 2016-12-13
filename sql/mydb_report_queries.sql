
set serveroutput on
set echo on
set linesize 32767
set trimspool on
set trimout on
set wrap off
spool output.txt

--BOOKS REPORT
--Display Top 3 and Bottom 3 selling books
--Top 3
SELECT  b.bookid,b.name,b.author,p.qty
from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity) desc ) p on p.bookid=b.bookid
where rownum<=3;
--Bottom 3
SELECT  b.bookid,b.name,b.author,p.qty
from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity) ) p on p.bookid=b.bookid
where rownum<=3;

/*O/P
BOOKI NAME                                                                                                 AUTHOR                                                    QTY
----- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- ----------
B001  fundamentals of db                                                                                   ramez,elmasri                                              44
B002  computer networks                                                                                    stephen rogers                                             24
B003  Artificial Intelligence                                                                              James,Peterson                                             21

SQL> --Bottom 3
SQL> SELECT     b.bookid,b.name,b.author,p.qty
  2  from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity) ) p on p.bookid=b.bookid
  3  where rownum<=3;

BOOKI NAME                                                                                                 AUTHOR                                                    QTY
----- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- ----------
B006  Sherlock Holmes                                                                                      Jack                                                        4
B004  Harry Potter-Deathly hollows                                                                         J K Rowling                                                 7
B003  Artificial Intelligence                                                                              James,Peterson                                             21


*/


--F16_T11_customer REPORT
--Display customers with high frequency of F16_T11_purchase in a F16_T11_store

select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST001' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in(
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION 
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST002' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST003' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST004' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST005' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST006' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
UNION
select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit 
from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s
where s.storeid='ST007' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in(
	select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in (
		select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))
order by storeid;

/*
O/P:

CUSTO STOREI FREQUENCY_OF_VISIT
----- ------ ------------------
C001  ST001                   2
C002  ST002                   1
C005  ST002                   1
C008  ST002                   1
C002  ST003                   1
C003  ST003                   1
C006  ST003                   1
C009  ST003                   1
C003  ST004                   1
C004  ST004                   1
C007  ST004                   1

CUSTO STOREI FREQUENCY_OF_VISIT
----- ------ ------------------
C010  ST004                   1
C005  ST005                   2
C002  ST006                   1
C006  ST006                   1
C009  ST006                   1
C007  ST007                   2






*/

--F16_T11_supplier SCRUTINITY REPORT
--Displaying suppliers of each F16_T11_store whose books were returned a maximum amount
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST001' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST001' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST001' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST001'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST002' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST002' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST002' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST002'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST003' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST003' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST003' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST003'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST004' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST004' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST004' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST004'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST005' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST005' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST005' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST005'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST006' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST006' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST006' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST006'
UNION
SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='ST007' group by bookid)
from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='ST007' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST007' group by bookid)) p
where p.bookid=s.bookid and  s.storeid='ST007'
order by storeid;
/*
O/p:
SUPPLI STOREI (SELECTMAX(SUM(QUANTITY))FROMF16_T11_RETURNWHERESTOREID='ST001'GROUPBYBOOKID)
------ ------ -----------------------------------------------------------------------------
S001   ST001                                                                              4
S002   ST002                                                                              4
S003   ST003                                                                              4
S004   ST004                                                                              4
S005   ST005                                                                              4



*/



--RETURNS REPORT
--Displaying F16_T11_store with highest and least F16_T11_return
select storeid,sum(quantity),'Highest' return_status 
	from F16_T11_return 
	group by storeid
	having sum(quantity)>=ALL(
	select sum(quantity)
	from F16_T11_return 
	group by storeid
		) 
union
select storeid,sum(quantity),'Lowest' return_status 
	from F16_T11_return 
	group by storeid
	having sum(quantity)<=ALL(
	select sum(quantity)
	from F16_T11_return 
	group by storeid
		); 
	/*
O/P:
STOREI SUM(QUANTITY) RETURN_
------ ------------- -------
ST001              8 Highest
ST002              4 Lowest
ST004              4 Lowest
ST005              4 Lowest



	*/



--F16_T11_store REPORT
--Displaying number of sales in each F16_T11_store
SELECT s.storeid,s.name,p.total_sales
from F16_T11_store s join (
SELECT storeid ,sum(quantity) total_sales
from F16_T11_purchase_details  
group by storeid) p on s.storeid=p.storeid;

/*
O/P:
STOREI NAME                      TOTAL_SALES
------ ------------------------- -----------
ST005  Ronns F16_T11_store                32
ST001  Cal F16_T11_store                  11
ST006  Ronns F16_T11_store                11
ST002  Ronns F16_T11_store                 8
ST004  Ronns F16_T11_store                12
ST007  Ronns F16_T11_store                17
ST003  Nills F16_T11_store                 9



*/


--F16_T11_supplier REPORT
--Display best F16_T11_supplier based on quantity supplied for each F16_T11_store
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST001' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST002' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST003' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST004' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST005' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST006' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
UNION
select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied 
from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s
where s.storeid='ST007' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in(
	select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in (
		select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))
order by storeid;

/*

O/P:

SUPPLI STOREI QUANTITY_SUPPLIED
------ ------ -----------------
S001   ST001                290
S002   ST002                247
S003   ST003                345
S004   ST004                209
S005   ST005                461
S007   ST007                301



*/

--SALE BY PRODUCT REPORT
--Display quantity of F16_T11_book sold and percentage of sales in each F16_T11_store
select b.bookid,b.name,b.author,p.sum Total,p.sum*100/(select sum(quantity) from F16_T11_purchase_details) average
from F16_T11_book b join(
select bookid,sum(quantity) sum,avg(quantity) avg
from F16_T11_purchase_details
group by bookid) p on b.bookid=p.bookid;


/*
O/P:

BOOKI NAME                                                                                                 AUTHOR                                                  TOTAL    AVERAGE
----- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- ---------- ----------
B001  fundamentals of db                                                                                   ramez,elmasri                                              44         44
B002  computer networks                                                                                    stephen rogers                                             24         24
B003  Artificial Intelligence                                                                              James,Peterson                                             21         21
B004  Harry Potter-Deathly hollows                                                                         J K Rowling                                                 7          7
B006  Sherlock Holmes                                                                                      Jack                                                        4          4


*/
