# **Introduction and Services**

* **Web Service:** An Nginx server configured with security protocols (TLS/SSL).

* **Content Manager:** WordPress ready to use.

* **Databases:** MariaDB to store all site information.

* **Internal network:** An architecture where services communicate privately.

# **Lifecycle Management (Start/Stop)**

* **Start the project:** *make* Download what's needed and start the background services. 

* **Stop the project:"** *make down* It stops the containers but retains the data.

* **full clean:** *make fclean* will delete the services and volumes.

# Site Access and Administration Panel

* **Preliminary step:**

    Go to the etc directory and modify the hosts file, adding 127.0.0.1 and your_login-42.fr. Without this, you won't be able to log in.

* **Navigation:** 

    You must use https, not http. A security warning will appear because the certificate is self-signed. You must click on advanced and continue.

* **URLS:**

    * public place: https://your_login.42.fr

    * WordPress Desktop: https://your_login.42.fr/wp-admin.

# **Credential management**

*  User data is stored in the .env file located in srcs,
and passwords are stored in different .txt files within the secrets folder located in the root directory.

* **user data list (.env):**

    * MARIADB_USER = mysql

    * SQL_USER = whichever you prefer

    * SQL_DATABASE = whichever you prefer

* **secrets**

    You need to create the secrets folder and create the files db_password.txt and wp_admin_password.txt and add the different passwords.

# **System Verification**

* **visual check:**
    If the WordPress blog appears when you enter the URL, everything is correct.

* **Console verification:** 

    * Run the docker ps command 3 containers should appear(nginx, wordpress, mariadb) the status must always be up