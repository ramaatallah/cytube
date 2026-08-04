#!/bin/bash
set -e

# ==================================================================
# [Docker Requirement]
# This guide assumes MariaDB is already running via systemd on a
# regular VM. Since containers do not use systemd, start it manually.
# ==================================================================

# Initialize MariaDB data directory on first container startup
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB in the background (replacement for systemd)
mysqld_safe --datadir=/var/lib/mysql &

# Wait until MariaDB is ready to accept connections
until mysqladmin ping --silent 2>/dev/null; do
    sleep 1
done

# ------------------------------------------------------------------
# [Official Guide] Database section
# Execute these commands only once during the first startup:
#
#   GRANT USAGE ON *.* TO cytube3@localhost IDENTIFIED BY 'super_secure_password';
#   GRANT ALL PRIVILEGES ON cytube3.* TO cytube3@localhost;
#   CREATE DATABASE cytube3;
#   QUIT;
# ------------------------------------------------------------------
if [ ! -f /var/lib/mysql/.cytube_initialized ]; then
    echo "[entrypoint] Initializing the cytube3 database (official guide commands)..."
    mysql -u root <<-EOSQL
GRANT USAGE ON *.* TO cytube3@localhost IDENTIFIED BY 'super_secure_password';
GRANT ALL PRIVILEGES ON cytube3.* TO cytube3@localhost;
CREATE DATABASE cytube3;
EOSQL
    touch /var/lib/mysql/.cytube_initialized
    echo "[entrypoint] Database initialized successfully."
fi

# ------------------------------------------------------------------
# [Official Guide] Persistence > Forever setup
#
#   forever index.js
#
# Run CyTube in the foreground so the container stays alive.
# ------------------------------------------------------------------
cd /home/cytube/cytube-app
exec su cytube -c "forever index.js"

