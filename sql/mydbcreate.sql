create table F16_T11_customer(
customerid char(5) ,
first_name varchar2(25),
last_name varchar2(25),
dob date,
gender char(1) check(gender='M' or gender='F'),
type varchar2(10),
email varchar2(30),
address varchar2(50),
phonenumber number(10),
primary key(customerid)
);
create table F16_T11_employee(
employeeid char(5) ,
first_name varchar2(25),
last_name varchar2(25),
dob date,
gender char(1) check(gender='M' or gender='F'),
email varchar2(30),
address varchar2(50),
phonenumber number(10),
primary key(employeeid)
);

create table F16_T11_book(
bookid char(5) ,
no_of_pages number(5),
isbn number(13),
edition number(2),
name varchar2(100),
author varchar2(50),
publisher varchar2(50),
price decimal(7,2),
genre varchar2(15),
primary key(bookid)
);
create table F16_T11_supplier(
supplierid char(6),
name varchar2(25),
address varchar2(50),
email varchar2(50),
phno number(10),
primary key(supplierid)
);
create table F16_T11_store(
storeid char(6),
name varchar2(25),
address varchar2(50),
rent number(5),
start_date date,
primary key(storeid)
);
create table F16_T11_purchase(
customerid char(5),
bookid char(5),
storeid char(6),
paymentmode char(10),
credicardinfo varchar2(50),
tax decimal(4,2),
foreign key(customerid) references F16_T11_customer,
foreign key(storeid) references F16_T11_store,
foreign key(bookid) references F16_T11_book,
primary key(customerid,bookid,storeid)
);
create table F16_T11_purchase_details(
customerid char(5),
bookid char(5),
storeid char(6),
purchase_date date,
quantity number(3),
foreign key(customerid,storeid,bookid) references F16_T11_purchase(customerid,storeid,bookid),
primary key(customerid,bookid,storeid,purchase_date,quantity)
);
create table F16_T11_supply(
supplierid char(6),
bookid char(5),
storeid char(6),
book_cost decimal(7,2),
foreign key(supplierid) references F16_T11_supplier,
foreign key(storeid) references F16_T11_store,
foreign key(bookid) references F16_T11_book,
primary key(supplierid,bookid,storeid)
);
create table F16_T11_supply_details(
supplierid char(6),
bookid char(5),
storeid char(6),
supply_date date,
quantity number(4),
foreign key(supplierid,storeid,bookid) references F16_T11_supply(supplierid,storeid,bookid),
primary key(supplierid,bookid,storeid,supply_date,quantity)
);
create table F16_T11_return(
customerid char(5),
bookid char(5),
storeid char(6),
return_reason varchar2(25),
return_date date,
quantity number(4),
foreign key(customerid) references F16_T11_customer,
foreign key(storeid) references F16_T11_store,
foreign key(bookid) references F16_T11_book,
primary key(customerid,bookid,storeid)
);
create table F16_T11_manager(
employeeid char(5),
salary number(7),
experience number(2),
storeid char(6),
joining_date date,
end_date date,
foreign key(employeeid) references F16_T11_employee,
foreign key(storeid) references F16_T11_store,
primary key(employeeid)
);
create table F16_T11_sales_person(
employeeid char(5),
wages_per_hr number(4),
storeid char(6),
joining_date date,
end_date date,
working_hours number(2),
foreign key(employeeid) references F16_T11_employee,
foreign key(storeid) references F16_T11_store,
primary key(employeeid)
);

create table F16_T11_dependents(
memployeeid char(5),
name varchar2(25),
dob date,
gender char(1),
relationship char(10),
foreign key(memployeeid) references F16_T11_manager(employeeid),
primary key(memployeeid,name)
);