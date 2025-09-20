create table phones_samsung(
	id serial primary key,
	model varchar(40),
	ram int not null,
	front_camera int,
	price int
)

create table phones_apple(
	id serial primary key,
	model varchar(40),
	ram int not null,
	front_camera int,
	price int
)

insert into phones_samsung(model, ram, front_camera, price)
values ('A50', 6, 10, 300),
	   ('A50', 8, 10, 400),
	   ('A52', 8, 16, 500),
	   ('S20', 8, 24, 1500),
	   ('S21', 8, 12, 1000),
	   ('S22', 6, 12, 1200),
	   ('A71', 6, 12, 1200),
	   ('A91', 4, 12, 1900),
	   ('A57', 8, 8, 900),
	   ('A32', 8, 4, 800),
	   ('A33', 8, 5, 750),
	   ('A43', 8, 5, 850)
	;
	
insert into phones_apple(model, ram, front_camera, price)
values ('X', 4, 16, 500),
	   ('XR', 6, 15, 600),
	   ('XS', 6, 18, 700),
	   ('11', 6, 16, 1000),
	   ('11_pro', 10, 12, 1200),
	   ('12', 6, 12, 1500),
	   ('12_pro', 16, 12, 1700),
	   ('13', 6, 24, 1600),
	   ('13_pro', 24, 8, 2000),
	   ('SE 2020', 8, 24, 600),
	   ('Mini', 8, 16, 750),
	   ('12 pro max', 8, 36, 1900)
	;