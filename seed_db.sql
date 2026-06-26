SET NAMES utf8mb4;
USE MiniJira;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE task_activities;
TRUNCATE TABLE commentaires;
TRUNCATE TABLE appartenance_equipe;
TRUNCATE TABLE tasks;
TRUNCATE TABLE sprints;
TRUNCATE TABLE projects;
TRUNCATE TABLE equipes;
TRUNCATE TABLE utilisateurs;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- USERS (Famous Physicists & Computer Scientists, now Software Engineers)
-- Password is 'password123' for everyone to simplify the live demo.
-- =====================================================================
INSERT INTO utilisateurs (id, nom, prenom, login, email, password, experiences, date_creation_compte, type_utilisateur) VALUES
(1,  'Foudil',     'Yasser', 'FouYas1234abcd',     'yasser@demo.com',     'password123', 'dev,scrum',        '2026-05-01', 'MEMBRE'),
(2,  'Einstein',    'Albert',      'EinAlb2345bcde',    'einstein@physics.org',    'password123', 'dev,designer',         '2026-05-01', 'MEMBRE'),
(3,  'Curie',       'Marie',       'CurMar3456cdef',       'curie@physics.org',       'password123', 'dev',            '2026-05-01', 'MEMBRE'),
(4,  'Feynman',     'Richard',     'FeyRic4567def0',     'feynman@physics.org',     'password123', 'dev,designer',         '2026-05-02', 'MEMBRE'),
(5,  'Bohr',        'Niels',       'BohNie5678ef01',        'bohr@physics.org',        'password123', 'dev,scrum',             '2026-05-02', 'MEMBRE'),
(6,  'Schrodinger', 'Erwin',       'SchErw6789f012', 'schrodinger@physics.org', 'password123', 'tester,po',        '2026-05-02', 'MEMBRE'),
(7,  'Newton',      'Isaac',       'NewIsa78900123',      'newton@physics.org',      'password123', 'dev',               '2026-05-05', 'MEMBRE'),
(8,  'Tesla',       'Nikola',      'TesNik89011234',       'tesla@physics.org',       'password123', 'dev',     '2026-05-05', 'MEMBRE'),
(9,  'Lovelace',    'Ada',         'LovAda90122345',    'lovelace@cs.org',         'password123', 'dev',               '2026-05-07', 'MEMBRE'),
(10, 'Turing',      'Alan',        'TurAla01233456',      'turing@cs.org',           'password123', 'dev,tester',   '2026-05-07', 'MEMBRE'),
(11, 'Hopper',      'Grace',       'HopGra12344567',      'hopper@cs.org',           'password123', 'tester',          '2026-05-09', 'MEMBRE'),
(12, 'Planck',      'Max',         'PlaMax23455678',      'planck@physics.org',      'password123', 'po', '2026-05-09', 'MEMBRE');

-- =====================================================================
-- TEAMS
-- =====================================================================
INSERT INTO equipes (id, nom, objectif, isArchived, idCreateur, dateCreation) VALUES
(1, 'Core Platform Team',    'Building the main React and Jakarta EE architecture',           0, 2, '2026-05-03 09:00:00'),
(2, 'Data & Analytics Team', 'Developing the reporting and dashboard modules',                0, 3, '2026-05-03 09:30:00'),
(3, 'Mobile & DevOps Team',  'Delivering the mobile companion app and the CI/CD pipeline',    0, 8, '2026-05-06 10:00:00'),
(4, 'Security & QA Guild',   'Hardening authentication and owning the quality gate',          0, 10, '2026-05-08 11:00:00'),
(5, 'Legacy Migration Team', 'Archived team that handled the initial monolith decomposition', 1, 2, '2026-04-01 08:00:00');

