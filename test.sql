drop table units_leased;
drop table units;
drop table products; 
drop table users;
drop table grade;
drop table product_category;
drop table user_location;
drop table user_type;
drop table warehouse;
drop view units_leased_100to103;
drop view productcategoryid_eh;
drop view email_userid_lname;

create table user_type (
    UserTypeID number(1) primary key,
    UserTypeName varchar2(10) check (UserTypeName in ('customer', 'admin')),
    constraint chk_user_types check 
    (UserTypeID = case UserTypeName when 'customer' then 0 when 'admin' then 1 end));

create table user_location (
    LocationID varchar2(4) primary key,
    Country varchar2(40),
    City varchar2(40));
    
create table users(
	UserID number(6) primary key,
	UserTypeID number(1) NOT NULL,
    		CONSTRAINT fk_user_type_id FOREIGN KEY (UserTypeID)
    		REFERENCES user_type (UserTypeID),
   	LocationId varchar2(4) NOT NULL,
    		CONSTRAINT fk_location_id FOREIGN KEY (LocationID)
    		REFERENCES user_location (LocationID),
	username varchar2(15) NOT NULL UNIQUE ,
	password varchar2(8) DEFAULT  123456,
	phone_num number(20) ,
	email varchar2(40) NOT NULL,
	f_name varchar2(40) NOT NULL ,
	l_name varchar2(40) NOT NULL) ;
    
    
create table product_category( 
    ProductCategoryID number(1) primary key,
    ProductCategoryName varchar2(40) NOT NULL);

create table grade(
	GradeID varchar2(2) primary key,
	GradeName varchar2(20) NOT NULL); 

/*
Added in foreign keys for PRODUCTS TABLE:
ProductCategoryID
*/
create table products(
	ProductId varchar2(4) primary key,
	ProductName varchar2(100) NOT NULL,
	ProductLocation varchar2(15),
	ProductCategoryID number(1) NOT NULL,
        	CONSTRAINT fk_product_category_id FOREIGN KEY (ProductCategoryID)
        	REFERENCES product_category (ProductCategoryID),
	QuantityRented number(3) default 0,
	QuantityTotal number(3),
	PricePerUnit number(3));


create table warehouse(
    WarehouseID varchar2(4) primary key,
    WarehouseLocation varchar2(40));
    
/*
Added in foreign keys for UNITS TABLE:
ProductId
WarehouseId as OwnerID
*/
create table units(
    UnitId varchar2(4) primary key,
    ProductId varchar2(4) NOT NULL,
    		CONSTRAINT fk_product_id FOREIGN KEY (ProductId)
    		REFERENCES products (ProductId),
    OwnerID varchar2(4) NOT NULL,
    		CONSTRAINT fk_owner_id FOREIGN KEY (OwnerID)
    		REFERENCES warehouse (WarehouseId),
	Grade varchar2(2) default 'A',
	LastRented date,
	Price number(3) default 0,
	Availability varchar2(12) default 'Available' );
    

    
/*
Added in foreign keys for UNITS_LEASED TABLE:
UserID as RenterID
*/
create table units_leased(
	Id number(3) primary key,
	RenterID number(6) NOT NULL,
    		CONSTRAINT fk_user_id FOREIGN KEY (RenterID)
    		REFERENCES users (UserID),
	RentFrom date,
	RentTo date,
	PricePerUnit number(3) NOT NULL,
	UnitId varchar2(4) NOT NULL,
    		CONSTRAINT fk_unit_id FOREIGN KEY (UnitId)
    		REFERENCES units (UnitId),
	TotalPrice number(3) NOT NULL);

INSERT INTO user_type (UserTypeID, UserTypeName)
VALUES (0, 'customer');
INSERT INTO user_type (UserTypeID, UserTypeName)
VALUES (1, 'admin');

INSERT INTO user_location (LocationID, Country, City)
VALUES ('US1', 'USA', 'New York');
INSERT INTO user_location (LocationID, Country, City)
VALUES ('CAN1', 'Canada', 'Toronto');


