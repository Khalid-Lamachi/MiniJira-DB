-- ─────────────────────────────────────────────────────────────────────────
-- Migration : capacité des sprints
-- Ajoute une colonne `capacite` (en points) modifiable par le Scrum Master.
-- À exécuter sur une base MiniJira existante.
-- ─────────────────────────────────────────────────────────────────────────
USE MiniJira;

ALTER TABLE sprints
    ADD COLUMN capacite INT NULL AFTER statut;
