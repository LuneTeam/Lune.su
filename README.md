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

> [!IMPORTANT]
> Ensure you update the compose.yaml file to reference your Docker Hub. Also, create the npm app in the images/app directory. I suggest using Astral or building your own with GoLang and a static index.html

<h2>1.  Clone the repository</h2>

  ```bash
  git clone https://github.com/LuneDots/Lune.su
  ```

<h2>2.  Prepare your VPS</h2>

> [!NOTE]
> **You can do it via terraform!**

  2.1 Create a new terraform file variables
  ```bash
  nvim ./infra/terraform/values.tfvars
  ```

  ```tf
  token_timeweb = "1234"
  ssh_key              = [1234]
  preset_ids       = 1234
  project_ids     = 1234
  ipv4_static     = "1234"
  ```

  2.2 Generate a change file
  ```bash
  terraform plan -var-file=values.tfvars
  ```

  2.3 Create your vps via terraform via apply
  ```bash
  terraform apply -var-file=values.tfvars
  ```

<h2>3.  Create and configure new files</h2>
   
      3.1 Using openssl or certbot create tsl/ssl certificates
  <h3>CertBot</h3>
  
  ```bash
  certbot --nginx # preferable
  ```
  <h3>OpenSSL</h3>
  
  ```bash
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./nginx/ssl/cert.key -out ./nginx/ssl/cert.pem -subj "/CN=domain.com"
  ```

   3.2 Create a file with your hosts in infra/ansible/inventory/hosts.yaml
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

   3.3 Create and configure Podman login file infra/ansible/playbook/build/podman/login.yaml
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

<h2>4.  Run ansible master playbooks</h2>

  ```bash
  ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbook/master.yaml -e PROJECT_DIR=YOUR_DIRECTORY
  ```