INSERT INTO users (UserID, UserTypeID, LocationId, username, password, phone_num, email, f_name, l_name)
VALUES ('001', '0', 'US1', 'user1', '123456', '1234567890', 'user1@gmail.com', 'James', 'Smith');
INSERT INTO users (UserID, UserTypeID, LocationId, username, password, phone_num, email, f_name, l_name)
VALUES ('002', '0', 'US1', 'user2', '123456', '1234567891', 'user2@gmail.com', 'John', 'Doe');
INSERT INTO users (UserID, UserTypeID, LocationId, username, password, phone_num, email, f_name, l_name)
VALUES ('003', '0', 'CAN1', 'user3', '123456', '1234567892', 'user3@gmail.com', 'Jane', 'Doe');
INSERT INTO users (UserID, UserTypeID, LocationId, username, password, phone_num, email, f_name, l_name)
VALUES ('004', '0', 'CAN1', 'user4', '123456', '1234567893', 'user4@gmail.com', 'Jane', 'Doe');
INSERT INTO users (UserID, UserTypeID, LocationId, username, password, phone_num, email, f_name, l_name)
VALUES ('005', '1', 'CAN1', 'admin1', '123456', '1234567894', 'admin1@gmail.com', 'Jennifer', 'Smith');


INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (1, 'Building Supplies');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (2, 'Cleaning Supplies');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (3, 'Electrical');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (4, 'Flooring');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (5, 'Gardening');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (6, 'Hardware');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (7, 'Heating and Cooling');
INSERT INTO product_category (ProductCategoryID, ProductCategoryName)
VALUES (8, 'Home Decor');

insert into grade values ('A', 'Excellent');
insert into grade values ('B', 'Good');
insert into grade values ('C', 'Average');
insert into grade values ('D', 'Poor');
insert into grade values ('F', 'Bad');