-- =====================================================================
-- TEAM MEMBERSHIPS
-- =====================================================================
INSERT INTO appartenance_equipe (id_equipe, id_utilisateur) VALUES
-- Core Platform Team
(1, 2),  -- Einstein (Admin/Architect)
(1, 1),  -- Foudil (Backend)
(1, 4),  -- Feynman (Frontend)
(1, 5),  -- Bohr (DevOps/SM)
(1, 6),  -- Schrodinger (QA/PO)
(1, 9),  -- Lovelace (Backend)
-- Data & Analytics Team
(2, 3),  -- Curie (Data/Admin)
(2, 1),  -- Foudil (Backend crossover)
(2, 6),  -- Schrodinger (Product crossover)
(2, 7),  -- Newton (Algorithms)
(2, 12), -- Planck (PO)
-- Mobile & DevOps Team
(3, 8),  -- Tesla (Infra/Admin)
(3, 5),  -- Bohr (DevOps crossover)
(3, 4),  -- Feynman (Frontend crossover)
(3, 9),  -- Lovelace (Backend crossover)
-- Security & QA Guild
(4, 10), -- Turing (Security/Admin)
(4, 11), -- Hopper (QA)
(4, 6),  -- Schrodinger (QA crossover)
(4, 1);  -- Foudil (Backend crossover)

-- =====================================================================
-- PROJECTS (varied SM/PO roles to demonstrate RBAC)
--  P1: Admin Einstein, SM Bohr,    PO Schrodinger
--  P2: Admin Curie,    SM Foudil, PO Planck
--  P3: Admin Tesla,    SM Bohr,    PO Feynman
--  P4: Admin Turing,   SM Hopper,  PO Schrodinger
-- =====================================================================
INSERT INTO projects (id_project, nom_projet, cle, etats, date_creation, idCreateur, isArchived, idTeam, idSM, idPO) VALUES
(1, 'Mini-Jira Refactoring',  'CORE', 'À faire,En cours,En Revue,Terminé',     '2026-05-04 12:00:00', 2,  0, 1, 5, 6),
(2, 'Metrics Dashboard V1',   'DATA', 'Backlog,In Progress,Testing,Released',  '2026-05-04 12:30:00', 3,  0, 2, 1, 12),
(3, 'Mobile Companion App',   'MOB',  'À faire,En cours,En Revue,Terminé',     '2026-05-06 14:00:00', 8,  0, 3, 5, 4),
(4, 'Security Hardening',     'SEC',  'Backlog,In Progress,Testing,Released',  '2026-05-08 15:00:00', 10, 0, 4, 11, 6),
(5, 'Monolith Decommission',  'OLD',  'À faire,En cours,Terminé',              '2026-04-02 09:00:00', 2,  1, 5, 2, 6);

-- =====================================================================
-- SPRINTS (varied status: terminee / actif / a venir)
-- =====================================================================
INSERT INTO sprints (id_sprint, nom_sprint, objectif, date_debut, date_fin, statut, capacite, id_project) VALUES
-- Project 1 (CORE)
(1, 'Sprint 0 - Setup',                  'Database schema design and repo initialization',         '2026-05-04', '2026-05-17', 'terminee', 20, 1),
(2, 'Sprint 1 - Authentication & Security','Implement JWT and secure the Tomcat Servlets',         '2026-05-18', '2026-05-31', 'terminee', 30, 1),
(3, 'Sprint 2 - Kanban Board',           'Implement Drag and Drop with React Beautiful DnD',       '2026-06-15', '2026-06-28', 'actif',    28, 1),
(4, 'Sprint 3 - Polish & Releases',      'Accessibility, dark mode and release packaging',         '2026-06-29', '2026-07-12', 'a venir',  25, 1),
-- Project 2 (DATA)
(5, 'Sprint 1 - Data Aggregation',       'Write SQL queries for workload and distribution',        '2026-06-15', '2026-06-28', 'actif',    18, 2),
(6, 'Sprint 2 - UI Visualizations',      'Build native CSS charts without external libraries',     '2026-06-29', '2026-07-12', 'a venir',  22, 2),
(7, 'Sprint 0 - Data Modeling',          'Define the reporting schema and aggregation strategy',   '2026-05-18', '2026-05-31', 'terminee', 16, 2),
-- Project 3 (MOB)
(8, 'Sprint 1 - App Shell',              'Set up navigation, theming and the project skeleton',    '2026-06-15', '2026-06-28', 'actif',    24, 3),
(9, 'Sprint 2 - Offline Mode',           'Cache tasks locally and sync when back online',          '2026-06-29', '2026-07-12', 'a venir',  20, 3),
-- Project 4 (SEC)
(10,'Sprint 1 - Threat Modeling',        'Audit the existing servlets and document attack surface','2026-06-15', '2026-06-28', 'actif',    15, 4),
(11,'Sprint 2 - Hardening',              'Apply fixes for the discovered vulnerabilities',         '2026-06-29', '2026-07-12', 'a venir',  18, 4);

