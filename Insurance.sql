CREATE TABLE users (
    id NUMBER   GENERATED AS IDENTITY ,
    first_name VARCHAR2(20) not null,
    email VARCHAR2(30) not null unique,
    phone_number Varchar2(15) not null ,
    birth_date Date,
    fid VARCHAR2(10) not null unique,
    serial_number VARCHAR2(15) not null unique,
    constraint users_pk primary key(id)
);


CREATE TABLE agreements (
    id number   GENERATED AS IDENTITY ,
    premium number not null check(premium>0),
    period Varchar2(15) not null,
    deductible_amount number not null,
    current_situation Varchar2(15) not null,
    user_id number references users(id) on delete cascade,
    product_id number references insurance_products(id) on delete cascade,
    constraint agreements_pk primary key (id)
);




create table insurance_products (
    id number   GENERATED AS IDENTITY ,
    prduct_name Varchar2(25),
    category varchar2(20),
    constraint insurance_products_pk primary key (id)
);





create table car_insurance_details (
    id number  GENERATED AS IDENTITY,
    car_number varchar2(10)  not null,
    price number not null,
    mark varchar2(15),
    production_year date, 
    agreement_id number references agreements(id),
    constraint car_insurance_details_pk primary key (id)
);


create table home_insurance_details (
    id number GENERATED AS IDENTITY,
    house_address varchar2(20) not null,
    price number not null,
    production_year date,
    agreement_id number references agreements(id),
    constraint home_insurance_details_pk primary key (id)
);

create table claim (
    id number  GENERATED AS IDENTITY,
    claim_date date not null,
    accident_date date not null,
    claim_description clob,
    claimed_amount number,
    claim_situation Varchar2(20) not null,
    user_id number references users(id)  on delete cascade,
    payment_id number references payments(id) on delete set null,
    agreement_id number references agreements(id) on delete set null,
    constraint ck_claim1 check(accident_date<=claim_date),
    constraint claim_pk primary key (id)
);



create table payments (
    id number  GENERATED AS IDENTITY,
    payment_date date not null,
    payment_type Varchar2(10),
    payment_amount number not null check(payment_amount>0),
    payment_kind varchar2(10),
    payment_status varchar2(10) not null,
    user_id number references users(id)  on delete set null,
    partner_id number references partners(id) on delete set null   ,
    constraint payments_pk primary key (id)
);


create table partners (
    id number  GENERATED AS IDENTITY,
    partner_name varchar2(20),
    partner_address varchar2(20),
    constraint partners_pk primary key (id)
);

insert into partners( partner_name, partner_address)
values('AUTO FIX', 'BAKU');

insert into users(first_name, email, phone_number, birth_date, fid, serial_number)
values('Əhməd Əliyev','eliyevehmed@gmail.com', '05000000', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'a12akj', 'aa12312');

insert into users(first_name, email, phone_number, birth_date, fid, serial_number)
values('Huseyn Memmedov','memmedovhusyen@gmail.com', '060201300', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'abjk19', 'aa123891')


INSERT INTO users(first_name, email, phone_number, birth_date, fid, serial_number)
VALUES('Nigar Quliyeva', 'nigarquliyeva@gmail.com', '0512345678', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'ng15qv', 'bb19876');

INSERT INTO users(first_name, email, phone_number, birth_date, fid, serial_number)
VALUES('Elnur Hasanov', 'elnurhasanov@gmail.com', '0559876543', TO_DATE('1995-09-12', 'YYYY-MM-DD'), 'eh12hs', 'cc32154');

INSERT INTO users(first_name, email, phone_number, birth_date, fid, serial_number)
VALUES('Leyla Abbasova', 'leylaabbasova@gmail.com', '0771234567', TO_DATE('2003-03-22', 'YYYY-MM-DD'), 'la22ab', 'dd45678');


INSERT INTO users(first_name, email, phone_number, birth_date, fid, serial_number)
VALUES('Sevil Abbasova', 'sevilabbasova@gmail.com', '0771133567', TO_DATE('2002-03-22', 'YYYY-MM-DD'), 'da12ab', 'ddadc678');

INSERT INTO users(first_name, email, phone_number, birth_date, fid, serial_number)
VALUES('Huseyn Abbasov', 'huseynabbasov@gmail.com', '0471133567', TO_DATE('2001-03-22', 'YYYY-MM-DD'), 'da11ab', 'ddadc18');

------
insert into agreements(premium, period, deductible_amount, current_situation, user_id, product_id )
values(100, 'illik', 500, 'aktiv', 1, 1 )

