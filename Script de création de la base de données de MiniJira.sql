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
    objectif TEXT,
    isArchived TINYINT(1) DEFAULT 0,
    idCreateur INT NOT NULL,
    dateCreation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_equipe_createur
        FOREIGN KEY (idCreateur)
        REFERENCES utilisateurs(id)
);

CREATE TABLE appartenance_equipe (
    id_equipe INT,
    id_utilisateur INT,
    PRIMARY KEY(id_equipe, id_utilisateur),
    FOREIGN KEY(id_equipe) REFERENCES equipes(id) ON DELETE CASCADE,
    FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id) ON DELETE CASCADE
);

CREATE TABLE projects (
    id_project INT AUTO_INCREMENT PRIMARY KEY,
    nom_projet VARCHAR(100) NOT NULL,
    cle VARCHAR(20) NOT NULL UNIQUE,
    etats TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idCreateur INT NOT NULL,
    idTeam INT,
    idSM INT,
    idPO INT,
    FOREIGN KEY (idCreateur) REFERENCES utilisateurs(id),
    FOREIGN KEY (idTeam) REFERENCES equipes(id),
    FOREIGN KEY (idSM) REFERENCES utilisateurs(id),
    FOREIGN KEY (idPO) REFERENCES utilisateurs(id)
);

select * from utilisateurs;
select * from equipes;
select * from appartenance_equipe;
select * from projects;

