# NordVPN 

## login a exchange token
----------------------------
Po prihlásení NordVPN cez 'nordvpn login' a otvoreni URL v browsery vznikne URL:
https://nordaccount.com/.../success?exchange_token=ABC123%3D%3D&redirect_upon_open=1

Token je hodnota medzi `exchange_token=` a nasledujúcim `&`:
exchange_token=[ABC123%3D%3D]&redirect_upon_open=1

Použitie:
----------------------------
nordvpn login --callback 'nordvpn://nordaccount.com/product/nordvpn/login/success?exchange_token=ABC123%3D%3D'

Automatické vytiahnutie tokenu z URL:
url='SEM_VLOZ_CELY_LINK'
python3 -c 'import sys, urllib.parse; print(urllib.parse.parse_qs(urllib.parse.urlparse(sys.argv[1]).query)["exchange_token"][0])' "$url"

## Meshnet peers
----------------------------
Zoznam peerov
nordvpn meshnet peer list

Premenovanie peera
nordvpn meshnet peer nickname set <PEER> <NOVY_NAZOV>

Zakázanie prijímania súborov od peera
nordvpn meshnet peer fileshare deny <PEER>

<PEER> môže byť hostname, nickname, Meshnet IP alebo public key.

## Základné nastavenie
----------------------------
nordvpn set killswitch off
nordvpn set lan-discovery enable
nordvpn set meshnet on
