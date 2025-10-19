#!/usr/bin/env python3
"""
MySQLServer.py
Creates the MySQL database 'alx_book_store' and executes the SQL schema file to build its tables.
"""

import mysql.connector
import os

def create_and_setup_database():
    connection = None
    cursor = None
    try:
        # Step 1: Connect to MySQL Server
        connection = mysql.connector.connect(
            host='localhost',
            user='root',  # change if needed
            password='your_password_here',  # change if needed
            auth_plugin='mysql_native_password'  # optional if needed
        )

        if connection.is_connected():
            cursor = connection.cursor()

            # Step 2: Create database if not exists
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

            # Step 3: Use the database
            cursor.execute("USE alx_book_store")

            # Step 4: Execute SQL file
            sql_file_path = os.path.join(os.path.dirname(__file__), "alx_book_store.sql")

            if os.path.exists(sql_file_path):
                with open(sql_file_path, 'r', encoding='utf-8') as sql_file:
                    sql_commands = sql_file.read()

                for command in sql_commands.split(';'):
                    command = command.strip()
                    if command:
                        cursor.execute(command)
                connection.commit()
                print("SQL file executed successfully! Tables created in 'alx_book_store'.")
            else:
                print(f"Error: SQL file not found at {sql_file_path}")

    except mysql.connector.Error as err:
        print(f"Error while connecting to MySQL: {err}")

    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()

if __name__ == "__main__":
    create_and_setup_database()
