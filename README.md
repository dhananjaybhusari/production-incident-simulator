\# Production Incident Simulator



> Real-world operational runbooks and post-mortem analyses for Cloud and Infrastructure support roles.



This repo contains several bash-based simulations of infrastructure failures, including comprehensive runbook guides for resolving these problems and historical incident analyses. The use of this code demonstrates practical knowledge of \*\*Cloud Support\*\*, \*\*System Administration\*\*, and \*\*Reliability Engineering\*\* through the intentional creation of faults followed by their repair.





\## 📖 Core Concepts

In a true operations environment, reference materials must be strictly separated from historical event logs. This repository is structured around that principle:

\* \*\*Runbooks (`/runbooks`)\*\*: Living reference documents detailing step-by-step resolution paths for known, recurring issues.

\* \*\*Incident Reports (`/incidents`)\*\*: Documentation of specific, historical simulation events, including the scripts used to trigger the failure and the resulting post-mortem.



\## 📂 Repository Structure



production-incident-simulator/

├── README.md

├── runbooks/                  

│   ├── aws/

│   │   └── runbook.md

│   ├── linux/

│   │   └── runbook.md

│   └── networking/

│       └── runbook.md

└── incidents/                 

&#x20;   ├── 2026-05-13-scenario/

&#x20;   │   ├── simulate.sh

&#x20;   │   ├── reset.sh

&#x20;   │   └── incident-report.md

&#x20;   └── 2026-05-14-scenario/

&#x20;       ├── simulate.sh

&#x20;       ├── reset.sh

&#x20;       └── incident-report.md



\## 🛠️ Technologies



\* \*\*Shell Scripting\*\* (Bash)

\* \*\*Linux/Unix\*\* System Administration

\* \*\*AWS\*\* Core Services (EC2, VPC, S3)

\* \*\*Markdown\*\*

