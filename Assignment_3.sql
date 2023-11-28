drop table units_leased;
drop table units;
drop table products; 
drop table users;
drop table grade;
drop table product_category;
drop table user_location;
drop table user_type;
drop table warehouse;


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
