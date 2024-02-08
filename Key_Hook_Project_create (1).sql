-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-11-19 22:03:13.849

-- tables
-- Table: actives
CREATE TABLE actives (
    request_employee_id int  NOT NULL,
    request_room_number int  NOT NULL,
    request_room_building varchar(4)  NOT NULL,
    key_number int  NOT NULL,
    CONSTRAINT actives_pk PRIMARY KEY (request_employee_id,request_room_number,key_number,request_room_building)
);

-- Table: buildings
CREATE TABLE buildings (
    name varchar(4)  NOT NULL,
    CONSTRAINT buildings_pk PRIMARY KEY (name)
);

-- Table: door_hooks
CREATE TABLE door_hooks (
    door_name varchar(75)  NOT NULL,
    door_room_number int  NOT NULL,
    door_room_building varchar(4)  NOT NULL,
    hook_ID int  NOT NULL,
    CONSTRAINT door_hooks_pk PRIMARY KEY (door_name,door_room_number,door_room_building,hook_ID)
);

-- Table: door_names
CREATE TABLE door_names (
    name varchar(75)  NOT NULL,
    CONSTRAINT door_names_pk PRIMARY KEY (name)
);

-- Table: doors
CREATE TABLE doors (
    name varchar(75)  NOT NULL,
    room_number int  NOT NULL,
    room_building varchar(4)  NOT NULL,
    CONSTRAINT doors_pk PRIMARY KEY (name,room_number,room_building)
);

-- Table: employees
CREATE TABLE employees (
    last_name varchar(50)  NOT NULL,
    first_name varchar(50)  NOT NULL,
    id int  NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY (id)
);

-- Table: hooks
CREATE TABLE hooks (
    hook_ID int  NOT NULL,
    CONSTRAINT hooks_pk PRIMARY KEY (hook_ID)
);

-- Table: keys
CREATE TABLE keys (
    number int  NOT NULL,
    hook_ID int  NOT NULL,
    CONSTRAINT keys_pk PRIMARY KEY (number)
);

-- Table: loans
CREATE TABLE loans (
    assigned_time time  NOT NULL,
    assigned_date date  NOT NULL,
    request_employee_id int  NOT NULL,
    request_room_number int  NOT NULL,
    request_room_building varchar(4)  NOT NULL,
    key_number int  NOT NULL,
    CONSTRAINT loans_pk PRIMARY KEY (request_employee_id,request_room_number,key_number,request_room_building)
);

-- Table: lost
CREATE TABLE lost (
    charge int  NOT NULL,
    request_employee_id int  NOT NULL,
    request_room_number int  NOT NULL,
    request_room_building varchar(4)  NOT NULL,
    key_number int  NOT NULL,
    CONSTRAINT lost_pk PRIMARY KEY (request_employee_id,request_room_number,key_number,request_room_building)
);

-- Table: requests
CREATE TABLE requests (
    room_number int  NOT NULL,
    employee_id int  NOT NULL,
    room_building varchar(4)  NOT NULL,
    CONSTRAINT requests_pk PRIMARY KEY (employee_id,room_number,room_building)
);

-- Table: returns
CREATE TABLE returns (
    return_time time  NOT NULL,
    return_date date  NOT NULL,
    request_employee_id int  NOT NULL,
    request_room_number int  NOT NULL,
    request_room_building varchar(4)  NOT NULL,
    key_number int  NOT NULL,
    CONSTRAINT returns_pk PRIMARY KEY (request_employee_id,request_room_number,key_number,request_room_building)
);

-- Table: rooms
CREATE TABLE rooms (
    number int  NOT NULL,
    building varchar(4)  NOT NULL,
    CONSTRAINT rooms_pk PRIMARY KEY (number,building)
);

