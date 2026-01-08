# SDN Network Automation with OpenDaylight

## Overview
This project demonstrates a Software Defined Networking (SDN) environment where
OpenDaylight (ODL) acts as the centralized controller to dynamically manage network behavior.
The network integrates Open vSwitch (OVS), FRRouting (FRR), Jenkins, Ansible, and Grafana to
showcase automation, policy enforcement, monitoring, and resilience.

## Technologies Used
- OpenDaylight (SDN Controller)
- Open vSwitch (OVS)
- FRRouting (Static Routing, OSPF, IS-IS)
- Python (ODL REST API interaction)
- Ansible (Network configuration automation)
- Jenkins (CI/CD pipeline)
- Grafana (Network monitoring and visualization)

## Key Features
- SDN-based flow installation using OpenDaylight
- Blocking a subnet using ODL-installed OpenFlow rules
- Quality of Service (QoS) policy enforcement via ODL
- Automated configuration of FRR routers using Ansible
  - Static Routing
  - OSPF
  - IS-IS
- Jenkins-driven configuration deployment (DevOps approach)
- LACP configuration on OVS to demonstrate link failover
- Network monitoring and visualization using Grafana

## Architecture
- OpenDaylight centrally controls OVS switches
- FRR routers handle routing protocols
- Jenkins triggers Ansible playbooks for configuration deployment
- Python scripts push policies to ODL via REST APIs
- Grafana monitors network performance and status

## Use Cases Demonstrated
- Network automation and consistency using Ansible
- DevOps principles applied to networking
- Centralized SDN policy enforcement
- High availability through LACP failover
- QoS traffic prioritization
- Real-time network monitoring

## How It Works
1. Jenkins triggers Ansible playbooks.
2. Ansible configures FRR routers and network services.
3. Python scripts communicate with ODL REST APIs.
4. ODL installs OpenFlow rules on OVS switches.
5. Grafana visualizes network metrics.

## License
MIT License
