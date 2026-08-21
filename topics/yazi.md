# YAZI

**WARNING: KEYBINDINGS ARE CUSTOMIZED.**
`Enter`, `Delete`, `Shift+Delete` a `d/D` sa správajú inak než v default Yazi.

---

INSTALL / SETUP — LMDE 6

Yazi repo:

```bash
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg \
  | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null

echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' \
  | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null

sudo chmod 644 /etc/apt/sources.list.d/yazi.list
sudo chmod 644 /usr/share/keyrings/yazi-keyring.gpg

sudo apt update
sudo apt install yazi
```

Dependencies:

```bash
sudo apt install \
  file \
  ffmpeg \
  p7zip-full \
  jq \
  poppler-utils \
  fd-find \
  ripgrep \
  fzf \
  zoxide \
  imagemagick \
  xclip
```

---

LMDE / DEBIAN FIX — fd

Debian package `fd-find` installs binary as `fdfind`, but Yazi expects `fd`.

```bash
mkdir -p ~/.local/bin
ln -s /usr/bin/fdfind ~/.local/bin/fd

command -v fd
fd --version
```

Expected:

```text
/home/hydeo/.local/bin/fd
```

---

LMDE / DEBIAN FIX — fzf

LMDE 6 repository had old `fzf 0.38.0`, which did not work correctly with current Yazi.

Install current fzf user-local:

```bash
mkdir -p ~/.local/src

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/src/fzf
~/.local/src/fzf/install --bin

ln -sf ~/.local/src/fzf/bin/fzf ~/.local/bin/fzf
hash -r

command -v fzf
fzf --version
```

`command -v fzf` should prefer:

```text
/home/hydeo/.local/bin/fzf
```

---

LMDE / DEBIAN FIX — zoxide

LMDE had ancient:

```text
zoxide v0.4.3
```

Yazi `Z` reported:

```text
No directory history found
```

even though `zoxide query -l` contained directories.

Install current zoxide:

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

hash -r

command -v zoxide
zoxide --version
```

Bash integration in `~/.bashrc`:

```bash
eval "$(zoxide init bash)"
```

Reload shell:

```bash
exec bash
```

Optional initial directories:

```bash
zoxide add /data
zoxide add /data/local
zoxide add /data/fileserver
zoxide add /data/workspace
```

Check database:

```bash
zoxide query -l
```

---

YAZI SHELL WRAPPER

In `~/.bashrc`:

```bash
# Yazi wrapper.
# Spusti Yazi a po jeho ukončení zmení aktuálny adresár shellu
# na adresár, v ktorom sme v Yazi skončili.
#
# Použitie:
#   y
#   y /nejaka/cesta
function y() {
    # Dočasný súbor, do ktorého Yazi zapíše svoj posledný working directory.
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd

    # Spusti Yazi.
    # --cwd-file spôsobí, že pri ukončení zapíše aktuálny adresár do $tmp.
    yazi "$@" --cwd-file="$tmp"

    # Načítaj adresár z dočasného súboru.
    # Ak nie je prázdny a líši sa od aktuálneho $PWD,
    # zmeň doň adresár aj v tomto shelli.
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi

    # Upratanie dočasného súboru.
    rm -f -- "$tmp"
}
```

Use:

```bash
y
```

Po `q` zostane shell v adresári, kde Yazi skončilo.

---

FLAVOR

Installed:

```text
catppuccin-macchiato
```

Install:

```bash
ya pkg add yazi-rs/flavors:catppuccin-macchiato
```

`~/.config/yazi/theme.toml`:

```toml
[flavor]
dark = "catppuccin-macchiato"
```

---

SMART ENTER PLUGIN

Default Yazi oddeľuje vstup do directory a open file.

Používame smart-enter, aby:

```text
Enter on directory  -> enter directory
Enter on file       -> open file
```

Install:

```bash
ya pkg add yazi-rs/plugins:smart-enter
```

---

CONFIG

`~/.config/yazi/yazi.toml`:

```toml
[mgr]
ratio = [1, 3, 4]

[preview]
max_width = 2000
max_height = 2000
```

Po zmene image preview limitov:

```bash
ya cache clear
```

---

CUSTOM KEYBINDINGS

`~/.config/yazi/keymap.toml`

Current custom bindings:

```toml
[mgr]

prepend_keymap = [
    # Smart Enter:
    # directory -> enter
    # file      -> open
    { on = "<Enter>",     run = "plugin smart-enter",       desc = "Enter directory or open file" },

    # Delete:
    # Delete       -> Trash
    # Shift+Delete -> permanent delete
    { on = "<Delete>",    run = "remove",                   desc = "Move to trash" },
    { on = "<S-Delete>",  run = "remove --permanently",     desc = "Delete permanently" },

    # Disable dangerous/default d / D delete bindings.
    { on = "d",           run = "noop",                     desc = "Unbound" },
    { on = "D",           run = "noop",                     desc = "Unbound" },

    # Fast paths.
    { on = [ "g", "d" ],  run = "cd /data",                 desc = "Go to /data" },
    { on = [ "g", "l" ],  run = "cd /data/local",           desc = "Go to /data/local" },
    { on = [ "g", "f" ],  run = "cd /data/fileserver",      desc = "Go to /data/fileserver" },
]
```

---

WORKSPACE

Yazi config is Workspace-managed:

```text
~/.config/yazi
    -> /data/workspace/home/.config/yazi
```

Managed path:

```text
.config/yazi
```

in:

```text
/data/workspace/home-managed.conf
```

`.bashrc` is also Workspace-managed.

After configuration changes:

```bash
workspace-git-update-home
```

If Yazi created new untracked files/packages/plugins:

```bash
workspace-git-update-all
```

---

## EVERYDAY CHEATSHEET

Start Yazi:
----------------
y

Quit and keep current directory in shell:
----------------
q

NAVIGATION
----------------

j / Down        down
k / Up          up
h / Left        parent directory
l / Right       enter directory
Enter           directory -> enter
                file      -> open
gg              top
G               bottom


FAST DIRECTORIES — CUSTOM
----------------
gd              /data
gl              /data/local
gf              /data/fileserver

SEARCH / JUMP
----------------
z               fzf search - searches files/directories.
Z               zoxide directory jump - uses learned directory history/ranking.

SELECTION
----------------
Space           select/unselect current file
v               visual selection
Ctrl+a          select all
Ctrl+r          invert selection
Esc             clear/cancel selection


COPY / MOVE
----------------
y               copy / yank
x               cut
p               paste
P               paste + overwrite

DELETE — CUSTOM
----------------
Delete          move to Trash (d - UNBOUND)
Shift+Delete    PERMANENT DELETE (D - UNBOUND)


Do not use default Yazi documentation expecting `d/D` delete on this machine.

FILES
----------------

o               open
O               open with
r               rename
a               create file

For directory creation with `a`, end name with `/`.


HELP
~              Yazi help / keybindings