-- =====================================================================
-- TASKS
-- 'statut' MUST exactly match the 'etats' configured on the project.
--   P1 & P3 use: À faire, En cours, En Revue, Terminé
--   P2 & P4 use: Backlog, In Progress, Testing, Released
-- =====================================================================
INSERT INTO tasks (id_task, titre, description, statut, priorite, story_points, date_creation, id_project, id_sprint, id_assignee, type_tache) VALUES
-- ---------------------------------------------------------------------
-- PROJECT 1 (CORE)
-- ---------------------------------------------------------------------
-- Sprint 0 (terminee) - everything done
(1,  'Initialize Git repository',           'Set up the mono-repo with backend and frontend folders',        'Terminé', 'medium', 3,  '2026-05-04 09:00:00', 1, 1, 2, 'Tech'),
(2,  'Design the relational schema',        'Model users, teams, projects, sprints and tasks',               'Terminé', 'high',   8,  '2026-05-05 09:00:00', 1, 1, 2, 'Tech'),
(3,  'Configure Tomcat & Maven build',      'Wire up the embedded Tomcat runner and the WAR packaging',      'Terminé', 'medium', 5,  '2026-05-06 09:00:00', 1, 1, 5, 'Tech'),
-- Sprint 1 (terminee) - shipped auth
(4,  'Implement JWT Token Generation',      'Create the AuthUser servlet logic to issue stateless tokens',   'Terminé', 'critical', 8, '2026-05-18 09:00:00', 1, 2, 1, 'Feature'),
(5,  'Refactor TaskDAO with PreparedStatement','Prevent SQL injection vulnerabilities in the delete route',  'Terminé', 'high',   5,  '2026-05-19 09:00:00', 1, 2, 9, 'Tech'),
(6,  'Build Login React Component',         'Create the UI form with email, password and error handling',    'Terminé', 'medium', 5,  '2026-05-20 09:00:00', 1, 2, 4, 'Feature'),
(7,  'Add RBAC guard on protected routes',  'Restrict SM/PO only endpoints based on the project roles',      'Terminé', 'high',   8,  '2026-05-22 09:00:00', 1, 2, 1, 'Feature'),
-- Sprint 2 (actif) - in flight
(8,  'Setup React Beautiful DnD',           'Wrap the Kanban columns in Droppable contexts',                 'Terminé', 'high',   13, '2026-06-01 09:00:00', 1, 3, 4, 'Feature'),
(9,  'Persist task position on drop',       'Send the new ordering to the backend and update positions',     'En cours', 'high',  8,  '2026-06-02 09:00:00', 1, 3, 1, 'Feature'),
(10, 'Fix CORS issue on Tomcat',            'React Axios requests are being blocked by browser CORS policy', 'En cours', 'high',  3,  '2026-06-03 09:00:00', 1, 3, 9, 'Bug'),
(11, 'Memory leak in useEffect',            'Board component re-renders infinitely when fetching tasks',     'En Revue', 'critical', 8,'2026-06-04 09:00:00', 1, 3, 4, 'Bug'),
(12, 'Add comment thread on task modal',    'Let team members discuss directly on a task card',              'À faire', 'medium', 5,  '2026-06-05 09:00:00', 1, 3, 6, 'Feature'),
(13, 'Optimistic UI for status change',     'Reflect the column move instantly before the API confirms',     'À faire', 'low',    3,  '2026-06-06 09:00:00', 1, 3, 4, 'Feature'),
-- Sprint 3 (a venir)
(14, 'Build release packaging script',      'Produce a versioned WAR and tag the release in Git',            'À faire', 'medium', 5,  '2026-06-07 09:00:00', 1, 4, 5, 'Tech'),
(15, 'Keyboard navigation for the board',   'Allow moving cards with arrow keys for accessibility',          'À faire', 'medium', 8,  '2026-06-07 09:30:00', 1, 4, NULL, 'Feature'),
-- Backlog (no sprint)
(16, 'Add Dark Mode Toggle',                'Implement CSS variables for dark theme support',                'À faire', 'low',    2,  '2026-06-08 09:00:00', 1, NULL, NULL, 'Feature'),
(17, 'Migrate from CRA to Vite',            'Improve local development server boot time',                    'À faire', 'medium', 5,  '2026-06-08 09:30:00', 1, NULL, NULL, 'Tech'),
(18, 'Email notifications on assignment',   'Notify a user when a task is assigned to them',                 'À faire', 'low',    8,  '2026-06-09 09:00:00', 1, NULL, NULL, 'Feature'),

