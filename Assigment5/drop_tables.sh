#!/bin/sh
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

drop table units_leased;
drop table units;
drop table products; 
drop table users;
drop table grade;
drop table product_category;
drop table user_location;
drop table user_type;
drop table warehouse;
exit;
EOF
