# =============================================================
# Dockerfile - CyTube 3.0
#  https://github.com/calzoneman/sync/wiki/CyTube-3.0-Installation-Guide
# =============================================================

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------------
# "Installation of prerequisites > Debian / Ubuntu":
#   sudo apt update && sudo apt upgrade
#   sudo apt install build-essential git mariadb-server
# ------------------------------------------------------------------
RUN apt update && apt upgrade -y
RUN apt install -y build-essential git mariadb-server

# ------------------------------------------------------------------
# [ Docker]"Refer to nodesource... to install
# ------------------------------------------------------------------
RUN apt install -y curl gnupg ca-certificates

# ------------------------------------------------------------------

RUN apt install -y iproute2 iputils-ping net-tools tcpdump

# ------------------------------------------------------------------
#  Node.js 
# ------------------------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt install -y nodejs && \
    node -v && npm -v
# ------------------------------------------------------------------
# "Software Requirements":
#   "CyTube will require its own non-root user to run as. Running as
#    root is not supported... can easily be added with useradd"
# ------------------------------------------------------------------
RUN useradd -m -s /bin/bash cytube

# ------------------------------------------------------------------
# "Cloning from git":
# ------------------------------------------------------------------
WORKDIR /home/cytube
RUN git clone -b 3.0 https://github.com/calzoneman/sync cytube-app && \
    chown -R cytube:cytube /home/cytube/cytube-app

# ------------------------------------------------------------------
# "NPM dependencies"
#   cd sync
#   if [ "$(whoami)" = "root" ]; then
#     echo "Do not run this as root!"
#   else
#     npm install
#   fi
# ------------------------------------------------------------------
WORKDIR /home/cytube/cytube-app
USER cytube
RUN if [ "$(whoami)" = "root" ]; then \
      echo "Do not run this as root!"; \
    else \
      npm install; \
    fi
USER root
# ------------------------------------------------------------------
RUN npm install -g forever

# ------------------------------------------------------------------
# "Configuration File":
#   cp config.template.yaml config.yaml
# ------------------------------------------------------------------
RUN cp config.template.yaml config.yaml && chown cytube:cytube config.yaml

# ------------------------------------------------------------------

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# CyTube HTTP (config.template.yaml)
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
