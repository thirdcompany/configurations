-- вход в командную строку постгреса
psql

-- создание базы данных
CREATE DATABASE i4p;

--выход с этой записи и перезаход на нужную бд
\q
psql i4p

/** просто вставь 
    это создание перечисления, 
    чтобы роли нормально указывать*/
CREATE TYPE user_role AS ENUM (
    'user',
    'admin',
    'charity'
);


/* Начало создания таблиц */
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    email TEXT UNIQUE,
    rating INT NOT NULL,
    about TEXT,
    role user_role NOT NULL,
    create_at DATE NOT NULL,
    update_at DATE NOT NULL,
    delete_at DATE
);

--RATING - how is this post popular(+ and - of users)
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    header VARCHAR(100) NOT NULL,
    description TEXT NOT NULL UNIQUE,
    publish_time TIMESTAMP NOT NULL,
    dificulty INT NOT NULL,
    rating INT NOT NULL,
    creator_id INT NOT NULL REFERENCES users (id),
    category TEXT NOT NULL
);

CREATE TABLE realisations (
    id SERIAL PRIMARY KEY,
    parent_id INT NOT NULL REFERENCES posts (id),
    link TEXT NOT NULL UNIQUE,
    description TEXT NOT NULL UNIQUE,
    publish_time TIMESTAMP NOT NULL,
    dificulty INT NOT NULL,
    rating INT NOT NULL,
    creator_id INT NOT NULL REFERENCES users (id)
);

-- TRUE - categories; FALSE - technologies
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    type BOOLEAN NOT NULL
);

-- TRUE - categories; FALSE - technologies
CREATE TABLE posts_to_tags (
    post_id INT NOT NULL REFERENCES posts (id),
    tag_id INT NOT NULL REFERENCES tags (id),
    type BOOLEAN NOT NULL
);

-- TRUE - categories; FALSE - technologies
CREATE TABLE realisations_to_tags (
    realisation_id INT NOT NULL REFERENCES posts (id),
    tag_id INT NOT NULL REFERENCES tags (id),
    type BOOLEAN NOT NULL
);

/* Конец создания таблиц

   Начало добавления записей */

--Заполнение таблицы с тэгами

INSERT INTO tags (id, name, type) VALUES (0, 'game', TRUE);
INSERT INTO tags (id, name, type) VALUES (1, 'chatbot', TRUE);
INSERT INTO tags (id, name, type) VALUES (2, 'site_full', TRUE);
INSERT INTO tags (id, name, type) VALUES (3, 'site_backend', TRUE);
INSERT INTO tags (id, name, type) VALUES (4, 'site_frontend', TRUE);
INSERT INTO tags (id, name, type) VALUES (5, 'java', FALSE);
INSERT INTO tags (id, name, type) VALUES (6, 'js', FALSE);
INSERT INTO tags (id, name, type) VALUES (7, 'python', FALSE);
INSERT INTO tags (id, name, type) VALUES (8, 'css', FALSE);
INSERT INTO tags (id, name, type) VALUES (9, 'html', FALSE);
INSERT INTO tags (id, name, type) VALUES (10, 'csharp', FALSE);
INSERT INTO tags (id, name, type) VALUES (11, 'php', FALSE);
INSERT INTO tags (id, name, type) VALUES (12, 'cpp', FALSE);

--Конец 
--Добавление сторонних записей(3 полюзователя(1 удаленный), пост, 2 реализации и их полные связи)

--Добавление пользователей
INSERT INTO users (login, password, username, email, rating, about, role, create_at, update_at, delete_at)
VALUES ('pupptmstr', 'c1f7f43ece8b029764e2efce51044d51', 'pupptmstr', 'payforplay@ya.ru', 0, 'дебилоид, не знаю что написать', 'user', '19-06-13', '19-06-13', NULL);

INSERT INTO users (login, password, username, email, rating, about, role, create_at, update_at, delete_at)
VALUES ('nastypill', 'c1f7f43ece8b029764e2efce51044d51', 'valera228', 'whay@ya.ru', 0, 'дебилоид', 'user', '19-06-13', '19-06-13', NULL);

INSERT INTO users (login, password, username, email, rating, about, role, create_at, update_at, delete_at)
VALUES ('bill', 'c1f7f43ece8b029764e2efce51044d51', 'link', 'suka@ya.ru', 0, 'дебилоид, не знаю', 'user', '19-07-12', '19-07-13', '19-07-13');

--Добавление поста и тегов к нему
INSERT INTO posts (id, header, description, publish_time, dificulty, rating, creator_id, category)
VALUES (0, 'Spring в нашем бэкэнде', 'Это какой-то тотальный пздец', '19-07-13', 0, 0, 0, 'site_backend');

INSERT INTO posts_to_tags (post_id, tag_id, type)
VALUES (0, 3, TRUE);

INSERT INTO posts_to_tags (post_id, tag_id, type)
VALUES (0, 5, FALSE);

--Добавление реализаций и тегов к ним
INSERT INTO realisations (parent_id, link, description, publish_time, dificulty, rating, creator_id)
VALUES (0, 'https://github.com/pupptmstr/authservice', 'в жопу спринг, юзанул ктор', '19-07-13', 0, 0, 3);

INSERT INTO realisations_to_tags (post_id, tag_id, type)
VALUES (0, 5, FALSE);

INSERT INTO realisations (parent_id, link, description, publish_time, dificulty, rating, creator_id)
VALUES (0, 'https://github.com/pupptmstr/welcomehabr', 'а вот я спринг заюзать попробую', '19-07-2013', 0, 0, 3);

INSERT INTO category_site_backend VALUES (2, FALSE);
INSERT INTO technology_java VALUES (2, FALSE);