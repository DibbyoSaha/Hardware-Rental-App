drop view units_leased_100to103;
drop view productcategoryid_eh;
drop view email_userid_lname;
/*List all units_leased information which are of Id between 100 to 103 and TotalPrice between 20 to 40 from units_leased table*/
create view units_leased_100to103 as
select *
from units_leased
where (Id >= 100 and Id <= 103) and (TotalPrice >= 20 and TotalPrice <= 40);

/*List the ProductCategoryID in descending order for ProductCategoryName "Electrical" and "Hardware" from product_category table*/
create view productcategoryid_eh as
select ProductCategoryID, ProductCategoryName
from product_category
where ProductCategoryName = 'Electrical' or ProductCategoryName = 'Hardware'
order by ProductCategoryID DESC;

/*List email and UserID (in ascending order) for users by specific l_name from users table. For example, list email and UserID of users with l_name "Smith"*/
create view email_userid_lname as
select UserID, email
from users
where l_name = 'Smith'
order by UserID ASC;

select * from units_leased_100to103;
select * from productcategoryid_eh;
select * from email_userid_lname;

/*This query displays a users first and last name and userid, if they have rented a specific item and spent more than $10*/
select users.f_name, users.l_name, renterID 
from units_leased, users
where units_leased.unitid = 'U001'
AND units_leased.totalprice >= 10
AND units_leased.renterid = users.userid
ORDER BY units_leased.renterid ASC;

/* This query displays the country, the name of the product leased, and the total price of all units leased for each product in each country.*/
Select user_location.Country, products.ProductName, SUM(units_leased.totalprice)
from user_location, users, units, products, units_leased
where user_location.LocationID = users.LocationID AND users.UserID = units_leased.RenterID AND products.ProductId = units.ProductId AND units.UnitId = units_leased.UnitId
Group by user_location.Country, products.ProductName;

/*This query tells us who the most popular renters are based on the total price of the items they have rented.*/
select u.f_name, u.l_name, sum(totalprice) as "Total Price", c.city, c.country
from units_leased leased
join users u on u.userid = leased.renterid
join user_location c on c.locationid = u.locationid
join units unit on leased.unitid = unit.unitid
group by u.f_name, u.l_name, c.city, c.country;
