HOW: install app globally from Git - for all local users.

Notes:
  - /usr/local/bin is normally in PATH for all users.
  - Do not install separate copies into every user's ~/.local/bin.
  - Keep application files in /opt and expose only the executable via /usr/local/bin.

Install:
  sudo git clone https://github.com/frantish/how.git /opt/how
  sudo ln -s /opt/how/how /usr/local/bin/how

Update:
  cd /opt/how
  sudo git pull

Verify:
  command -v how
  ls -l /usr/local/bin/how
  how --help
