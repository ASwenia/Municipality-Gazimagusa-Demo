CREATE SEQUENCE blogs_seq 
    START WITH 1 
    INCREMENT BY 1;

CREATE TABLE Citizens ( 
    C_id INT PRIMARY KEY, 
    Name VARCHAR(20) NOT NULL 
);

CREATE TABLE Blogs ( 
    B_id INT PRIMARY KEY, 
    C_id INT NOT NULL, 
    B_title VARCHAR(20) NOT NULL, 
    B_Body VARCHAR(255) NOT NULL, 
    FOREIGN KEY (C_id) REFERENCES Citizens(C_id) 
);

CREATE OR REPLACE TRIGGER blogs_trigger 
BEFORE INSERT ON Blogs 
FOR EACH ROW 
BEGIN 
    SELECT blogs_seq.NEXTVAL 
    INTO :new.B_id 
    FROM dual; 
END; 
/

CREATE SEQUENCE replies_seq 
    START WITH 1 
    INCREMENT BY 1;

CREATE TABLE Replies ( 
    R_id INT PRIMARY KEY, 
    B_id INT NOT NULL, 
    C_id INT NOT NULL, 
    Reply VARCHAR(255) NOT NULL, 
    FOREIGN KEY (B_id) REFERENCES Blogs(B_id), 
    FOREIGN KEY (C_id) REFERENCES Citizens(C_id) 
);

CREATE OR REPLACE TRIGGER replies_trigger 
BEFORE INSERT ON Replies 
FOR EACH ROW 
BEGIN 
    SELECT replies_seq.NEXTVAL 
    INTO :new.R_id 
    FROM dual; 
END; 
/

INSERT INTO Citizens (C_id, Name) VALUES (1, 'Alice');

INSERT INTO Citizens (C_id, Name) VALUES (2, 'Bob');

INSERT INTO Blogs (C_id, B_title, B_Body) VALUES (1, 'First Blog', 'This is the body of the first blog.');

INSERT INTO Blogs (C_id, B_title, B_Body) VALUES (2, 'Second Blog', 'This is the body of the second blog.');

INSERT INTO Replies (B_id, C_id, Reply) VALUES (1, 2, 'Reply to the first blog.');

INSERT INTO Replies (B_id, C_id, Reply) VALUES (2, 1, 'Reply to the second blog.');



