drop if exists products;
drop if exists televisions;
drop if exists remotecontroller;
drop if exists cimodules;
drop if exists wallbrackets;

create table products(
	productId int generated always as identity,
	brand varchar(30) not null,
	model varchar(25) not null,
	price decimal(10, 2) not null,
	currentstock int not null,
	sold int not null,
	dateSold date not null,
	type varchar(30) not null,
	primary key(productId)
);

insert into products(brand, model, price, currentStock, sold, dateSold, type)
values ('Samsung', 'Neo QLED', 1.199, 12, 8, '2024-10-27', 'Televisions');

insert into products(brand, model, price, currentStock, sold, dateSold, type)
values ('Philips','55OLED809', 969.99, 20, 4, '2024-10-28', 'Televisions')

insert into products(brand, model, price, currentStock, sold, dateSold, type)
values ('Sony', 'Bravia OLED XR', 999.99, 10, 5, '2024-10-29', 'Televisions');

UPDATE products 
SET price = 750.99
WHERE productId = 1;

select * from products

select products.brand, products.model, products.sold from Products WHERE products.sold >6
	
select count(model) from products

create table televisions(
	televisionId int generated always as identity,
	height decimal(5,2) not null,
	width decimal(5,2) not null,
	imageQuality varchar(30) not null,
	sharpness varchar(30) not null,
	wifi boolean not null,
	smartTv boolean not null,
	voiceControl boolean not null,
	HDR boolean not null,
	productId int,
	primary key(televisionId),
	foreign key(productId) references products(productId)
);

insert into televisions(height,width,imageQuality,sharpness,wifi,smartTv,voiceControl,HDR, productId)
values(79.94, 102.29,'Very good','4K (UHD)',true,true,true,true,1);

insert into televisions(height,width,imageQuality,sharpness,wifi,smartTv,voiceControl,HDR, productId)
values(70.10, 122.50,'Good','OLED',true,true,false,true,2);

insert into televisions(height,width,imageQuality,sharpness,wifi,smartTv,voiceControl,HDR, productId)
values(85.00, 112.29,'Very good','4K (UHD)',true,true,true,true,3);

select * from televisions

UPDATE televisions
SET voiceControl = false
WHERE televisionID = 1;

DROP TABLE televisions

SELECT products.brand, products.model, televisions.height, televisions.width, televisions.imageQuality
FROM products
INNER JOIN Televisions ON televisions.productId = Products.productId

create table remotecontrollers(
	smart boolean not null,
	batteryType varchar(30) not null,
	televisionId int,
	foreign key(televisionId) references televisions(televisionId)
);

insert into remotecontrollers(smart,batteryType,televisionId)
values(true, 'AA+',1)

insert into remotecontrollers(smart,batteryType,televisionId)
values(true, 'AA',2)

insert into remotecontrollers(smart,batteryType,televisionId)
values(false, 'AA+',3)

select * from remotecontrollers

DROP table remotecontrollers

SELECT *
FROM televisions INNER JOIN remotecontrollers
ON televisions.televisionId = remotecontrollers.televisionId


create table cimodules(
   	provider varchar(30) not null,
	encoding decimal(2,1) not null,
	televisionId int,
	foreign key (televisionId) references televisions(televisionId)
)

insert into cimodules(provider,encoding,televisionId)
values('Ziggo', 1.3,1);
	   
insert into cimodules(provider,encoding,televisionId)
values('KPN', 1.3,1);

insert into cimodules(provider,encoding,televisionId)
values('Tele2', 1.3,1);

UPDATE cimodules
SET televisionId = 2
WHERE provider = 'KPN'

UPDATE cimodules
SET televisionId = 3
WHERE provider = 'Tele2'

UPDATE cimodules
SET encoding = 1.4
WHERE provider = 'KPN'

select * from cimodules

drop table cimodules
				
create table wallbrackets(
	adjustable boolean not null,
	height decimal(5,2) not null,
	width decimal(5,2) not null,
	televisionId int,
	foreign key (televisionId) references televisions(televisionId)
)

insert into wallbrackets(adjustable, height, width,televisionId)
values(true, 56.3, 87.3,1);

insert into wallbrackets(adjustable, height, width,televisionId)
values(true, 60.3, 97.3,2);

insert into wallbrackets(adjustable, height, width,televisionId)
values(true, 65.3, 80.3,3);

select * from wallbrackets

UPDATE wallbrackets
SET adjustable = false
WHERE televisionId = 3

select wallbrackets.height hoogte, wallbrackets.width breedte FROM wallbrackets WHERE wallbrackets.adjustable = 'false'

SELECT products.brand, products.model,televisions.height, televisions.width, televisions.imageQuality, remotecontrollers.batteryType, cimodules.encoding, wallbrackets.adjustable FROM televisions
left join products on televisions.productId = products.productId
left join remotecontrollers on (televisions.productId = remotecontrollers.televisionId and products.productId = remotecontrollers.televisionId)
left join cimodules on (televisions.productId = cimodules.televisionId and products.productId = cimodules.televisionId)
left join wallbrackets on (televisions.productId = wallbrackets.televisionId and products.productId = wallbrackets.televisionId);

SELECT concat(products.brand,' ',products.model, ' is ', televisions.height,'cm hoog en ',televisions.width,' cm breedt.' ) Specificaties FROM televisions
left join products on televisions.productId = products.productId
left join remotecontrollers on (televisions.productId = remotecontrollers.televisionId and products.productId = remotecontrollers.televisionId)
left join cimodules on (televisions.productId = cimodules.televisionId and products.productId = cimodules.televisionId)
left join wallbrackets on (televisions.productId = wallbrackets.televisionId and products.productId = wallbrackets.televisionId);

