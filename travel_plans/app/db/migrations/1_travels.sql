-- +micrate Up
CREATE TABLE travels (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY
);


-- +micrate Down
DROP TABLE IF EXISTS travels;