# CyTube Deployment using Containerlab, Docker, MariaDB, zrok, and Proxmox

## Project Description

This project demonstrates the deployment of the open-source **CyTube** collaborative media platform inside a virtual networking environment.

The deployment combines Containerlab, Docker, MariaDB, Node.js, zrok, and Proxmox VE to build a complete networked application that supports synchronized video playback, live chat, channel management, and secure remote access.

The project was developed as part of a Network Programming course to demonstrate modern deployment techniques and network virtualization.

---

## Features

- Multi-user synchronized video playback
- Real-time chat using Socket.IO
- User authentication
- Channel creation and management
- MariaDB persistent database
- Docker containerization
- Virtual network simulation using Containerlab
- Secure Internet access using zrok
- Deployment-ready for Proxmox VE

---

## Technologies Used

- Ubuntu Server
- Docker
- Containerlab
- Node.js
- CyTube
- MariaDB
- Socket.IO
- zrok
- Proxmox VE
- Git & GitHub

---

## Project Architecture

```
                    Internet
                        │
          https://cytube.share.zrok.io
                        │
                  zrok Secure Tunnel
                        │
                Ubuntu Virtual Machine
                        │
                 Containerlab Network
                        │
                 Docker Container
                        │
                  CyTube Server
                        │
                    MariaDB
```

---

## Project Structure

