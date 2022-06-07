const userTableQuery =
    "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT, balance DOUBLE);";
const transferTableQuery =
    "CREATE TABLE transfer(Tr_id INTEGER PRIMARY KEY AUTOINCREMENT,senderId INTEGER,receiverId INTEGER,amount DOUBLE,FOREIGN KEY (senderId) REFERENCES customer (id),FOREIGN KEY (receiverId) REFERENCES customer (id));";
