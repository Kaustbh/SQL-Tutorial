show databases;
use hit_db_demo;

-- DDL - Data Definition Language;

CREATE TABLE Person(
       id integer,
       name varchar(255));

 
show tables;
DROP TABLE person;

create table Users(

  id integer not NULL,
  name varchar(255),
  email varchar(255) unique
  );

drop table Users;

create table Users(

  id integer not NULL,
  name varchar(255),
  email varchar(255),
  constraint U_email  unique(email), 
  primary key (id)
  );

insert into Users values (1, 'kaustubh', 'aaa');
insert into Users values (2, 'kaustubh2', 'aaa');

select * from   Users;

create table Orders 
(  order_id integer,
   user_id integer,
   time_of_order datetime,
   primary key (order_id),
   foreign key (user_id) references users(id)
);

create table students
(  sid integer primary key,
   sname varchar(255) not null,
   email varchar(255) not null unique,
   age integer check (age > 6 and age < 25)

);

insert into students values (1,'kaus','aaa',26);

drop table passenger;
create table passenger
( pid integer primary key auto_increment,
  pname varchar(255) not null,
  gender varchar(255) default 'Others',
  journey_date datetime default current_timestamp
  
);

insert into passenger (pname) values ( 'kaus');

select * from passenger;

alter table students add column college varchar(255) not null;

alter table students drop column age;

alter table students modify column sname integer;

alter table students drop constraint U_email;

alter table passenger add column email varchar(255) not null;

alter table passenger add constraint P_email unique(email);

select * from passenger;

alter table passenger drop constraint P_email;


-- Data Manipulation Language 

-- retrieve :

select * from titanic_dataset;

select Name,Sex,Survived from titanic_dataset;

select Name as PassegerName, Sex as Gender, Survived from titanic_dataset;

select Name, SibSp + Parch as family from titanic_dataset;

-- Current Age of the Peoples in Titanic :

select Name,Age + 102 as CurrentAge from titanic_dataset;

select Name,100000 as Compensation from titanic_dataset;

select distinct Sex from titanic_dataset;

select distinct Embarked from titanic_dataset;

select distinct Pclass from titanic_dataset;

-- Distinct Combination of Pclass and Embarked :
select distinct Pclass,Embarked from titanic_dataset;

select * from titanic_dataset where Survived = 0;

select * from titanic_dataset where Pclass = 3;

select * from titanic_dataset where Age > 50;

select * from titanic_dataset where Pclass = 3 and Survived = 0;

select * from titanic_dataset where Age between 10 and 15;

select * from bolly;

select `Movie Name`  from bolly where Genre like 'drama' or Genre like 'thriller';

select * from bolly where Genre In ('suspense','drama','thriller');

select * from bolly where Genre Not In ('suspense','drama','thriller');

select `Movie Name` from bolly where `Movie Name` like 'A%';

select `Movie Name` from bolly where `Movie Name` like '%man%';

select `Movie Name`,`Lead Star` from bolly where `Lead Star` like '%khan' or `Lead Star` like '%Kapoor';

 select `Movie Name` from bolly where `Movie Name` like '_____';
 
 select `Movie Name` from bolly where `Movie Name` like 'A_____';
 
 select * from passenger;
 
 insert into  passenger(pname,gender,email) values ('Kaust','Male','kaus@gmail.com'),
 ('rohan','Male','rohan@yahoo.com'),('aniket','Male','aniket@gmail.com');

select * from passenger;

-- UPDATE

update passenger set pname = 'rahul' , email = 'aniket@gmail.com' where email like 'aniket@gmail.com';

-- GROUP BY :

select `Lead Star`,count(*) as num_of_movies from bolly group by `Lead Star` order by num_of_movies desc limit 5;

select Genre, sum(abs((Revenue - Budget))) as Profit from bolly group by Genre order by Profit desc ;

select * from bolly;

select Director, avg((Revenue - Budget)) as Avg_profit from bolly group by Director order by Avg_profit desc;

SELECT `Movie Name`, Budget FROM bolly GROUP BY `Movie Name`, Budget ORDER BY Budget DESC ;

select `Lead Star`,avg(`Number of Screens`) as Screens from bolly group by `Lead Star` having Screens >1000
order by Screens desc;

select min(`Movie Name`) from bolly;

select `Movie Name` , (Revenue - Budget)  profit,
Case
    When (Revenue - Budget) > 1000000000 then "SUPER HIT"
    When (Revenue - Budget) > 250000000 and (Revenue - Budget) < 1000000000 then "HIT"
    When (Revenue - Budget) > 0 and (Revenue - Budget) < 250000000 then "Average"
    Else "Flop"
End as verdict
from bolly order by profit desc;

-- JOIN :

create database  if not exists whatsapp;

use  whatsapp;

create table users
( id int primary key,
  name varchar(255),
  age int,
  emergency_contanct int
  );
  
create table groupss
( gid int,
  gname varchar(255)
  );
  
create table membership
(  mid int,
   gid int,
   uid int
);

insert into users values (1,'Nitish',34,11),
						 (2,'Ankit',32,1),
						 (3,'Neha',23,1),
                         (4,'Radhika',34,3),
                         (8,'Abhinav',31,11),
                         (11,'Rohit',29,8) ;

insert into groupss values (1,'Group 1'),
						   (2,'Group 2'),
						   (3,'Group 3'),
                           (7,'Group 7');

truncate groupss;
select * from groupss;

insert into membership values (1,1,1), (2,1,2), (3,1,3), (4,1,4), (5,2,1), (6,2,4), (7,3,1), (8,3,3);
insert into membership values (9,4,1), (10,1,5), (11,1,6);

select * from membership;

select * from users cross join groupss;

-- INNER JOIN :
select * from membership m join users u on m.uid = u.id;

-- LEFT OUTER JOIN :
select * from membership m left outer join users u on m.uid = u.id;

-- RIGHT OUTER JOIN :
select * from membership m right outer join users u on m.uid = u.id;

-- FULL OUTER JOIN :
select * from membership m left outer join users u on m.uid = u.id
union
select * from membership m right outer join users u on m.uid = u.id;

-- UNION : (prints all the unique values of the specified columns from the tables)
select id from users
union
select gid from groupss;

select id from users
union all
select gid from groupss;

select name,gname from membership m join users u on m.uid=u.id join 
groupss g on m.gid = g.gid;

select * from users;

-- SELF JOIN :
select u1.name,u2.name from users u1 join users u2 on u1.emergency_contanct = u2.id;

-- SUBQUERY :
use hit_db_demo;
select * from bolly where Budget = (select max(Budget) from bolly);

select distinct(`Lead Star`) from bolly where `Lead Star` like 'A%';

select * from bolly where `Lead Star` in 
(select distinct(`Lead Star`) from bolly where `Lead Star` like 'A%');

select `Lead Star` from 
(select `Lead Star`,abs(sum(Revenue - Budget)) as profit 
from bolly group by `Lead Star` order by profit desc limit 5) A;


select * from bolly where `Lead Star` in 
(select `Lead Star` from 
(select `Lead Star`,abs(sum(Revenue - Budget)) as profit 
from bolly group by `Lead Star` order by profit desc limit 5) A);


-- CORRELATIONAL SUBQUERY :

select `Movie Name`,Genre,(Revenue - Budget) as profit from bolly b1 where 
(Revenue - Budget) = (select max((Revenue - Budget)) from bolly b2 where
b1.Genre = b2.Genre);




  
  
  