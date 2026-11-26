# inception

> A small web infrastructure built **from scratch with Docker Compose**: every image is written by hand on top of Debian, no ready-made images from Docker Hub.

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![NGINX](https://img.shields.io/badge/NGINX-009639?style=flat&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=flat&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat&logo=mariadb&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat&logo=redis&logoColor=white)

## About

Inception is a system administration project. It runs a WordPress site behind NGINX with TLS,
backed by MariaDB, with each service in its own container built from a custom `Dockerfile`.
Containers talk over a private bridge network, and data lives in persistent volumes on the host.

## Architecture

```
                 :443 (TLS)
   browser ───────────────▶ nginx ──▶ wordpress (php-fpm :9000) ──▶ mariadb (:3306)
                              │              │
                              │              └──▶ redis (:6379, object cache)
                              └──▶ adminer (php-fpm)
   ftp client ─── :21 ───▶ vsftpd ──▶ WordPress files volume
```

| Service | Role |
|---|---|
| **nginx** | the only entry point, HTTPS on port 443 with TLS 1.3 |
| **wordpress** | WordPress + PHP-FPM, installed and configured at start-up |
| **mariadb** | database for WordPress |
| **redis** *(bonus)* | object cache for WordPress |
| **adminer** *(bonus)* | web UI for the database |
| **ftp** *(bonus)* | vsftpd server with access to the WordPress files |

All containers restart automatically and are connected through the `inception` network.
WordPress files and the database are stored in bind-mounted volumes under `/home/$USER/data`.

## Run

Requires Docker with the Compose plugin. Settings and credentials are read from `srcs/.env`.

```bash
make          # build all images and start the stack
make down     # stop the containers
make clean    # remove containers, images and volumes
make fclean   # also prune Docker and delete the data folders
```

Then open `https://<DOMAIN_NAME>` (the certificate is self-signed).

## Project structure

```
srcs/
├── docker-compose.yml
├── .env
└── requirements/
    ├── nginx/      ├── wordpress/   ├── mariadb/
    ├── redis/      ├── adminer/     └── ftp/
```

---

<sub>Part of the <a href="https://www.codam.nl/">Codam</a> (42 network) curriculum.</sub>
