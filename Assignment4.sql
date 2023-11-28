/*Find all non admin users located in Canada*/
select username, 
f_name, 
l_name, 
phone_num, 
email from users 
where
UserTypeID  = 0 and locationId = 'CAN1'


/*Find products that are in the Home Decor category and less than 15 dollars a day. Ordered by descending price.*/
select * from products 
where productcategoryid = 8 and priceperunit < 15
order by priceperunit desc;

/*Find products that have Dewalt in their product name and have not not been all rented out*/
select * from products 
where productname like '%DEWALT%' and quantityrented < quantitytotal;

/*Find user type with "Customer" UserTypeName*/
select * from user_type
where UserTypeName = 'customer';

/*List user's city by LocationID from user_location. For example, New York gets out for LocationID "US1"*/
select City from user_location
where LocationID = 'US1';

/*List email and UserID (in ascending order) for users by specific l_name from users table. For example, list email and UserID of users with l_name "Smith"*/
select UserID, email
from users
where l_name = 'Smith'
order by UserID ASC;

/*List the ProductCategoryID in descending order for ProductCategoryName "Electrical" and "Hardware" from product_category table*/
select ProductCategoryID, ProductCategoryName
from product_category
where ProductCategoryName = 'Electrical' or ProductCategoryName = 'Hardware'
order by ProductCategoryID DESC;

/*List GradeID for "Excellent" or "Good" GradeName*/
select GradeID
from grade
where GradeName = 'Excellent' or GradeName = 'Good';

/*List all units_leased information which are of Id between 100 to 103 and TotalPrice between 20 to 40 from units_leased table*/
select *
from units_leased
where (Id >= 100 and Id <= 103) and (TotalPrice >= 20 and TotalPrice <= 40);
