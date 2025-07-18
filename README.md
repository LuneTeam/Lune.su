<div align="center">
    <h1>❄️  Lune.su  ❄️</h1>
    <h3></h3>
</div>

<div align="center">
    <h1>High-Performance OpenSource Web Server</h1>
    <h4>A showcase of what one determined developer can build with modern open-source tools</h4>
</div>

> [!IMPORTANT]
> This repository is already quite self-sufficient after configuration, but if problems are found, write to issues

<div align="center">
    <h1>🛠️ Core Technologies</h1>
    <h3></h3>
</div>

| Technology     | Purpose                | Advantages                                 |
| -------------- | ---------------------- | ------------------------------------------ |
| **Podman Compose**| Container Management| Rootless, daemonless, Docker-compatible|
| **Ansible**| Config Management & Automation | Agentless, declarative (YAML), idempotent|
| **Terraform**| Infrastructure as Code (IaC)| Declarative, multi-cloud, manages state|
| **Nginx**| Web Server & Reverse Proxy| High performance, low resource usage, scalable|
| **Github Actions**| CI/CD & Automation| Natively integrated with GitHub, highly customizable|
| **AlmaLinux**| Operating System| 1:1 RHEL compatible, stable, long-term support|
| **Firewalld**| Firewall Management| Dynamic rule updates (no service restart), zones|
| **Fail2Ban**| Intrusion Prevention| Scans logs and bans IPs to prevent brute-force attacks|
| **Grafana**| Data Visualization| Rich, interactive dashboards and alerting|
| **Prometheus**| Monitoring & Alerting| Powerful query language (PromQL), pull-based metrics|
| **Node-exporter**| System Metric Exporter| Exposes hardware & OS metrics for Prometheus|


<div align="center">
    <h1>📦 Installation Guide</h1>
    <h3></h3>
</div>

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
  ssh_key       = [1234]
  preset_ids    = 1234
  project_ids   = 1234
  ipv4_static   = "1234"
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
      luneB:
        ansible_host: 1.234.567.8
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
  ansible-playbook infra/ansible/playbook/build/master.yaml
  ```
