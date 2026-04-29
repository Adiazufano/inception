*This project has been created as part of the 42 curriculum by aldiaz-u.*

# **Description**
This project involves creating a complete network infrastructure using Docker Compose. The main goal is to configure several services (Nginx, MariaDB, and WordPress) within separate containers, ensuring they communicate securely and efficiently.

Unlike a simple deployment, Inception requires that each image be built from scratch using custom Dockerfiles, prohibiting the use of pre-configured Docker Hub images.

# **Project Analysis & Design Choices**

1. **Virtual Machines vs Docker:**

    * Virtual Machines: They emulate complete hardware and include a guest operating system. They are heavier and slower to boot.

    * Docker: It shares the host operating system kernel. It is much lighter, faster, and uses fewer resources (CPU/RAM), although it offers slightly less isolation than a pure VM.

2. **Secrets vs Environment Variables**
    
    * Enviroments Variables: They are easy to configure but visible through commands like docker inspect. They are not recommended for sensitive data.

    * Secrets: Los secretos permiten gestionar contraseñas y certificados de forma que solo el contenedor que los necesita pueda leerlos, evitando que queden grabados en las capas de la imagen.

3. **Docker Network vs Host Network**

    * Host Network: The container directly shares the host's IP address and ports. It's faster but less secure.

    * Docker Network(Bridge): It creates a virtual private network. It allows containers to communicate by their service name (internal DNS) and isolates the infrastructure from the outside world, exposing only port 443 through Nginx.

4. **Docker Volumes vs Bind Mounts**

    * Bind Mounts: They depend on your computer's folder structure (absolute path).

    * Docker Volumes: They are managed by Docker in a specific area of ​​the file system. They are the best option in this project for persisting MariaDB and WordPress data, as they are more secure and easier to back up.

# **Instructions**

## **prerequisites**

    * Docker & Docker Compose.

    * Privilegios de sudo (para la gestión de /etc/hots).

## **instalacionand execution**

    1. clone the repository.

    2. Configure your .env file in the src/ folder.

    3. Run the main command: make up.

    4. Access https://[your_login].42.fr in your browser.

# Resources

* [Docker Documentation](https://docs.docker.com/)

* [Nginx Configuration Guide](https://docs.nginx.com/)

* [Wordpress Deployment Best Practices](https://developer.wordpress.org/advanced-administration/server/web-server/nginx/)

# Use of AI
    
AI was used for debugging errors in the input scripts