-- ---------------------------------------------------------------------
-- PROJECT 2 (DATA)
-- ---------------------------------------------------------------------
-- Sprint 0 (terminee)
(19, 'Define reporting schema',             'Decide which metrics to aggregate and how to store them',       'Released', 'high',  5,  '2026-05-18 09:00:00', 2, 7, 3, 'Tech'),
(20, 'Seed sample analytics data',          'Create realistic fixtures to validate the queries',             'Released', 'medium',3,  '2026-05-20 09:00:00', 2, 7, 7, 'Tech'),
-- Sprint 1 (actif)
(21, 'Write SQL GROUP BY for Workload',     'Aggregate story points assigned to each user ID',               'In Progress', 'high', 5, '2026-06-01 09:00:00', 2, 5, 7, 'Feature'),
(22, 'Build JSON response wrapper',         'Format the aggregated SQL data into a single JSON object',      'Testing', 'medium', 3,  '2026-06-02 09:00:00', 2, 5, 1, 'Tech'),
(23, 'NullPointerException in Metrics Route','Backend crashes if a sprint has zero tasks assigned',          'In Progress', 'critical', 2, '2026-06-03 09:00:00', 2, 5, 1, 'Bug'),
(24, 'Sprint burndown calculation',         'Compute remaining story points per day across the sprint',      'Backlog', 'high',   8,  '2026-06-04 09:00:00', 2, 5, 7, 'Feature'),
-- Sprint 2 (a venir)
(25, 'Native CSS bar chart component',      'Render workload distribution without external chart libraries', 'Backlog', 'medium', 8,  '2026-06-05 09:00:00', 2, 6, 4, 'Feature'),
(26, 'Velocity trend line',                 'Show team velocity over the last sprints',                      'Backlog', 'low',    5,  '2026-06-06 09:00:00', 2, 6, NULL, 'Feature'),
-- Backlog
(27, 'Export Dashboard to PDF',             'Allow SM to download the sprint report as a document',          'Backlog', 'low',    8,  '2026-06-07 09:00:00', 2, NULL, NULL, 'Feature'),
(28, 'Cache aggregation results',           'Avoid recomputing heavy queries on every dashboard load',       'Backlog', 'medium', 5,  '2026-06-08 09:00:00', 2, NULL, NULL, 'Tech'),

-- ---------------------------------------------------------------------
-- PROJECT 3 (MOB)
-- ---------------------------------------------------------------------
-- Sprint 1 (actif)
(29, 'Scaffold mobile app project',         'Initialize the React Native workspace and shared config',       'Terminé', 'high',   5,  '2026-06-01 09:00:00', 3, 8, 8, 'Tech'),
(30, 'Implement bottom tab navigation',     'Boards, Backlog and Profile tabs with icons',                   'En cours', 'medium', 5, '2026-06-02 09:00:00', 3, 8, 4, 'Feature'),
(31, 'Reuse auth token from web login',     'Securely store the JWT in the device keychain',                 'En cours', 'high',   8,  '2026-06-03 09:00:00', 3, 8, 9, 'Feature'),
(32, 'White screen on cold start',          'App crashes when launched without a network connection',        'À faire', 'critical', 3, '2026-06-04 09:00:00', 3, 8, 5, 'Bug'),
-- Sprint 2 (a venir)
(33, 'Local cache with SQLite',             'Persist the last fetched tasks for offline reading',            'À faire', 'high',   13, '2026-06-05 09:00:00', 3, 9, 9, 'Feature'),
(34, 'Background sync queue',               'Replay offline edits once the connection is restored',          'À faire', 'high',   8,  '2026-06-06 09:00:00', 3, 9, NULL, 'Feature'),
-- Backlog
(35, 'Push notifications',                  'Notify users of mentions and assignments on mobile',            'À faire', 'low',    8,  '2026-06-07 09:00:00', 3, NULL, NULL, 'Feature'),

