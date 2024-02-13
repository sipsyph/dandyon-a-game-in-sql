DROP TABLE IF EXISTS player;
CREATE TABLE player (
    id serial PRIMARY key,
    player_icon text,
    coordinates_x integer,
    coordinates_y integer
);
insert into player (id,player_icon,coordinates_x,coordinates_y) values (1,'👤',5,5);

DROP TABLE IF EXISTS game_screen cascade;
CREATE TABLE game_screen (
    y_id serial PRIMARY key,
    x1 TEXT,
    x2 TEXT,
    x3 TEXT,
    x4 TEXT,
    x5 TEXT,
    x6 TEXT,
    x7 TEXT,
    x8 TEXT,
    x9 TEXT,
    x10 text,
    player_hud text
);
INSERT INTO game_screen (y_id, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10)
VALUES 
    (1, '', '', '', '', '', '', '', '', '', ''),
    (2, '', '', '', '', '', '', '', '', '', ''),
    (3, '', '', '', '', '', '', '', '', '', ''),
    (4, '', '', '', '', '', '', '', '', '', ''),
    (5, '', '', '', '', '👤', '', '', '', '', ''),
    (6, '', '', '', '', '', '', '', '', '', ''),
    (7, '', '', '', '', '', '', '', '', '', ''),
    (8, '', '', '', '', '', '', '', '', '', ''),
    (9, '', '', '', '', '', '', '', '', '', ''),
    (10, '', '', '', '', '', '', '', '', '', '');