-- foreign keys
-- Reference: Lost_loans_fk_01 (table: lost)
ALTER TABLE lost ADD CONSTRAINT Lost_loans_fk_01
    FOREIGN KEY (request_employee_id, request_room_number, key_number, request_room_building)
    REFERENCES loans (request_employee_id, request_room_number, key_number, request_room_building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: actives_loans_fk_01 (table: actives)
ALTER TABLE actives ADD CONSTRAINT actives_loans_fk_01
    FOREIGN KEY (request_employee_id, request_room_number, key_number, request_room_building)
    REFERENCES loans (request_employee_id, request_room_number, key_number, request_room_building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: door_hooks_doors_fk_01 (table: door_hooks)
ALTER TABLE door_hooks ADD CONSTRAINT door_hooks_doors_fk_01
    FOREIGN KEY (door_name, door_room_number, door_room_building)
    REFERENCES doors (name, room_number, room_building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: door_hooks_hooks_fk_01 (table: door_hooks)
ALTER TABLE door_hooks ADD CONSTRAINT door_hooks_hooks_fk_01
    FOREIGN KEY (hook_ID)
    REFERENCES hooks (hook_ID)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: door_room_fk_01 (table: doors)
ALTER TABLE doors ADD CONSTRAINT door_room_fk_01
    FOREIGN KEY (room_number, room_building)
    REFERENCES rooms (number, building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: doors_door_names_fk_01 (table: doors)
ALTER TABLE doors ADD CONSTRAINT doors_door_names_fk_01
    FOREIGN KEY (name)
    REFERENCES door_names (name)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: keys_hooks_fk_01 (table: keys)
ALTER TABLE keys ADD CONSTRAINT keys_hooks_fk_01
    FOREIGN KEY (hook_ID)
    REFERENCES hooks (hook_ID)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: loans_keys_01 (table: loans)
ALTER TABLE loans ADD CONSTRAINT loans_keys_01
    FOREIGN KEY (key_number)
    REFERENCES keys (number)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: loans_requests_fk_01 (table: loans)
ALTER TABLE loans ADD CONSTRAINT loans_requests_fk_01
    FOREIGN KEY (request_employee_id, request_room_number, request_room_building)
    REFERENCES requests (employee_id, room_number, room_building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: request_employee_fk_01 (table: requests)
ALTER TABLE requests ADD CONSTRAINT request_employee_fk_01
    FOREIGN KEY (employee_id)
    REFERENCES employees (id)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: requests_rooms_fk_01 (table: requests)
ALTER TABLE requests ADD CONSTRAINT requests_rooms_fk_01
    FOREIGN KEY (room_number, room_building)
    REFERENCES rooms (number, building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: returns_loans (table: returns)
ALTER TABLE returns ADD CONSTRAINT returns_loans
    FOREIGN KEY (request_employee_id, request_room_number, key_number, request_room_building)
    REFERENCES loans (request_employee_id, request_room_number, key_number, request_room_building)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rooms_buildings_fk_01 (table: rooms)
ALTER TABLE rooms ADD CONSTRAINT rooms_buildings_fk_01
    FOREIGN KEY (building)
    REFERENCES buildings (name)
    ON DELETE  RESTRICT 
    ON UPDATE  RESTRICT 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

DROP TABLE door_hooks;
DROP TABLE doors;
DROP TABLE door_names;
DROP TABLE actives;
DROP TABLE lost;
DROP TABLE returns;
DROP TABLE loans;
DROP TABLE requests;
DROP TABLE keys;
DROP TABLE hooks;
DROP TABLE employees;
DROP TABLE rooms;
DROP TABLE buildings;

--Inserting into employees
INSERT INTO employees (last_name, first_name, id) VALUES ('Meghani', 'Deep', 457);
INSERT INTO employees (last_name, first_name, id) VALUES ('Paul', 'Dev', 298);
INSERT INTO employees (last_name, first_name, id) VALUES ('Oviedo', 'Rhoy', 562);
INSERT INTO employees (last_name, first_name, id) VALUES ('Kakadiya', 'Om', 851);
INSERT INTO employees (last_name, first_name, id) VALUES ('Brown', 'David', 123);

--Inserting into buildings
INSERT INTO buildings (name) VALUES ('ECS');
INSERT INTO buildings (name) VALUES ('VEC');
INSERT INTO buildings (name) VALUES ('COB');
INSERT INTO buildings (name) VALUES ('HC');
INSERT INTO buildings (name) VALUES ('HS');

--Inserting into rooms
INSERT INTO rooms (number, building) VALUES (308, 'ECS');
INSERT INTO rooms (number, building) VALUES (501, 'VEC');
INSERT INTO rooms (number, building) VALUES (125, 'COB');
INSERT INTO rooms (number, building) VALUES (150, 'HC');
INSERT INTO rooms (number, building) VALUES (100, 'HS');

--Inserting into door_names
INSERT INTO door_names (name) VALUES ('front');
INSERT INTO door_names (name) VALUES ('back');
INSERT INTO door_names (name) VALUES ('south');
INSERT INTO door_names (name) VALUES ('north');
INSERT INTO door_names (name) VALUES ('west');

--Inserting into doors
INSERT INTO doors (name, room_number, room_building) VALUES ('front', 308, 'ECS');
INSERT INTO doors (name, room_number, room_building) VALUES ('west', 100, 'HS');
INSERT INTO doors (name, room_number, room_building) VALUES ('south', 150, 'HC');
INSERT INTO doors (name, room_number, room_building) VALUES ('front', 125, 'COB');
INSERT INTO doors (name, room_number, room_building) VALUES ('back', 501, 'VEC');

--Inserting into hooks
INSERT INTO hooks (hook_ID) VALUES (100);
INSERT INTO hooks (hook_ID) VALUES (200);
INSERT INTO hooks (hook_ID) VALUES (300);
INSERT INTO hooks (hook_ID) VALUES (400);
INSERT INTO hooks (hook_ID) VALUES (500);

--Inserting into door_hooks
INSERT INTO door_hooks (door_name, door_room_number, door_room_building, hook_ID)
VALUES ('front', 308, 'ECS', 100);
INSERT INTO door_hooks (door_name, door_room_number, door_room_building, hook_ID)
VALUES ('back', 501, 'VEC', 200);
INSERT INTO door_hooks (door_name, door_room_number, door_room_building, hook_ID)
VALUES ('west', 100, 'HS', 300);
INSERT INTO door_hooks (door_name, door_room_number, door_room_building, hook_ID)
VALUES ('south', 150, 'HC', 400);
INSERT INTO door_hooks (door_name, door_room_number, door_room_building, hook_ID)
VALUES ('front', 125, 'COB', 500);
