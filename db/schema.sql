DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS milestones;
DROP TABLE IF EXISTS goals;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS teams;

CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE teams (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    motto VARCHAR(100)
);

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    team_id INTEGER,
    CONSTRAINT fk_team FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE goals (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    due_date VARCHAR(10),
    is_public BOOLEAN NOT NULL,
    tag_id INTEGER,
    user_id INTEGER,
    team_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tags FOREIGN KEY (tag_id) REFERENCES tags(id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_nteam FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

CREATE TABLE milestones (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    due_date VARCHAR(10),
    is_public BOOLEAN NOT NULL,
    goal_id INTEGER,
    user_id INTEGER,
    CONSTRAINT fk_goal FOREIGN KEY (goal_id) REFERENCES goals(id) ON DELETE CASCADE,
    CONSTRAINT fk_msuser FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE notes (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(50) NOT NULL,
    goal_id INTEGER,
    milestone_id INTEGER,
    CONSTRAINT fk_ngoal FOREIGN KEY (goal_id) REFERENCES goals(id) ON DELETE CASCADE,
    CONSTRAINT fk_nmilestone FOREIGN KEY (milestone_id) REFERENCES milestones(id) ON DELETE CASCADE
);