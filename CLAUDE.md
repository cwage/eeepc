# EeePC Project Guidance

This repo provisions and documents `portajohn`, an ASUS Eee PC 1005HA. The goal is intentionally modest: rehab an old laptop for fun, make it pleasant for shell-heavy portable computing, and avoid turning it into a fragile science project unless that is explicitly the point.

## Operating Assumptions

- This machine is severely resource-constrained: 32-bit Atom N270, roughly 1 GB RAM, old Intel 945GSE graphics, and a 1024x600 display.
- The user mostly lives in a shell. Prefer fast terminal-first workflows over modern desktop conveniences.
- Modern GNOME/KDE/Cinnamon-style desktop stacks are outside the target envelope.
- Debian i386 with lightweight X11 components is the baseline unless the user intentionally changes direction.
- Docker is for the control environment where practical. Do not assume Docker should run on the EeePC itself.

## Hardware Reference

Before installing packages, enabling services, or proposing desktop software, check the hardware diagnostic in:

`docs/hardware/portajohn-hardware-report-20260612-sanitized.txt`

Use it as a sanity check for architecture, RAM, graphics, wireless, storage, battery, and service-load decisions. If a package is Electron-based, GPU-composited, browser-heavy, amd64-only, or likely to pull a large desktop stack, look for a lighter alternative first.

## Provisioning Rules

- Use the Dockerized Ansible runner in this repo. Do not require host Ansible.
- Run one Ansible job at a time; concurrent fact gathering or apt tasks can make the machine feel wedged.
- Prefer `make check TAGS=<tag>` before `make run TAGS=<tag>`.
- Keep changes incremental and tag-gated. Plain playbook runs should remain safe preflight checks.
- Avoid adding external apt repos unless they explicitly support Debian i386 and are worth the cost.
- Avoid heavyweight daemons and background indexers unless there is a clear need.

## Desktop Direction

- Prefer LightDM + Xorg + AwesomeWM or similarly light X11 sessions.
- Avoid Wayland/GNOME Shell on this hardware.
- Keep autostart minimal: network tray, volume, polkit agent, automounter, and terminal-oriented tools are reasonable.
- Avoid Slack, Signal Desktop, modern browser-heavy workflows, and other Electron apps.
- If the display appears black or impossibly dim after suspend/resume, the software backlight interface may still report full brightness. Try the hardware hotkey `Fn+F6` before assuming the session is dead.

## Git Workflow

- Work on branches and open PRs against `main`.
- Do not push directly to `main`.
- Keep PRs small enough to test on the laptop after each step.
