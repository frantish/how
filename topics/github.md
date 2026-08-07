# GitHub

Public Git repositories cez SSH.

## NEW REPO -> GITHUB

GitHub -> New repository

* Public
* prázdne repo
* bez README
* bez `.gitignore`
* bez License

Lokálne:
`cd /path/to/project`
`git init`
`git branch -M main`
`git add .`
`git status`
`git commit -m "Initial commit"`

Napoj GitHub ako hlavný remote:
`git remote add origin github:USER/REPO.git`

Prvý push:
`git push -u origin main`

Výsledok:
`origin -> GitHub`
---
## ADD FORGEJO AS SECOND REMOTE

Najprv vytvor na Forgejo prázdne repo s rovnakým názvom.

Pridaj Forgejo remote:
`git remote add forgejo forgejo:USER/REPO.git`

Kontrola:
`git remote -v`

Prvý push na Forgejo:
`git push forgejo main`

Nepoužívaj tu `-u`. GitHub má zostať hlavný upstream.

Výsledok:
`origin  -> GitHub`
`forgejo -> Forgejo`
---
## CHECK

Remotes:
`git remote -v`

Aktuálna branch:
`git branch --show-current`

Stav vrátane upstream:
`git status -sb`

Správny stav pre main:
`## main...origin/main`
---
## DAILY WORKFLOW

Najprv synchronizácia:
`git pull`

Pozri zmeny:
`git status`

Pridaj zmeny:
`git add .`

Kontrola pred commitom:
`git status`

Commit:
`git commit -m "DESCRIPTION"`

Push na GitHub:
`git push`

Voliteľne rovnaký commit aj na Forgejo:
`git push forgejo main`
---
## QUICK

`git status`
`git pull`
`git add .`
`git status`
`git commit -m "DESCRIPTION"`
`git push`
`git push forgejo main`

