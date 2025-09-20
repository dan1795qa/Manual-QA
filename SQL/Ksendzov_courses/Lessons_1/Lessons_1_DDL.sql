create table salary(
	id serial primary key,
	monthly_salary int  not null
);


select *from salary;


create table roles(
	id serial primary key,
	role_title varchar(50) unique not null
);


create table roles_salary(
	id serial primary key,
	role_id int not null,
	salary_id int not null,
	foreign key(role_id) references roles(id),
	foreign key(salary_id) references salary(id)
);


insert into roles(role_title)
values ('QA_Manual_junior'),
	   ('QA_Manual_middle'),
	   ('QA_Manual_senior'),
	   ('Java_developer_junior'),
	   ('Java_developer_middle'),
	   ('Java_developer_senior'),
	   ('Manager');



insert into salary(monthly_salary)
values (300),
	   (800),
	   (1200),
	   (1500),
	   (1800),
	   (2000),
	   (2300),
       (2500),
       (2700),
       (3000),
       (3200);
	    

      
      
update salary 
set monthly_salary = 5000
where id = 11;
  

insert into roles_salary(role_id, salary_id)
values (1,1),
	   (2,2), 
	   (3,6),
	   (4,2),
	   (5,4);


select * from salary;
select * from roles;
select * from roles_salary;


alter table roles 
add column parking int;


alter table roles 
rename column parking to taxi;


alter table roles 
drop column taxi;


delete from salary 
where id = 11;




