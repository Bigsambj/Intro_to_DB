#!/usr/bin/env python3
"""
MySQLServer.py
Creates a MySQL database named 'alx_book_store' if it doesn't already exist.
"""

import mysql.connector
from mysql.connector import Error
import os

def create_database():
    connection = None
    try:
        # Connect to MySQL Server (adjust user/password as needed)
        connection = mysql.connector.connect(
            host='localhost',
            user='root',       # change if using a different MySQL user
            password='P@55H@rD'  # replace with your MySQL password
        )

        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

    except Error as e:
        print(f"Error while connecting to MySQL: {e}")

    finally:
        # Close cursor and connection safely
        if connection is not None and connection.is_connected():
            cursor.close()
            connection.close()
            # print("MySQL connection is closed.")  # optional

if __name__ == "__main__":
    create_database()