-- ---------------------------------------------------------------------
-- PROJECT 4 (SEC)
-- ---------------------------------------------------------------------
-- Sprint 1 (actif)
(36, 'Audit all servlet endpoints',         'List every route and its current authorization checks',         'Testing', 'high',   5,  '2026-06-01 09:00:00', 4, 10, 10, 'Tech'),
(37, 'Document attack surface',             'Produce a threat model diagram for the auth flow',              'In Progress', 'medium', 5, '2026-06-02 09:00:00', 4, 10, 10, 'Tech'),
(38, 'Plaintext passwords in DB',           'Passwords are stored without hashing - must use BCrypt',        'In Progress', 'critical', 8, '2026-06-03 09:00:00', 4, 10, 1, 'Bug'),
-- Sprint 2 (a venir)
(39, 'Add rate limiting on login',          'Throttle repeated failed login attempts per IP',                'Backlog', 'high',   5,  '2026-06-05 09:00:00', 4, 11, 10, 'Feature'),
(40, 'Rotate and shorten JWT lifetime',     'Introduce refresh tokens and a 15 minute access token',         'Backlog', 'high',   8,  '2026-06-06 09:00:00', 4, 11, NULL, 'Feature'),
-- Backlog
(41, 'Security headers middleware',         'Add HSTS, X-Frame-Options and CSP to every response',           'Backlog', 'medium', 5,  '2026-06-07 09:00:00', 4, NULL, NULL, 'Tech');

-- =====================================================================
-- EPICS (containers) and the hierarchy linking child tasks to them
-- =====================================================================
INSERT INTO tasks (id_task, titre, description, statut, priorite, story_points, estimated_hours, logged_hours, date_creation, id_project, id_sprint, id_assignee, type_tache, id_parent) VALUES
(42, 'Epic: Refonte Globale de la Sécurité', 'Regroupement des tâches liées à l''authentification JWT et la protection des routes.', 'En cours',    'critical', NULL, NULL, NULL, '2026-05-17 09:00:00', 1, NULL, NULL, 'Epic', NULL),
(43, 'Epic: Tableau Kanban Interactif',      'Toutes les tâches du board drag-and-drop et de son ergonomie.',                        'En cours',    'high',     NULL, NULL, NULL, '2026-05-30 09:00:00', 1, NULL, NULL, 'Epic', NULL),
(44, 'Epic: Reporting & Dashboards',         'Agrégation des données et visualisations natives pour le suivi agile.',                'In Progress', 'high',     NULL, NULL, NULL, '2026-05-17 09:00:00', 2, NULL, NULL, 'Epic', NULL),
(45, 'Epic: Application Mobile Compagnon',   'Livraison de l''app mobile et du mode hors-ligne.',                                    'En cours',    'medium',   NULL, NULL, NULL, '2026-05-31 09:00:00', 3, NULL, NULL, 'Epic', NULL),
(46, 'Design JWT payload and expiration',    'Define the standard claims (sub, exp, role) for the tokens.',                          'Terminé',     'high',     NULL, 4, 4, '2026-05-18 10:00:00', 1, 3,    1,    'Sous-tache', 9),
(47, 'Implement JJWT library integration',   'Add dependency and create utility class for token signing.',                           'Terminé',     'critical', NULL, 6, 6, '2026-05-18 11:00:00', 1, 3,    1,    'Sous-tache', 9),
(48, 'Create AuthFilter for requests',       'Intercept incoming API calls and validate the Bearer token.',                          'En cours',    'high',     NULL, 8, 4, '2026-05-19 09:00:00', 1, 3,    1,    'Sous-tache', 9);

-- Link existing tasks to their Epic to build the Epic -> Story hierarchy
UPDATE tasks SET id_parent = 42 WHERE id_task IN (4, 5, 6, 7);   -- Security epic (P1)
UPDATE tasks SET id_parent = 43 WHERE id_task IN (8, 9, 11, 13); -- Kanban epic (P1)
UPDATE tasks SET id_parent = 44 WHERE id_task IN (21, 22, 24, 25, 26); -- Reporting epic (P2)
UPDATE tasks SET id_parent = 45 WHERE id_task IN (29, 30, 31, 33, 34); -- Mobile epic (P3)

