# Production Incident Simulator

A collection of infrastructure failure simulations, troubleshooting runbooks, and incident reports for practicing real-world Cloud Support and System Administration tasks.

This project focuses on creating common operational issues intentionally and resolving them using standard troubleshooting methods.

---

## 📂 Repository Structure

```text
production-incident-simulator/

├── README.md
│
├── runbooks/
│   ├── aws/
│   │   └── runbook.md
│   │
│   ├── linux/
│   │   └── runbook.md
│   │
│   └── networking/
│       └── runbook.md
│
└── incidents/
    ├── 2026-05-13-scenario/
    │   ├── simulate.sh
    │   ├── reset.sh
    │   └── incident-report.md
    │
    └── 2026-05-14-scenario/
        ├── simulate.sh
        ├── reset.sh
        └── incident-report.md
```

---

## 📖 About

The repository is divided into two parts:

### Runbooks (`/runbooks`)
Contains troubleshooting steps and resolution guides for common infrastructure issues.

Topics include:
- Linux administration
- AWS basics
- Networking troubleshooting

### Incident Reports (`/incidents`)
Contains simulated incidents with:
- Failure simulation scripts
- Recovery scripts
- Incident documentation and root cause analysis

---

## 🛠️ Technologies Used

- Bash / Shell Scripting
- Linux
- AWS (EC2, VPC, S3)
- Networking Basics
- Markdown

---

## ▶️ Example Usage

### Run the simulation

```bash
chmod +x simulate.sh
./simulate.sh
```

### Reset the environment

```bash
chmod +x reset.sh
./reset.sh
```

---

## 📌 Purpose

This project was created to practice:
- Infrastructure troubleshooting
- Incident handling
- Linux system administration
- Cloud support basics
- Writing operational documentation

---

## ⚠️ Note

These scripts are for learning purposes only.

Run them only in:
- Virtual machines
- Test environments
- Personal labs

Do not run them on production systems.