insert into agreements(premium, period, deductible_amount, current_situation, user_id, product_id )
values(150, 'illik', 600, 'aktiv', 2, 2)

INSERT INTO agreements(premium, period, deductible_amount, current_situation, user_id, product_id)
VALUES(200, 'illik', 300, 'aktiv', 22, 1);

INSERT INTO agreements(premium, period, deductible_amount, current_situation, user_id, product_id)
VALUES(300, 'ayliq', 400, 'passiv', 23, 2);

INSERT INTO agreements(premium, period, deductible_amount, current_situation, user_id, product_id)
VALUES(300, 'illik', 400, 'aktiv', 24, 1);


INSERT INTO agreements(premium, period, deductible_amount, current_situation, user_id, product_id)
VALUES(120, 'ayliq', 100, 'passiv', 23, 2);


INSERT INTO agreements(premium, period, deductible_amount, current_situation, user_id, product_id)
VALUES(250, 'illik', 300, 'aktiv', 2, 1);
-- inserting data into car insurance details

INSERT INTO car_insurance_details(car_number, price, mark, production_year, agreement_id)
VALUES('90AZ123', 25000, 'Mercedes', TO_DATE('2015-05-20', 'YYYY-MM-DD'), 4);

INSERT INTO car_insurance_details(car_number, price, mark, production_year, agreement_id)
VALUES('99NN456', 18000, 'Toyota', TO_DATE('2018-07-15', 'YYYY-MM-DD'), 6);

--inserting data into home insurance details

INSERT INTO home_insurance_details(house_address, price, production_year, agreement_id)
VALUES('Baku, Nizami street', 150000, TO_DATE('2010-01-01', 'YYYY-MM-DD'), 8);

INSERT INTO home_insurance_details(house_address, price, production_year, agreement_id)
VALUES('Baku, Sahil street', 180000, TO_DATE('2005-08-12', 'YYYY-MM-DD'), 5);

INSERT INTO home_insurance_details(house_address, price, production_year, agreement_id)
VALUES('Baku, Heydar street', 95000, TO_DATE('2018-06-20', 'YYYY-MM-DD'), 8);

--insert into car insurance details
insert into car_insurance_details(car_number, price, mark, production_year, agreement_id)
values('10da100', 300, 'BMW',TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1 )

--inserting data into claim table
insert into claim(claim_date, accident_date,claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
values( TO_DATE('2024-11-01', 'YYYY-MM-DD'),  TO_DATE('2024-10-29', 'YYYY-MM-DD'), 'Eve gederken bir masin aniden qarsisina cixib. Suret limit kecilmeyib',
9000, 'ACCEPTED', 1, 2, 1)
INSERT INTO claim(claim_date, accident_date, claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
VALUES(TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'), 'Qeza', 5000, 'REJECTED',22 , 1, 4);

INSERT INTO claim(claim_date, accident_date, claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
VALUES(TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'Yangin', 12000, 'ACCEPTED', 23, 2, 5);

INSERT INTO claim(claim_date, accident_date, claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
VALUES(TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Yangin', 3000, 'PENDING', 21, NULL, 7);

INSERT INTO claim(claim_date, accident_date, claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
VALUES(TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Qeza', 3000, 'PENDING', 24, NULL, 6);

INSERT INTO claim(claim_date, accident_date, claim_description, claimed_amount, claim_situation, user_id, payment_id, agreement_id)
VALUES(TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Yangin', 3000, 'PENDING', 25, NULL, 8);

insert into insurance_products(prduct_name, category)
values('avtomobil sigortasi', 'avtomobil')


insert into insurance_products(prduct_name, category)
values('danismaz emlak sigortasi', 'emlak')



--inserting data into payments
insert into payments(payment_date,payment_type, payment_amount, payment_kind, payment_status, user_id,partner_id)
values( TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Card', '8000', 'TO_PARTNER', 'DONE', 22, 1)

insert into payments(payment_date,payment_type, payment_amount, payment_kind, payment_status, user_id,partner_id)
values( TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Card', '8000', 'TO_PARTNER', 'DONE', 24, 2)

insert into payments(payment_date,payment_type, payment_amount, payment_kind, payment_status, user_id,partner_id)
values( TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Card', '8000', 'SUB', 'DONE', 23, 1)

insert into payments(payment_date,payment_type, payment_amount, payment_kind, payment_status, user_id,partner_id)
values( TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Card', '8000', 'SUB', 'DONE', 25, 1)