-- Deliverable links (GitHub PRs) for completed sub-tasks
UPDATE tasks SET lien_livrable = 'https://github.com/mini-jira/core/pull/12' WHERE id_task = 4;
UPDATE tasks SET lien_livrable = 'https://github.com/mini-jira/core/pull/15' WHERE id_task = 5;
UPDATE tasks SET lien_livrable = 'https://github.com/mini-jira/core/pull/21' WHERE id_task = 8;
UPDATE tasks SET lien_livrable = 'https://github.com/mini-jira/data/pull/7'  WHERE id_task = 19;
UPDATE tasks SET lien_livrable = 'https://github.com/mini-jira/mobile/pull/3' WHERE id_task = 29;

-- =====================================================================
-- POSITION: 0-based ordering within each (project, sprint-or-backlog) group
-- =====================================================================
UPDATE tasks t
JOIN (
    SELECT id_task,
           ROW_NUMBER() OVER (
               PARTITION BY id_project, COALESCE(id_sprint, 0)
               ORDER BY id_task
           ) - 1 AS rn
    FROM tasks
) ordered ON t.id_task = ordered.id_task
SET t.position = ordered.rn;

-- =====================================================================
-- COMMENTS (team discussions on tasks)
-- =====================================================================
INSERT INTO commentaires (id_task, id_auteur, contenu, date_creation) VALUES
-- Task 4 - JWT (Foudil), questioned by Schrodinger (PO)
(4, 6, 'Foudil, as-tu pu vérifier comment Tomcat gère l''expiration du token lors d''une requête longue ?', '2026-05-19 10:00:00'),
(4, 1, 'Oui, j''ai configuré un filtre de servlet (Filter) pour intercepter et renvoyer une erreur 401. Le front React gère la redirection.', '2026-05-19 14:30:00'),
(4, 2, 'Parfait, on valide. Pense à documenter le format du payload dans le wiki.', '2026-05-20 09:15:00'),
-- Task 10 - CORS (Lovelace/Feynman)
(10, 4, 'J''ai trouvé la source du blocage CORS. Il manquait l''en-tête Access-Control-Allow-Credentials dans doOptions().', '2026-06-03 11:00:00'),
(10, 2, 'Excellente trouvaille. Peux-tu pousser cette modification sur develop avant midi ?', '2026-06-03 11:45:00'),
(10, 9, 'Fait. Je teste avec le front de Feynman et je ferme la tâche si tout passe.', '2026-06-03 15:20:00'),
-- Task 11 - memory leak (Feynman)
(11, 5, 'Le re-render infini vient probablement d''une dépendance manquante dans le tableau du useEffect.', '2026-06-04 13:00:00'),
(11, 4, 'Confirmé. J''ajoute un cleanup et je mémoïse le fetch. En revue maintenant.', '2026-06-04 16:40:00'),
-- Task 9 - position persistence (Foudil)
(9, 6, 'On garde bien une position 0-based par colonne ? Sinon le tri va casser après un refresh.', '2026-06-05 09:30:00'),
(9, 1, 'Oui, je recalcule les positions côté backend à chaque drop pour rester cohérent.', '2026-06-05 10:10:00'),
-- Task 17 - backlog (Vite migration), Bohr
(17, 5, 'Nous devrions repousser cette tâche au Sprint 3. La priorité reste la finalisation du Kanban Board.', '2026-06-08 10:00:00'),
-- Task 23 - NPE in metrics (P2)
(23, 12, 'Ce crash bloque toute la démo du dashboard. À traiter en priorité.', '2026-06-03 10:30:00'),
(23, 1, 'Ajout d''un garde sur la liste vide + test unitaire. Je passe en Testing.', '2026-06-03 14:00:00'),
-- Task 38 - plaintext passwords (SEC)
(38, 10, 'Critique : les mots de passe sont en clair. On migre vers BCrypt avec un script de rétro-hash.', '2026-06-03 09:30:00'),
(38, 11, 'Je prépare les tests pour vérifier qu''aucun mot de passe en clair ne subsiste après migration.', '2026-06-03 11:00:00'),
-- Task 32 - mobile cold start crash
(32, 8, 'Le crash arrive uniquement sans réseau. Il faut un écran de repli quand l''API est injoignable.', '2026-06-04 10:00:00'),
(32, 4, 'Je m''en occupe dès que la navigation par onglets est mergée.', '2026-06-04 12:00:00');

