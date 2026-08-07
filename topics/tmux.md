# tmux

Persistent terminal session keeper. Sessions patria userovi, nie adresáru.

## CONFIG

`~/.tmux.conf`

* `set -g mouse on`
* `set -g history-limit 100000`

Kitty:

* Scroll: mouse wheel
* Select: Shift + drag
* Copy: Ctrl+Shift+C
* Paste: Ctrl+Shift+V

## BASICS

Session vytvor v adresári projektu:

`cd ~/dev/PROJECT`

`tmux new -s PROJECT`

Session pomenuj rovnako ako projekt / agent session.

Attach obnoví existujúci shell, aktuálny adresár aj bežiaci proces.

Pád SSH alebo zatvorenie terminálu session nezabije.

Reboot VM session zruší.

## WORKFLOW

Vytvorenie:

`cd ~/dev/PROJECT`

`tmux new -s PROJECT`

Návrat:

`tmux ls`

`tmux attach -t PROJECT`

`-t` = target.

Detach bez ukončenia session:

`Ctrl+b d`

## RENAME

Zvonku:

`tmux rename-session -t OLD NEW`

Zvnútra tmux:

`Ctrl+b $`

## QUICK

* List: `tmux ls`
* New: `tmux new -s PROJECT`
* Attach: `tmux attach -t PROJECT`
* Attach short: `tmux a -t PROJECT`
* Detach: `Ctrl+b d`
* Rename: `tmux rename-session -t OLD NEW`
* Kill: `tmux kill-session -t PROJECT`

