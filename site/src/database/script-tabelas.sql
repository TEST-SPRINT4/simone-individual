create database test;
use test;
-- drop database test;
CREATE TABLE instituicao (
	idinstituicao INT PRIMARY KEY AUTO_INCREMENT,
	nome_instituicao VARCHAR(45),
	responsavel VARCHAR(45),
	email_instituicao VARCHAR(45),
    CNPJ char(18),
    telefone char(14)
);

CREATE TABLE enderecoInstituicao (
	idEndereco int primary key auto_increment,
	CEP char(10),
    estado char(2),
    cidade varchar(45),
    bairro varchar(45),
    rua varchar(45),
    numero varchar(45),
    fkInstituicao int,
    foreign key (fkInstituicao) references instituicao (idinstituicao)
	);

create table permicoes (
idPermicoes int primary key auto_increment,
visualizar tinyint,
editar tinyint,
cadastrar tinyint,
deletar tinyint
);

CREATE TABLE nivelAcesso (
	nivel_acesso INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200),
    fkPermicoes int,
    constraint fkPermicoes_nivel_de_acesso foreign key (fkPermicoes)
    references permicoes (idPermicoes)
	);
    
CREATE TABLE funcionario (
	idfuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(45),
    email VARCHAR(45),
	senha VARCHAR(45),
    fk_nivelAcesso INT,
	CONSTRAINT fknivelAcesso FOREIGN KEY (fk_nivelAcesso)
	REFERENCES nivelAcesso(nivel_acesso),
    fk_instituicao INT,
	CONSTRAINT fkinstituicao FOREIGN KEY (fk_instituicao)
	REFERENCES instituicao(idinstituicao)
    );
    
CREATE TABLE Servidor (
	enderecoIP varchar(15) primary key,
    nome varchar(255),
    fkInstituicao int,
    constraint fkInstituicao_servidor foreign key (fkInstituicao)
    references instituicao (idInstituicao)
    );
    
CREATE TABLE Componente (
	idComponente int primary key auto_increment,
    nome varchar(45),
    modelo varchar(45),
    limiteDeUso double,
    fkIpservidor varchar(15),
    constraint fkIpservidor_componente foreign key (fkIpservidor)
    references Servidor (enderecoIP)
    );
    
Create table Parametros_Alertas (
	idParametros_Alertas int primary key auto_increment,
    maximo double,
    ideal double,
    minimo double,
    fkComponente int,
    constraint fkComponente_Parametros_Alertas foreign key (fkComponente)
    references Componente (idComponente)
    );
    
Create table RegistrosRAW (
	idRegistros int primary key auto_increment,
    dadosCapturados double,
    dataHora datetime,
    fkComponente int,
    constraint fkComponente_RegistrosRAW foreign key (fkComponente)
    references Componente (idComponente)
    );
 
 Create table imporntacia_Alerta (
	idImportancia_Alerta int primary key auto_increment,
    apelido varchar(45)
    );
    
create table Alertas (
	idAlertas int primary key auto_increment,
    descricao varchar(45),
    fkImportancia int,
    fkRegistros int,
    constraint fkImportancia_Alertas foreign key (fkImportancia)
    references imporntacia_Alerta (idImportancia_Alerta),
    constraint fkRegistros_Alertas foreign key (fkRegistros)
    references RegistrosRAW (idRegistros)
    );
    
    
    
    
	INSERT INTO nivelAcesso (descricao) VALUES
('Acesso somente leitura para visualizar informações monitoradas.'),
('Acesso para gerenciar recursos e relatórios.'),
('Acesso para supervisionar equipes e atividades.'),
('Acesso total ao sistema, incluindo administração de usuários e configurações de monitoramento.');

insert into permicoes values
	(null, 1,1,1,1),
    (null, 1,1,1,0),
    (null, 1,1,0,0),
    (null, 1,0,0,0);
    
update nivelAcesso set fkPermicoes = 1 where nivel_acesso = 4;
update nivelAcesso set fkPermicoes = 2 where nivel_acesso = 3;
update nivelAcesso set fkPermicoes = 3 where nivel_acesso = 2;
update nivelAcesso set fkPermicoes = 4 where nivel_acesso = 1;
	
    select * from nivelAcesso;
    select * from funcionario;
    select * from instituicao;
    select * from enderecoInstituicao;