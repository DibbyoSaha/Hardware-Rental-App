#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

set wrap off
set linesize 132
set pagesize 500

/*Give a list of users that spend more than the average user*/ 
select renterid, avg(totalprice)
from units_leased 
group by renterid
having  avg(totalprice) > (select avg(totalprice) from units_leased);

/*List unit id of units which are of grade A quality but has  been leased*/
select UnitId
from units u
where u.Grade = 'A'
and exists 
 (select *
 from units_leased ul
    where u.UnitId = ul.unitid);

/*This query displays the country, the name of the product leased, and the total price of all units leased for each product in each country.*/
Select user_location.Country, products.ProductName, SUM(units_leased.totalprice)
from user_location, users, units, products, units_leased
where user_location.LocationID = users.LocationID 
AND users.UserID = units_leased.RenterID 
AND products.ProductId = units.ProductId 
AND units.UnitId = units_leased.UnitId
Group by user_location.Country, products.ProductName;

/*Products offered in USA and not in Canada*/
select productname
from products
minus
(select productname
from products
where productlocation = 'Canada');

/*List the number of products in the USA location*/
select count(productid) as Total
from products p
where p.productlocation = 'USA';

/*List Productid of products in USA and Canada*/
select productid
from products
where productlocation = 'USA'
union
select productid
from products
where productlocation = 'Canada';



exit;
EOF
