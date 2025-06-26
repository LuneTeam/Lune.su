<div align="center">
    <h1>❄️  Lune.su  ❄️</h1>
    <h3></h3>
</div>

<div align="center">
    <h1>High-Performance OpenSource Web Server</h1>
    <h4>A showcase of what one determined developer can build with modern open-source tools</h4>
</div>

> [!WARNING]
> This repository is under active development, if something does not work, write issues

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
| **AlmaLinux** | OS                     | Excellent security and good support        |
| **SELinux**    | Security               | Mandatory Access Control                   |
| **Nftables**   | Firewall               | Modern packet filtering                    |

<div align="center">
    <h1>📦 Installation Guide</h1>
    <h3></h3>
</div>

1. **Prepare your VPS**:
    Ensure you have a fresh AlmaLinux 9.0 installation

2. **Clone the repository**:
    ```bash
    git clone https://github.com/LuneDots/Lune.su
    ```

3. **Create and configure new files**
  1. Using openssl or certbot create tsl/ssl certificates
  # CertBot
  ```bash
  certbot --nginx
  ```
  # OpenSSL
  ```bash
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./nginx/ssl/cert.key -out ./nginx/ssl/cert.pem -subj "/CN=domain.com"
  ```

  2. Create a file with your hosts in infra/ansible/inventory/hosts.yaml
  ```bash
  nvim ./infra/ansible/inventory/hosts.yaml
  ```

  ```yaml
  webserver:
    hosts:
      luneA:
        ansible_host: 1.234.567.8
        ansible_user: developer
      luneB:
        ansible_host: 1.234.567.8
        ansible_user: developer
  ```

3. **Run ansible master playbooks**
    ```bash
    ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbook/master.yaml -e PROJECT_DIR=YOUR_DIRECTORY
    ```

4. **Podman login -u "name"**
   For reasons unseen to me, you will have to log into your account imperatively after the error
