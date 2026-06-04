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
    isArchived TINYINT(1) NOT NULL DEFAULT 0,
    idTeam INT,
    idSM INT,
    idPO INT,
    FOREIGN KEY (idCreateur) REFERENCES utilisateurs(id) ON DELETE CASCADE,
    FOREIGN KEY (idTeam) REFERENCES equipes(id),
    FOREIGN KEY (idSM) REFERENCES utilisateurs(id),
    FOREIGN KEY (idPO) REFERENCES utilisateurs(id)
);



CREATE TABLE sprints (
    id_sprint INT AUTO_INCREMENT PRIMARY KEY,
    nom_sprint VARCHAR(100) NOT NULL,
    objectif TEXT,
    date_debut DATE,
    date_fin DATE,
    statut VARCHAR(20) DEFAULT 'a venir',
    id_project INT NOT NULL,
    FOREIGN KEY (id_project) REFERENCES projects(id_project) ON DELETE CASCADE
);

CREATE TABLE tasks (
    id_task INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(150) NOT NULL,
    description TEXT,
    statut VARCHAR(50),
    priorite VARCHAR(20),
    story_points INT DEFAULT 0,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_project INT NOT NULL,
    id_sprint INT,
    id_assignee INT,
    type_tache VARCHAR(50) DEFAULT 'Feature',
    FOREIGN KEY (id_project) REFERENCES projects(id_project) ON DELETE CASCADE,
    FOREIGN KEY (id_sprint) REFERENCES sprints(id_sprint) ON DELETE SET NULL,
    FOREIGN KEY (id_assignee) REFERENCES utilisateurs(id) ON DELETE SET NULL
);


select * from utilisateurs;
select * from equipes;
select * from appartenance_equipe;
select * from projects;









