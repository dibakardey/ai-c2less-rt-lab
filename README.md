# 🛰️ AI C2-Less Lab

An experimental **AI-driven alternative to traditional Command-and-Control (C2) servers**.  
This project demonstrates how serverless infrastructure (AWS Lambda, API Gateway, S3) can replace persistent C2 servers for ethical hacking research, Red Team simulations, and automation testing.  

Instead of a fixed server, it uses **ephemeral, AI-coordinated agents** that spin up, execute, and vanish — leaving a minimal footprint.

---

## 🚀 Features
- **Serverless agents** (AWS Lambda) act as lightweight execution nodes.  
- **AI-powered coordinator** handles task assignment and log aggregation.  
- **Infrastructure-as-Code** (Terraform + AWS SAM) for easy provisioning.  
- **Dashboard + Reports** included for monitoring executions.  
- Designed as a **research & educational lab** — not for malicious use.

---

## 📂 Repository Structure
```plaintext
├── agent/             # Lambda agent code
├── coordinator/       # AI-driven task coordinator
├── infrastructure/    # Terraform + SAM templates
├── docs/              # Architecture diagrams + setup guides
├── reports/           # Sample execution logs and reports
├── README.md          # This file
├── requirements.txt   # Python dependencies
├── LICENSE            # MIT License
└── .github/workflows/ # CI/CD pipeline for testing & linting


---

## ⚡ Setup & Deployment

### 1. Clone Repo
```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

2. Install Dependencies
pip install -r requirements.txt

3. Deploy Infrastructure
cd infrastructure
terraform init
terraform apply

4. Deploy Agents
cd ../agent
sam build && sam deploy --guided

5. Run Coordinator
cd ../coordinator
python coordinator.py

📊 Usage

Assign tasks to agents via the Coordinator (coordinator/task_assigner.py).

Monitor execution via:

AWS CloudWatch logs

reports/ folder (sample logs included)

Extend Lambda agents to simulate more Red Team activities.

🖼️ Architecture

📜 License

This project is licensed under the MIT License
.

⚠️ Disclaimer: This project is for educational & research purposes only.
Do not use it for unauthorized access or malicious activity.
