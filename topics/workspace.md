#WORKSPACE – QUICK CHEAT SHEET
cd /data/workspace

## Nasadenie

### Cinnamon policy
bash scripts/setup/configure-cinnamon.sh

### system policy
bash scripts/setup/configure-service-policy.sh
bash scripts/setup/configure-kernel-policy.sh
bash scripts/setup/configure-firewall-policy.sh

### nasadiť HOME symlinky podľa home-managed.conf
bash scripts/setup/install-home.sh

### nasadiť SSH config
bash scripts/setup/install-ssh.sh

### launchery + ikony
workspace-desktop-update

### aktualizovať inventár desktop launcherov
workspace-desktop-list-update

### publikovať scripts/bin/*.sh -> /usr/local/bin/*
sudo bash scripts/setup/install-bin.sh
---
## Praca
existujúci súbor pod home/   -> workspace-git-update-home
nový súbor / čokoľvek mimo home/ -> workspace-git-update-all

### stav
git status --short

### HOME – iba tracked zmeny pod home/
workspace-git-update-home

### CELÝ WORKSPACE – nové súbory, zmazania, scripts/, manifesty, docs...
workspace-git-update-all

