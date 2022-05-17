-- testdbデータベース作成
CREATE DATABASE IF NOT EXISTS testdb;
use testdb;

-- 古いテーブルをリセット
DROP TABLE IF EXISTS blogs, users, likes;

-- 投稿を格納するテーブル
CREATE TABLE IF NOT EXISTS blogs(
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title varchar(30) NOT NULL,
  content text NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  user_id int NOT NULL
);

-- アカウント情報を格納するテーブル
CREATE TABLE IF NOT EXISTS users(
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username varchar(30) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- お気に入りしたユーザーとブログIDを紐づけるテーブル
CREATE TABLE IF NOT EXISTS likes(
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id int NOT NULL,
  blog_id int NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY (user_id, blog_id),
  KEY (user_id),
  KEY (blog_id)
);

INSERT INTO users
(username)
VALUES
('hasegwa'),
('tanaka'),
('matsumoto');

INSERT INTO blogs
(title, content, user_id)
VALUES
('pythonについて', 'pythonはデータ分析が得意', 2),
('GOについて', 'GOは処理が早い', 2),
('TypeScriptについて', 'TSは静的にJSをかける', 1);

-- user_id:1 さんが 記事id(blog_id):1をいいねした
INSERT INTO likes
  (blog_id,user_id) VALUES (1,1);

-- user_id:2 さんが 記事id(blog_id):1をいいねした
INSERT INTO likes
  (blog_id,user_id) VALUES (1,2);

-- user_id:3 さんが 記事id(blog_id):2をいいねした
INSERT INTO likes
  (blog_id,user_id) VALUES (2,3);

SELECT lk.blog_id, COUNT(lk.id) as cnt
FROM likes as lk
GROUP BY lk.blog_id;