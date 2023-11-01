/* Banco de dados para gerenciamento do hotel*/

create database dbHotel;

show databases;

show tables;

use dbHotel;
create table funcionarios (
	idFunc int primary key auto_increment,
	nomeFunc varchar(100) not null,
    login varchar(20) not null unique,
    email varchar(50) not null,
    senha varchar(255) not null,
    cargo varchar(20)
);

describe funcionarios;

insert into funcionarios(nomeFunc, login, senha, email, cargo) values ("Administrator", "admin", md5("admin"), "administrador@senacsp.edu.br", "Administrador");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Pamella Pereto", "pamellapereto", "pamellapereto@senacsp.edu.br", md5("123@senac"), "TI");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Breno Silva", "brenosilva", "brenosilva@senacsp.edu.br", md5("123@senac"), "Contabilidade");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Victoria Cardoso", "victoriacardoso", "victoriacardoso@senacsp.edu.br", md5("123@senac"), "RH");
insert into funcionarios(nomeFunc, login, email, senha) values ("Laura Lopes", "lauralopes", "lauralopes@senacsp.edu.br", md5("123@senac"));

select * from funcionarios;

select login as Login, senha from funcionarios where login = "admin" and senha = md5("admin"); 
select login as Login, senha from funcionarios where login = "admin" and senha = md5("admin");
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios from funcionarios order by nomeFunc asc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios from funcionarios order by nomeFunc desc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios, cargo as Cargo_Funcionario from funcionarios order by idFunc desc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios where cargo <> 'null' order by idFunc desc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios, cargo as Cargo_Funcionario from funcionarios order by idFunc desc;
select * from funcionarios where cargo = 'TI' order by nomeFunc asc;

create table quartos (
	idQuarto int primary key auto_increment, 
    andar varchar(10) not null, 
    numeroQuaro varchar(10) not null,
    tipoQuarto varchar(50) not null,
    ocupacaoMax int not null,
    situacao char(3) not null,
    nome varchar(50) not null,
    descricao text,
    foto varchar(255) not null,
    preco decimal(10,2) not null,
    cafeDaManha varchar(3),
    precoCafe decimal(10,2),
	tipoCama varchar(20),
    varanda char(3)
    );
    
describe quartos;
    
insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
("5º", "505", "Superior Premier", 3, "não", "Familiar", "O quarto de 26m² com piso frio, com varanda - vista bairro.
Oferece ar condicionado individual, TV LCD 42’’, wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.",
"https://media-cdn.tripadvisor.com/media/photo-s/1c/a0/e3/aa/bourbon-convention-ibirapuera.jpg", 750.90, "sim", 60.00, "Queen", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values
("5º", "505", "Superior Premier Twin", 3, "não", "Familiar", " Podemos acomodar até 2 pessoas conforme disponibilidade em apartamento duplo twin.
A 1º criança na mesma cama que os pais é cortesia até 6 anos.", "https://media-cdn.tripadvisor.com/media/photo-s/1c/a0/e3/aa/bourbon-convention-ibirapuera.jpg", 950.90, "não", "King", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
("4º", "409", "Quarto de Solteiro", 2, "sim", "Junior", "Quarto com uma cama de casal
Os quartos contam com TV de tela plana, Frigobar, Wi-fi, e Ar-Condicionado. Para sua comodidade, são fornecidos produtos de banho de cortesia e secador de cabelo.",
"https://media-cdn.tripadvisor.com/media/photo-s/1c/a0/e3/aa/bourbon-convention-ibirapuera.jpg", 550.90, "sim", 60.00, "Solteiro tradicional", "sim");

select * from quartos;
select * from quartos where situacao = 'nao';
select * from quartos where situacao = 'nao' and cafeDaManha = 'sim';
select * from quartos where varanda = 'sim' and cafeDaManha = 'sim' and situacao = 'nao';
select * from quartos where situacao = 'nao' and preco < 700;
select * from quartos order by preco desc;

create table pedido (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado") not null,
    idClientes int not null,
    foreign key (idClientes) references clientes(idClientes)
);

insert into pedido (statusPedido, idClientes) values ("Pendente", 1);
insert into pedido (statusPedido, idClientes) values ("Finalizado", 2);

select * from pedido;
select * from pedido inner join clientes on pedido.idClientes = clientes-.idClientes;

create table reservas (
	idReserva int primary key auto_increment,
    idPedido int not null,
    idQuarto int not null,
    foreign key (idPedido) references pedido(idPedido),
    foreign key (idQuarto) references quartos(idQuarto)
);

select * from reservas;

select reserva. idReserva, pedido.idPedido,
quartos.idQuarto, quartos.nome, quartos.andar, quartos.numeroQuarto
from (reservas inner join pedido on reservas.idPedido = pedido.idPedido)
inner join quartos on reservas.idQuartos = quartos.idQuarto;

insert into reservas (idPedido, idQuarto, checkin, checkout) values (1, 1, "2023-11-02 14:00:00", "2023-11-05 12:00:00");
insert into reservas (idPedido, idQuarto,checkin, checkout) values (1, 3, "2023-11-02 14:00:00", "2023-11-05 12:00:00");


alter table reservas add column checkin datetime not null;
alter table reservas add column checkout datetime not null;

describe reservas;

describe clientes;

drop table clientes;

insert into clientes (nomeCompleto, cpf, rg, email, numeroCartao, nomeTitular, validade, cvv, checkin, checkout) values ("José de Assis", "829.942.570-09", "48.353.888-7", "jose@gmail.com");

insert into clientes (nomeCompleto, cpf, rg, email, numeroCartao, nomeTitular, validade, cvv, checkin, checkout) values ("Pedroca Mussolini", "111.222.333-04", "11.222.333-4", "pedro@gmail.com");


drop table clientes;


select * from clientes;

