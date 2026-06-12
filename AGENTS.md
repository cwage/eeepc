# EeePC Provisioning Notes

- Run Ansible through Docker Compose from this repository. Do not rely on host Ansible.
- The target is an ASUS Eee PC 1005HA running Debian i386. Avoid amd64-only repositories, Electron desktop apps, Docker-on-target assumptions, and heavyweight desktop stacks.
- Keep mutating changes incremental and tag-gated. A plain playbook run should be safe for preflight checks.
- Prefer `--check --diff` before applying a tagged change.
- Do not put secrets in inventory or vars. Use SSH agent/local SSH config from the host.

