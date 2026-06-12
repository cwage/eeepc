# EeePC Provisioning

Ansible control repo for `portajohn`, an ASUS Eee PC 1005HA running Debian i386.

The control environment is Dockerized. The laptop only needs SSH, Python 3, sudo, and apt.

Run one Ansible job at a time against this machine. It is easy to make the Atom N270 feel wedged by running concurrent fact-gathering or apt tasks.

## Target

```text
host: portajohn
ip: 10.10.15.234
os: Debian 12 bookworm i386
hardware: ASUS Eee PC 1005HA, Atom N270, 1 GB RAM
```

## Workflow

Build the Ansible runner:

```bash
make build
```

Check connectivity:

```bash
make ping
```

Run preflight checks only:

```bash
make preflight
```

Preview an incremental change:

```bash
make check TAGS=baseline
```

Apply an incremental change:

```bash
make run TAGS=baseline
```

Convenience targets:

```bash
make baseline
make desktop
make lightdm
make xsession
make awesome
make xresources
make keyboard
make slim-services
```

## Step Tags

- `baseline`: small base packages and SSH service sanity.
- `desktop`: lightweight X11/AwesomeWM package set.
- `lightdm`: switch the display-manager target to LightDM and pin the default session to the EeePC Xsession.
- `xsession`: install a login session that runs `~/.xsession` (symlinked to the dotfiles `.xsession.eee`) through `/bin/sh`.
- `awesome`: symlink `~/.config/awesome` to the dotfiles AwesomeWM config.
- `xresources`: symlink `~/.Xresources` to the per-host dotfiles `.Xresources.eee` (bigger xterm font for the 1024x600 panel).
- `keyboard`: install an evdev `hwdb` remap for the built-in keyboard (CapsLock→Ctrl, Grave→Esc, Esc→Grave) that applies in X, console VTs, and early boot. Rebuilds the hwdb and re-triggers input devices.
- `slim-services`: disable obvious boot/runtime waste. Use after reviewing.

## Session Stack

LightDM shows the greeter and defaults to the **EeePC Xsession** entry, which runs
`/usr/local/bin/eeepc-xsession`. That wrapper execs `~/.xsession` (a symlink to
`dotfiles/.xsession.eee`) through `/bin/sh`, which self-wraps an `ssh-agent`, starts a
minimal tray (network, volume, automount), loads `~/.Xresources`, and finally execs
AwesomeWM using `~/.config/awesome/rc.lua`. The session deliberately omits Electron apps,
mail bridges, and the emacs daemon that the larger `.xsession` variants carry.

Mutating tasks are tagged with `never`, so a plain `ansible-playbook ansible/site.yml` only runs preflight checks.

## SSH

The container bind-mounts `${HOME}/.ssh` read-only and uses the host network namespace. It does not copy SSH keys into the repo or image.