Insert into products values('0001', 'DEWALT 25 Piece Mechanics Tool Set', 'USA', '6', '0', '25', '65.99');
Insert into products values('0002', 'Tarkett 12 ft. Vinyl Flooring', 'USA', '4', '0', '12', '99');
Insert into products values('0003', 'Sentinel Gutter Guard', 'USA', '5', '0', '100', '1.19');
Insert into products values('0004', 'Milwaukee 6.5 Amp 1/2 in. Drill Driver', 'USA', '1', '0', '5', '49.99');
Insert into products values('0005', 'Energizer 2032 3 Volt Lithium Batteries', 'USA', '3', '0', '20', '7.97');
Insert into products values('0006', 'Royal Sovereign 10,000 BTU Air Conditioner', 'USA', '7', '0', '5', '82.49');
Insert into products values('0007', 'DEWALT 20 Volt MAX Lithium-Ion Battery Pack', 'USA', '2', '0', '30', '99.99');
Insert into products values('0008', 'PUR 18 Cup Dispenser with Maxion Filter', 'Canada', '8', '0', '5', '39.99');
Insert into products values('0009', 'DEWALT 20 Volt MAX Lithium-Ion Charger', 'USA', '6', '0', '4', '59.99');
Insert into products values('0010', 'DEWALT 12 in. 80 Tooth Carbide-Tipped Miter Saw Blade', 'USA', '1', '0', '15', '39.99');
Insert into products values('0011', 'Arduino Nano', 'USA', '3', '0', '10', '27.99');
Insert into products values('0012', 'DEWALT 10 Amp Reciprocating Saw', 'USA', '1', '0', '3', '79.00');
Insert into products values('0013', 'DEWALT 3/8 in. Crown Stapler', 'USA', '1', '0', '4', '99.99');
Insert into products values('0014', 'DEWALT 1/4 in. Crown Stapler', 'USA', '1', '0', '2', '129.00');
Insert into products values('0015', 'DEWALT 20 Volt MAX XR Lithium-Ion Brushless Compact Router', 'USA', '6', '0', '5', '149.00');
Insert into products values('0016', 'DEWALT 20 Volt MAX XR Lithium-Ion Cordless Reciprocating Saw', 'USA', '1', '0', '2', '179.00');
Insert into products values('0017', 'DEWALT 20 Volt Lithium-Ion Compact Drill/Driver', 'USA', '6', '0', '7', '99.99');
Insert into products values('0018', 'DEWALT 20 Volt MAX XR Lithium-Ion Brushless Compact Drill/Driver', 'USA', '6', '0', '5', '199.00');
Insert into products values('0019', 'DEWALT 12 in. Double-Bevel Compound Miter Saw', 'USA', '1', '0', '4', '399.00');
Insert into products values('0020', 'DEWALT 10 in. Jobsite Table Saw 32-1/2 in. Rip Capacity', 'USA', '1', '0', '2', '649.00');
Insert into products values('0021', 'DEWALT 5/8 in. x 50 ft. Premium Poly Duct', 'USA', '1', '0', '8', '21.99');
Insert into products values('0022', 'DEWALT Variable Speed Oscillating Multi-Tool', 'USA', '1', '0', '5', '99.99');
Insert into products values('0023', 'DEWALT MAX Lithium-Ion Grease Gun', 'USA', '2', '0', '4', '129.00');
Insert into products values('0024', 'DEWALT MAX XR Lithium-Ion Brushless Cordless Impact Driver', 'USA', '2', '0', '6', '179.00');
Insert into products values('0025', 'DEWALT MAX XR Lithium-Ion Cordless Reciprocating Saw', 'USA', '1', '0', '3', '229.00');
Insert into products values('0026', 'DEWALT Brushless Cordless Cut-Off Tool/Angle Grinder', 'USA', '1', '0', '4', '119.00');
Insert into products values('0027', 'DEWALT 20 Volt Lithium-Ion XR Brushless Compact Router', 'USA', '6', '0', '2', '219.00');
Insert into products values('0028', 'DEWALT 12 Amp Corded Reciprocating Saw with Variable Speed Trigger', 'USA', '1', '0', '8', '119.99');
Insert into products values('0029', 'DEWALT 10 Amp Reciprocating Saw with Variable Speed Trigger', 'USA', '1', '0', '5', '139.99');
Insert into products values('0030', 'DEWALT 20 Volt MAX XR Lithium-Ion Brushless Compact Reciprocating Saw', 'USA', '6', '0', '4', '229.00');
Insert into products values('0031', 'DEWALT 20 Volt MAX XR Lithium-Ion Brushless Compact Hammer Drill', 'USA', '6', '0', '3', '199.00');
Insert into products values('0032', 'DEWALT SDS-Plus Rotary Hammer Kit', 'USA', '1', '0', '2', '229.00');
Insert into products values('0033', 'DEWALT MAX Brushless High Torque 1/2 in. Impact Wrench with Pin Detent', 'USA', '2', '0', '6', '499.00');
Insert into products values('0034', 'DEWALT 1.1 HP Continuous 5 Gal. Electric Pancake Air Compressor', 'USA', '2', '0', '4', '229.00');
Insert into products values('0035', 'DEWALT MAX XR Lithium-Ion Cordless 6-1/2 in. Circular Saw', 'USA', '1', '0', '3', '229.00');
Insert into products values('0036', 'DEWALT 8 Amp Corded 1-1/4 HP Plunge and Fixed Base Variable Speed Router', 'USA', '6', '0', '4', '219.00');
Insert into products values('0037', 'D WordPress 5 ft. x 8 ft. Area Rug', 'USA', '8', '0', '10', '39.99');
Insert into products values('0038', 'D 2 in. Faux Wood Blind - 35 in. W x 64 in. L Actual Size: 34.5 in. W x 64 in. L', 'USA', '8', '0', '8', '34.99');
Insert into products values('0039', 'D 5-Light Brushed Nickel Chandelier with White Glass Shades', 'USA', '8', '0', '3', '99.99');
Insert into products values('0040', 'D 9 in. Round Ceramic Planter', 'USA', '8', '0', '6', '8.99');
Insert into products values('0041', 'D Decorative Pillow', 'USA', '8', '0', '15', '19.99');
Insert into products values('0042', 'D LED Desk Lamp', 'USA', '8', '0', '5', '19.99');
Insert into products values('0043', 'D Scott Rapid-Dissolving Toilet Paper', 'USA', '2', '0', '40', '19.99');
Insert into products values('0044', 'D Clorox Disinfecting Wipes Value Pack', 'USA', '2', '0', '36', '14.97');
Insert into products values('0045', 'D Swiffer WetJet Mopping Pad Refills for Floor Mop', 'USA', '2', '0', '15', '23.94');
Insert into products values('0046', 'D Mr. Clean Magic Eraser Extra Durable', 'USA', '2', '0', '6', '8.97');
Insert into products values('0047', 'D Moen Sinks', 'USA', '5', '0', '3', '99.99');
Insert into products values('0048', 'D 4 ft. 10/3 Heavy-Duty Workshop Extension Cord', 'USA', '3', '0', '5', '19.99');
Insert into products values('0049', 'D Philips Fluorescent Light Bulbs', 'USA', '3', '0', '25', '21.47');
Insert into products values('0050', 'D Honeywell Air Filters for Allergen', 'USA', '7', '0', '6', '34.94');
Insert into products values('0051', 'D 3M Filtrete Air Filters', 'USA', '7', '0', '12', '58.98');
Insert into products values('0052', 'D Thermostat', 'USA', '7', '0', '2', '59.00');

