import mysql.connector 
import sys

class DBhelper:

    def __init__(self):

        try:
            self.conn=mysql.connector.connect(host="localhost",user="root",password="root",database="hit_db_demo")

            self.mycursor = self.conn.cursor()
            print("Connection Successfully established")
        
        except:
            print("Some error occured. Could not connect to database")
            sys.exit(0)
        
        else:
            print("Connected to database")
    
    def register(self,name,email,password):
        try:
            self.mycursor.execute("""
            INSERT INTO 'hit_db_demo' ('id', 'name', 'email', 'password') 
            VALUES (NULL, '{}', '{}', '{}')""".format(name, email, password))
            
            self.conn.commit()
            print("User registered successfully")
        
        except:
            return -1
        else:
            return 1
       
    
    def search(self,email,password):

        self.mycursor.execute(""" 
        SELECT * From users where email like '{}' and password like '{}' """.format(email,password))

        data = self.mycursor.fetchall()
        return data
