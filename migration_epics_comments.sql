-- ─────────────────────────────────────────────────────────────────────────
-- Migration : hiérarchie Epic/Story/Subtask + commentaires
-- À exécuter sur une base MiniJira existante (idempotent autant que possible).
-- ─────────────────────────────────────────────────────────────────────────
USE MiniJira;

-- 1. Colonne de hiérarchie sur tasks (auto-référence)
ALTER TABLE tasks
    ADD COLUMN id_parent INT NULL AFTER id_assignee;

ALTER TABLE tasks
    ADD CONSTRAINT fk_task_parent
    FOREIGN KEY (id_parent) REFERENCES tasks(id_task) ON DELETE SET NULL;

-- 2. Table des commentaires
CREATE TABLE IF NOT EXISTS commentaires (
    id_commentaire INT AUTO_INCREMENT PRIMARY KEY,
    id_task INT NOT NULL,
    id_auteur INT,
    contenu TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_task) REFERENCES tasks(id_task) ON DELETE CASCADE,
    FOREIGN KEY (id_auteur) REFERENCES utilisateurs(id) ON DELETE SET NULL
);
