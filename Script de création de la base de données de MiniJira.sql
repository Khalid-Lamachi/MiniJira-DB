create database MiniJira;
use MiniJira;

CREATE TABLE utilisateurs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    experiences VARCHAR(255),
    date_creation_compte DATE,
    type_utilisateur VARCHAR(50)
);

CREATE TABLE equipes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    objectif TEXT
);

CREATE TABLE appartenance_equipe (
    id_equipe INT,
    id_utilisateur INT,
    PRIMARY KEY(id_equipe, id_utilisateur),
    FOREIGN KEY(id_equipe) REFERENCES equipes(id),
    FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id)
);

select * from utilisateurs;