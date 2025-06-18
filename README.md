<div align="center">
    <h1>❄️  Lune.su  ❄️</h1>
    <h3></h3>
</div>

<div align="center">
    <h1>High-Performance OpenSource Web Server</h1>
    <h4>A showcase of what one determined developer can build with modern open-source tools</h4>
</div>

> [!WARNING]  
> This repository is under active development, if something does not work, write issues or try to run it again

<div align="center">
    <h1>🛠️ Core Technologies</h1>
    <h3></h3>
</div>

| Technology     | Purpose                | Advantages                                 |
| -------------- | ---------------------- | ------------------------------------------ |
| **Podman**     | Containerization       | Rootless, daemonless, Docker-compatible    |
| **Ansible**    | Infrastructure as Code | Declarative configuration, idempotency     |
| **Nginx**      | Web Server             | High performance, efficient resource usage |
| **Bash**       | Scripting              | Automation and error handling              |
| **Arch Linux** | OS                     | Cutting-edge packages, full control        |
| **Apparmor**    | Security               | Mandatory Access Control                   |
| **Nftables**   | Firewall               | Modern packet filtering                    |

<div align="center">
    <h1>📦 Installation Guide</h1>
    <h3></h3>
</div>

1.  **Prepare your VPS**:
    Ensure you have a fresh Arch Linux installation

2.  **Clone the repository**:
    ```bash
    git clone https://github.com/LuneDots/Lune.su
    ```

3.  **Set up a new file**
    ```bash
    touch infrastructure/ansible/inventory/hosts.yaml

    touch podman/nginx/ssl/cert.key
    touch podman/nginx/ssl/cert.pem

    ```

4.  **Run ansible master playbooks**
    ```bash
    ansible-playbook -i infrastructure/ansible/inventory/hosts.yaml infrastructure/ansible/playbook/master.yaml -e PROJECT_DIR=YOUR_DIRECTORY
    ```
