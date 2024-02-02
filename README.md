# dotfiles
keep my dotfiles organized

## Change Log

### 2024-02-01

- Moved my theme of choice in emacs to nimbus. 
- Commented out a few bash/zsh configs, as I am mostly using fish now.

### 2023-10-22

Changed `/etc/systemd/logind.conf` in @t480 with uncommenting the lines:

- `HandleLidSwitch=suspend`
- `HandleLidSwitchExternalPower=suspend`
- `HandleLidSwitchDocked=ignore`