-- =====================================================================
-- TASK ACTIVITIES (audit trail to populate the activity feed)
-- =====================================================================
INSERT INTO task_activities (id_task, id_project, id_user, action_type, old_value, new_value, date_creation) VALUES
-- Task 4 lifecycle
(4, 1, 2, 'CREATE',          NULL,          'Implement JWT Token Generation', '2026-05-18 09:00:00'),
(4, 1, 1, 'ASSIGN',          NULL,          'Foudil',                        '2026-05-18 09:05:00'),
(4, 1, 1, 'STATUS_CHANGE',   'À faire',      'En cours',                       '2026-05-18 10:00:00'),
(4, 1, 1, 'STATUS_CHANGE',   'En cours',     'En Revue',                       '2026-05-21 16:00:00'),
(4, 1, 2, 'STATUS_CHANGE',   'En Revue',     'Terminé',                        '2026-05-22 09:30:00'),
-- Task 9 in progress
(9, 1, 5, 'CREATE',          NULL,          'Persist task position on drop',  '2026-06-02 09:00:00'),
(9, 1, 1, 'ASSIGN',          NULL,          'Foudil',                        '2026-06-02 09:10:00'),
(9, 1, 1, 'STATUS_CHANGE',   'À faire',      'En cours',                       '2026-06-02 11:00:00'),
(9, 1, 1, 'PRIORITY_CHANGE', 'medium',       'high',                           '2026-06-04 09:00:00'),
-- Task 11 bug
(11, 1, 4, 'CREATE',         NULL,          'Memory leak in useEffect',       '2026-06-04 09:00:00'),
(11, 1, 4, 'STATUS_CHANGE',  'À faire',      'En cours',                       '2026-06-04 13:30:00'),
(11, 1, 4, 'STATUS_CHANGE',  'En cours',     'En Revue',                       '2026-06-04 16:40:00'),
-- Task 21 (P2)
(21, 2, 1, 'CREATE',         NULL,          'Write SQL GROUP BY for Workload','2026-06-01 09:00:00'),
(21, 2, 7, 'STATUS_CHANGE',  'Backlog',      'In Progress',                    '2026-06-01 13:00:00'),
(21, 2, 1, 'SPRINT_CHANGE',  NULL,          'Sprint 1 - Data Aggregation',    '2026-06-01 09:05:00'),
-- Task 23 critical bug (P2)
(23, 2, 1, 'CREATE',         NULL,          'NullPointerException in Metrics Route', '2026-06-03 09:00:00'),
(23, 2, 12,'PRIORITY_CHANGE','high',         'critical',                       '2026-06-03 10:30:00'),
(23, 2, 1, 'STATUS_CHANGE',  'Backlog',      'In Progress',                    '2026-06-03 11:00:00'),
-- Task 38 (SEC)
(38, 4, 10,'CREATE',         NULL,          'Plaintext passwords in DB',      '2026-06-03 09:00:00'),
(38, 4, 1, 'ASSIGN',         NULL,          'Foudil',                        '2026-06-03 09:30:00'),
(38, 4, 1, 'STATUS_CHANGE',  'Backlog',      'In Progress',                    '2026-06-03 14:00:00'),
-- Task 29 done (P3)
(29, 3, 8, 'CREATE',         NULL,          'Scaffold mobile app project',    '2026-06-01 09:00:00'),
(29, 3, 8, 'STATUS_CHANGE',  'À faire',      'En cours',                       '2026-06-01 10:00:00'),
(29, 3, 8, 'STATUS_CHANGE',  'En cours',     'Terminé',                        '2026-06-02 15:00:00');

-- =====================================================================
-- Keep AUTO_INCREMENT counters above the explicit IDs we inserted,
-- so new records created during the demo don't collide.
-- =====================================================================
ALTER TABLE utilisateurs   AUTO_INCREMENT = 13;
ALTER TABLE equipes        AUTO_INCREMENT = 6;
ALTER TABLE projects       AUTO_INCREMENT = 6;
ALTER TABLE sprints        AUTO_INCREMENT = 12;
ALTER TABLE tasks          AUTO_INCREMENT = 49;
