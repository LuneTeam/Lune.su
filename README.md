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
| **Firewalld**   | Firewall               | Dynamic firewall rules management                    |
| **Fail2Ban**   | Intrusion Prevention               | Automatic blocking of malicious IPs                    |
| **Rsyslog**   | Logging & Monitoring               | Centralized logging with advanced filters                    |

<div align="center">
    <h1>📦 Installation Guide</h1>
    <h3></h3>
</div>

[!IMPORTANT]
>Don't forget to change compose.yaml to your docker.hub!
>Don't forget to make npm app in images/app, I recommend via astral or make your own via golang and static index.html

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/LuneDots/Lune.su
    ```

2.  **Prepare your VPS**:
    Ensure you have a fresh AlmaLinux 9.0 installation

    **You can do it via terraform!**
  1. Create a new terraform file variables
  ```terraform
  token_timeweb = "1234"
  ssh_key       = [1234]
  preset_ids    = 1234
  project_ids   = 1234
  ipv4_static   = "1234"
  ```

  2. Generate a change file
  ```bash
  terraform plan -var-file=values.tfvars
  ```

  3. Create your vps via terraform via apply
  ```bash
  terraform apply -var-file=values.tfvars
  ```

3.  **Create and configure new files**
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

  3. Create and configure Podman login file infra/ansible/playbook/build/podman/login.yaml
  ```bash
  nvim ./infra/ansible/playbook/build/podman/login.yaml
  ```

  ```yaml
  - name: Login to Podman user
    hosts: lune
    become: true

    tasks:
      - name: Login to default registry and create ${XDG_RUNTIME_DIR}/containers/auth.json
        containers.podman.podman_login:
          username: Developer
          password: "1234567890"
  ```

4.  **Run ansible master playbooks**
    ```bash
    ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbook/master.yaml -e PROJECT_DIR=YOUR_DIRECTORY
    ```
