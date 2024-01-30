CREATE DATABASE CASINOBASE;

DROP TABLE IF EXISTS Player_in_game;
DROP TABLE IF EXISTS Game; 
DROP TABLE IF EXISTS Croupier;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Transfer_desk;
DROP TABLE IF EXISTS register;



USE CASINOBASE
GO

CREATE TABLE register
(
	id_user int identity(1,1) not null,
	login_user varchar(50) not null,
	password_user varchar(50) not null,
	is_admin bit
);

insert into register (login_user, password_user, is_admin) values ('admin', 'admin', 1)

CREATE TABLE Transfer_desk
(
    id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	card_number int NOT NULL check(card_number >= 0 and card_number <= 56), 
	places int NOT NULL check(Places > 0),  
);

CREATE TABLE Player
(
	player_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	player_name nvarchar(60) NOT NULL,
);

CREATE TABLE Croupier
(
	croupier_id int NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	croupier_name nvarchar(60) NOT NULL 
	check (croupier_name not like '%[^А-Яа-я ]%'),
);

CREATE TABLE Game
(
	game_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	croupier_id int not null FOREIGN KEY REFERENCES Croupier (croupier_id),
	table_id int not null FOREIGN KEY REFERENCES Transfer_desk (id),
	date_time smalldatetime NOT NULL,
	best_combination nvarchar(50) NOT NULL DEFAULT 'Ожидает результата',
);

CREATE TABLE Player_in_game 
(
	player_id int NOT NULL FOREIGN KEY REFERENCES Player (player_id), 
	game_id int NOT NULL FOREIGN KEY REFERENCES Game (game_id),
	start_buget int NOT NULL check(start_buget > 0),
	finish_buget int NOT NULL check(finish_buget >= 0),
	card_combination nvarchar(50) NOT NULL DEFAULT 'Сброс',
	PRIMARY KEY(player_id, game_id)
);

-- Добавление данных в таблицу Transfer_desk
INSERT INTO Transfer_desk (card_number, places)
VALUES 
    (10, 5),
    (25, 3),
    (42, 7);

-- Добавление данных в таблицу Player
INSERT INTO Player (player_name)
VALUES 
    ('Иван Васильев'),
    ('Мария Птрова'),
    ('Александр Семёнов');

-- Добавление данных в таблицу Croupier
INSERT INTO Croupier (croupier_name)
VALUES 
    ('Елена Сергеева'),
    ('Дмитрий Васютин'),
	('Я Крупье');

-- Добавление данных в таблицу Game
INSERT INTO Game (croupier_id, table_id, date_time, best_combination)
VALUES 
    ( '1', '2', '15/06/2023 13:21', 'Стрит флеш'),
    ( '2', '3', '15/06/2023 13:25', 'Ожидает результата'),
    ( '1', '2', '15/06/2023 13:29', 'Фулл хаус');

-- Добавление данных в таблицу Player_in_game
INSERT INTO Player_in_game (player_id, game_id, start_buget, finish_buget, card_combination)
VALUES 
    ( '3', '1', 500, 1200, 'Фулл хаус'),
    ( '1', '2', 700, 900, 'Две пары'),
    ( '2', '3', 1000, 800, 'Сброс');


