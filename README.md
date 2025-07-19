# neozorba-nixlab.local

Recently revived my first laptop from its eternal sleep (thanks to a fresh SSD and an extra RAM stick). It now powers my nix-flavoured homelab.

## Overview

A self-hosted, NixOS-powered homelab running a lightweight Kubernetes cluster via `k3s`, complete with monitoring and dashboards; all declaratively managed and exposed via local DNS.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3f2be7a1-4dd3-45d8-9dd9-a63242e3d27d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fcdba2a1-0ea5-4b36-bc23-dc9682dbd81b" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/140bab73-13a1-4752-b49c-dfe9105964dd" />

## Tech Stack

- **OS**: NixOS (fully declarative, managed via `configuration.nix`)
- **Kubernetes**: [k3s](https://k3s.io/) (systemd-managed)
- **Ingress**: Traefik (comes bundled with k3s)
- **Monitoring**: Prometheus + Grafana (via kube-prometheus-stack)
- **Dashboards**: Kubernetes Dashboard + Grafana, all behind ingress
- **Networking**: Avahi (for mDNS `*.nixlab.local` on LAN)

## Running Services

| Service               | URL                          | Notes                                |
|-----------------------|-------------------------------|--------------------------------------|
| Grafana               | http://grafana.nixlab.local   | Ingress with pretty dashboards       |
| Prometheus            | http://prometheus.nixlab.local| Metrics for everything Kubernetes    |
| Kubernetes Dashboard  | http://dashboard.nixlab.local | Admin UI with token auth             |

