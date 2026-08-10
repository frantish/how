# OpenCode — quick guide: sessions a parametre spustania

> Rýchlovky pre prácu s opencode (TUI). Platné pre CLI verziu.

## Session — ako to funguje

- Sessions sa **ukladajú automaticky** na disk (v `~/.local/share/opencode/`).
- **Žiadny špeciálny shutdown nie je potrebný.** Stačí `exit` a session sa uloží.
- Pozor: `opencode` **bez príznaku štartuje NOVÚ session** — na návrat treba príznak alebo `/sessions`.

## Spustanie a návrat do session

| Príkaz | Význam |
|---|---|
| `opencode` | štart nové session |
| `opencode -c` / `opencode --continue` | pokračovať v **poslednej** session |
| `opencode -s <sessionID>` | pokračovať v **konkrétnej** session |
| `opencode -c --fork` | pokračovať v poslednej, ale **forknúť** (nová vetva, pôvodná zostane) |
| `opencode <cesta>` | štart v konkrétnom projekte (napr. `opencode ~/dev/rpg`) |

## Ďalšie parametre spustania

| Príznak | Význam |
|---|---|
| `-m / --model provider/model` | zvoliť model |
| `--agent <name>` | zvoliť agenta |
| `--auto` | auto-schvaľovať povolenia (bez potvrdzovania) |
| `--prompt "..."` | poslať prompt hneď pri štarte |
| `-s --fork` | forknúť pri pokračovaní |

## TUI príkazy (`/`)

| Príkaz | Skratka | Význam |
|---|---|---|
| `/exit` (alias `/q`) | `ctrl+x q` | vypnúť (session sa uloží) |
| `/sessions` (alias `/resume`) | `ctrl+x l` | zoznam + prepínanie session |
| `/new` (alias `/clear`) | `ctrl+x n` | nová session |
| `/compact` (alias `/summarize`) | `ctrl+x c` | zvinúť kontext do zhrnutia |
| `/undo` | `ctrl+x u` | vrátiť poslednú správu + zmeny |
| `/redo` | `ctrl+x r` | vrátiť undo |
| `/export` | `ctrl+x x` | exportovať konverzáciu do Markdown |
| `/share` | — | zdieľať session odkazom |

## CLI: práca so session

```bash
opencode session list          # zoznam session (tabuľka/json)
opencode session list -n 5     # posledných 5
opencode session delete <id>   # zmazať session
opencode export <id>           # export JSON (bez id = výber)
opencode import session.json   # import JSON
opencode stats                 # tokeny / náklady
```

## Rady

- Pred vypnutím netreba nič „ukladať" — ale keď pracuješ na projekte, commitni robotu cez git (opencone necommitnuje sám).
- `/compact` sa hodí pri dlhých session — zníži kontext, hlavné fakty si ale zapisuj do `_brain/`.
- Kontext sa v session môže zvinúť aj automaticky.