```
cytube-network-lab/
│
├── topology.yml
├── config.yaml
├── docker-compose.yml
├── scripts/
├── documentation/
├── screenshots/
├── README.md
└── report.pdf


```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/<username>/cytube-network-lab.git
cd cytube-network-lab
```

Deploy the Containerlab topology:

```bash
sudo containerlab deploy -t topology.yml
```

Verify the containers:

```bash
docker ps
```

---

## Configuration

Main configuration file:

```
config.yaml
```

Important parameters:

- Database connection
- Root domain
- Socket.IO domain
- Listening address
- Allowed origins

Restart the container after modifications:

```bash
docker restart clab-cytube-lab-cytube-server
```

---

## Database

Enter the container:

```bash
docker exec -it clab-cytube-lab-cytube-server sh
```

Connect to MariaDB:

```bash
mysql -u root -p
```

Select the database:

```sql
USE cytube3;
```

---

## Running zrok

Check the environment:

```bash
zrok status
```

View available shares:

```bash
zrok overview
```

Start the reserved share:

```bash
zrok share reserved cytube
```

Public URL:

```
https://cytube.share.zrok.io
```

---

## Usage

Local access:

```
http://192.168.56.102:8080
```

Public access:

```
https://cytube.share.zrok.io
```

Users can:

- Register accounts
- Create channels
- Watch synchronized videos
- Chat in real time
- Manage playlists

---

## Deploying on Proxmox

1. Create a new Ubuntu VM.
2. Install Docker and Containerlab.
3. Clone the GitHub repository.
4. Deploy the topology.
5. Configure MariaDB.
6. Configure CyTube.
7. Start zrok.
8. Test local and remote access.

---

## Screenshots

Add screenshots of:

- Containerlab topology
  <div align="center">

## 🌐 Containerlab Topology Status

|  (Node) | type os /  (Image) | (State) | IPv4 Address | IPv6 Address |
| :--- | :--- | :---: | :--- | :--- |
| **`cytube-server`** | `cytube-app:latest` | <span title="Running">🟢 **Running**</span> | `172.17.0.2` | *N/A* |
| **`client1`** | `linux` (`alpine:latest`) | <span title="Running">🟢 **Running**</span> | `172.20.20.5` | `3fff:172:20:20::5` |
| **`client2`** | `linux` (`alpine:latest`) | <span title="Running">🟢 **Running**</span> | `172.20.20.2` | `3fff:172:20:20::2` |
| **`router1`** | `linux` (`alpine:latest`) | <span title="Running">🟢 **Running**</span> | `172.20.20.4` | `3fff:172:20:20::4` |
| **`router2`** | `linux` (`alpine:latest`) | <span title="Running">🟢 **Running**</span> | `172.20.20.3` | `3fff:172:20:20::3` |

</div>
---
- Docker containers
<div align="center">

## 🐳 Active Docker Containers Status

| Container Name | Image | Status | Ports Mapping | Container ID |
| :--- | :--- | :---: | :--- | :---: |
| **`cytube-server`** | `cytube-app:latest` | <span title="Up 18 mins">🟢 **Up**</span> | `1337:1337`, `8080:8080` | `d916a0ccfb13` |
| **`finalproject-app-1`** | `finalproject-app` | <span title="Up 18 mins">🟢 **Up**</span> | `3000:3000` | `494bc04beb4e` |
| **`router1`** | `alpine:latest` | <span title="Up 18 mins">🟢 **Up**</span> | *N/A* | `acbb0231f935` |
| **`router2`** | `alpine:latest` | <span title="Up 18 mins">🟢 **Up**</span> | *N/A* | `b7d44d8490c9` |
| **`client1`** | `alpine:latest` | <span title="Up 18 mins">🟢 **Up**</span> | *N/A* | `bcd38b9d6ae1` |
| **`client2`** | `alpine:latest` | <span title="Up 18 mins">🟢 **Up**</span> | *N/A* | `762dd21b8939` |

</div>

---

### 🖥️ Raw Command Output

<details>
<summary>🔍 <b>Click here to view the output of the original command. (docker ps)</b></summary>

```bash
ramaatallah@vm:~/cytube-lab$ docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED        STATUS          PORTS                                                                                NAMES
d916a0ccfb13   cytube-app:latest   "/usr/local/bin/entr…"   7 days ago     Up 18 minutes   0.0.0.0:1337->1337/tcp, [::]:1337->1337/tcp, 0.0.0.0:8080->8080/tcp,[::]:8080->8080/tcp   clab-cytube-lab-cytube-server
acbb0231f935   alpine:latest       "/bin/sh"                7 days ago     Up 18 minutes                                                                                        clab-cytube-lab-router1
762dd21b8939   alpine:latest       "/bin/sh"                7 days ago     Up 18 minutes                                                                                        clab-cytube-lab-client2
bcd38b9d6ae1   alpine:latest       "/bin/sh"                7 days ago     Up 18 minutes                                                                                        clab-cytube-lab-client1
b7d44d8490c9   alpine:latest       "/bin/sh"                7 days ago     Up 18 minutes                                                                                        clab-cytube-lab-router2
494bc04beb4e   finalproject-app    "docker-entrypoint.s…"   2 months ago   Up 18 minutes   0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp                                           finalproject-app-1
```
</details>
---
##
- CyTube homepage
  <img width="1920" height="1017" alt="Screenshot (593)" src="https://github.com/user-attachments/assets/71aff9eb-ea5c-4c5b-98ef-ee57a11bd067" />
- zrok public URL
 <img width="1341" height="115" alt="Screenshot (598)" src="https://github.com/user-attachments/assets/e1c1d27e-4789-4131-b1c7-0ce7f9fe0387" />
 <img width="1920" height="1035" alt="Screenshot (597)" src="https://github.com/user-attachments/assets/ac22ffc3-a5e4-4770-b6f4-5914e46cac41" />
 <img width="1920" height="1031" alt="Screenshot (596)" src="https://github.com/user-attachments/assets/02c6ef0d-3d38-470e-b658-156595dec9b1" />
- Proxmox
  <img width="1920" height="1017" alt="Screenshot (583)" src="https://github.com/user-attachments/assets/8f2c774c-1ff3-4cda-830b-6aeebc9a4344" />
---

## Future Improvements



---

## Contributors

- Rama Atallah
- Network Programming Project
- An-Najah National University

---

## License

This project is intended for educational purposes.

---

## Acknowledgments

- CyTube Development Team
- Docker
- Containerlab
- OpenZiti / zrok
- MariaDB Foundation
- Proxmox VE
