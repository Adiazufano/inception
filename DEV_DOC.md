# **Environment Setup & Configuration**

## **Prerequisites***

   * Operating System: Linux (Debian/Ubuntu recommended).

    * Tools: Docker (v20.10+), Docker Compose (v2.0+), and GNU Make.

    * Resources: At least 2GB of RAM and 5GB of free disk space.

## **Project Structure**

The project follows a modular structure where each service has its own dedicated environment:

* srcs/docker-compose.yml: The orchestrator of the entire stack.

* srcs/requirements/: Contains the Dockerfile and configuration scripts for each service (Nginx, MariaDB, WordPress).

* srcs/.env: Centralized environment variables (not tracked by Git).

## **Secrets Management**

We use Docker Secrets to handle sensitive data, ensuring that passwords never exist as environment variables inside the containers' metadata.

   * Location: Secrets are stored in the /secrets directory at the root.

    * Mandatory Secrets:

        * db_password.txt: Password for the WordPress database user.

        * db_root_password.txt: Administrative password for MariaDB.

        * wp_admin_password.txt: Password for the WordPress administrator.

# **Build and Launch Process**

The deployment is fully automated via the Makefile.

## **Build Workflow**

1. Preparation: The Makefile creates the necessary persistent directories in the host system (/home/login/data/...).

2. Compilation: Images are built from scratch using Debian as the base image. No pre-built images from Docker Hub are used (except for the OS).

3. Orchestration: docker-compose sets up the internal network, mounts the volumes, and attaches the secrets.

## **Key Commands**

* make: Builds and starts the stack in detached mode.

* make up: Forces a rebuild of the images.

* make down: Stops and removes containers and networks.

* make fclean: Deep clean. Removes containers, images, networks, and all persistent data volumes.

# **Container Management & Debugging**

For development and troubleshooting, use the following technical commands:

* Check Logs: docker-compose -f srcs/docker-compose.yml logs -f [service_name] (Crucial for debugging MariaDB initialization).

* Interactive Shell: docker exec -it [container_name] sh (To inspect internal configurations).

* Network Inspection: docker network inspect inception_network to verify IP assignments and connectivity.

* Database Access: To enter the DB manually:
    docker exec -it mariadb mariadb -u root -p$(cat /run/secrets/db_root_password)

# **Data Persistence Strategy**

The project ensures that data is decoupled from the container lifecycle through Docker Volumes.
## **Storage Mapping**

We use bind-mounts or named volumes that point to specific host paths:

* MariaDB: /home/your_login/data/mariadb maps to /var/lib/mysql.

* WordPress: /home/your_login/data/wordpress maps to /var/www/wordpress.

## **Initialization Logic**

Each service has a custom entrypoint script:

* MariaDB: Checks if ibdata1 exists. If not, it runs mariadb-install-db and configures users/passwords using the secrets.

* WordPress: Uses wp-cli to download and install the CMS, creating the admin and a standard user automatically if the database is empty.

# **Technical Choices & Security**

* Network Isolation: All containers are in a private bridge network. Only Nginx has port 443 exposed to the host.

* Privilege Separation:

    * Nginx runs as www-data.

    * MariaDB runs as mysql.

    * The Root Password is assigned to MariaDB during setup to close the default "open" access.