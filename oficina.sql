CREATE DATABASE Oficina;
use Oficina;

create table clients (
	idClients int primary key auto_increment,
    CPF char(11),
    Cname varchar(50),
    contact char(11),
    address varchar(255)
);

create table employee (
	idEmployee int primary key auto_increment,
    ecode varchar(45),
    specialty varchar(45)
);

create table vehicle (
	idVehicle int primary key auto_increment,
    idClients int,
    model varchar(45),
    carPlate char(7),
    constraint fk_vehicle_clients foreign key (idClients) references clients(idClients)
);

create table car_repair (
	idRepair int primary key auto_increment,
    idEmployee int,
    specialistTeam varchar(45),
    constraint fk_car_repair foreign key (idEmployee) references employee(idEmployee)
);

create table checkup (
	idCheckup int primary key auto_increment,
	idEmployee int,
    checkupLevel enum('Parcial','Completo'),
    checkupTeam varchar(45),
	constraint fk_checkup_vehicle foreign key (idEmployee) references employee(idEmployee)

);

create table request (
	idRequest int primary key auto_increment,
    idVehicle int,
    idEmployee int,
    service varchar(45),
    Rdescription varchar(45),
    requestDate date,
    constraint fk_car_request foreign key (idVehicle) references vehicle(idVehicle),
    constraint fk_car_os foreign key (idEmployee) references employee(idEmployee)
    
);
create table taxAndValues (
	idTaxAndValues int primary key auto_increment,
	taxService varchar(3) default '10%',
    pieceValue varchar(10)
);
create table serviceOrder (
	idserviceOrder int primary key auto_increment,
    idTaxAndValues int,
	emissionDate date,
    deliveryDate date,
	constraint fk_SO_taxAndValues foreign key (idTaxAndValues) references taxAndValues(idTaxAndValues)
);

CREATE TABLE payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClients INT,
    paymentMethod ENUM('Boleto', 'Cartão', 'PIX') NOT NULL,
    limitAvailable FLOAT,
    CONSTRAINT fk_payments_client FOREIGN KEY (idClients) REFERENCES clients(idClients)
);
