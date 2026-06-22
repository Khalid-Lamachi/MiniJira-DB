-- ─────────────────────────────────────────────────────────────────────────
-- Migration : livrable des sous-tâches
-- Ajoute une colonne `lien_livrable` (URL du dépôt GitHub) que le développeur
-- dépose lorsqu'il termine une sous-tâche qui lui est assignée.
-- À exécuter sur une base MiniJira existante.
-- ─────────────────────────────────────────────────────────────────────────
USE MiniJira;

ALTER TABLE tasks
    ADD COLUMN lien_livrable VARCHAR(500) NULL AFTER type_tache;