Insert into warehouse values('W001', 'Toronto');
Insert into warehouse values('W002', 'New York');

insert into units values ('U001', '0001', 'W002', 'A' , NULL , '7', 'Available');
insert into units values ('U002', '0001', 'W002', 'A' , NULL , '7', 'Available');
insert into units values ('U003', '0001', 'W002', 'A' , NULL , '7', 'Unavailable');
insert into units values ('U004', '0001', 'W002', 'A' , NULL , '7', 'Unavailable');

insert into units values ('U005', '0002', 'W002', 'A' , NULL , '10', 'Available');
insert into units values ('U006', '0002', 'W002', 'A' , NULL , '10', 'Unavailable');
insert into units values ('U007', '0002', 'W002', 'A' , NULL , '10', 'Unavailable');
insert into units values ('U008', '0002', 'W002', 'A' , NULL , '10', 'Available');

insert into units values ('U009', '0003', 'W002', 'A' , NULL , '3', 'Available');
insert into units values ('U010', '0003', 'W002', 'A' , NULL , '3', 'Unavailable');
insert into units values ('U011', '0003', 'W002', 'A' , NULL , '3', 'Available');
insert into units values ('U012', '0003', 'W002', 'A' , NULL , '3', 'Unavailable');


insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('100', '001', '2018-05-10', '2018-05-18', '7', 'U001', '35');
insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('101', '002', '2018-06-01', '2018-06-04', '3', 'U011', '10');
insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('102', '002', '2018-05-31', '2018-06-05', '2', 'U009', '10');
insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('103', '003', '2018-05-26', '2018-05-27', '10', 'U005', '10');
insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('104', '004', '2018-05-10', '2018-05-12', '7', 'U001', '20');
insert into units_leased (id, renterid, rentfrom, rentto, priceperunit, unitid, totalprice) values ('105', '002', '2018-05-20', '2018-05-24', '3', 'U011', '10');

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
where user_location.LocationID = users.LocationID 
AND users.UserID = units_leased.RenterID 
AND products.ProductId = units.ProductId 
AND units.UnitId = units_leased.UnitId
Group by user_location.Country, products.ProductName;

/*This query tells us who the most popular renters are based on the total price of the items they have rented.*/
select u.f_name, u.l_name, sum(totalprice) as "Total Price", c.city, c.country
from units_leased leased
join users u on u.userid = leased.renterid
join user_location c on c.locationid = u.locationid
join units unit on leased.unitid = unit.unitid
group by u.f_name, u.l_name, c.city, c.country;

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
