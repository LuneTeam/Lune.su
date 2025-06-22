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
| **AppArmor**    | Security               | Mandatory Access Control                   |
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
  sudo certbot --nginx
  ```
  # OpenSSL
  ```bash
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./nginx/ssl/cert.key -out ./nginx/ssl/cert.pem -subj "/CN=domain.com"
  ```

  2. Create a file with your hosts in infrastructure/ansible/inventory/hosts.yaml
  ```bash
  nvim ./infrastructure/ansible/inventory/hosts.yaml
  ```

  ```yaml
  webserver:
    hosts:
      lune:
        ansible_host: 1.234.567.8
        ansible_user: developer
      luneDev:
        ansible_host: 1.234.567.8
        ansible_user: developer
  ```

  3. Set up podman/monitoring/prometheus.yaml
  ```yaml
  global:
  scrape_interval: 1m

  scrape_configs:
  - job_name: "prometheus"
    scrape_interval: 1m
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node"
    static_configs:
      - targets: ["node-exporter:9100"]

  remote_write:
    - url: "Prometheus remote_write endpoint"
      basic_auth:
        username: "Grafana User"
        password: "Grafana Cloud Access Policy Token"
  ```

4. **Run ansible master playbooks**
    ```bash
    ansible-playbook -i infrastructure/ansible/inventory/hosts.yaml infrastructure/ansible/playbook/master.yaml -e PROJECT_DIR=YOUR_DIRECTORY
    ```

5. **Podman login -u "name"**
   For reasons unseen to me, you will have to log into your account imperatively after the error
