# dotfiles

## Fixes

### `spnavd.log`: `found X socket yet failed to connect`
1. Find Display: `echo $DISPLAY`
2. Open spacenavd.service for editing: `sudo vim /usr/share/lib/systemd/system/spacenavd.service`
3. Add Line to `[Service]` Section: `Environment=DISPLAY=<YOUR DISPLAY VALUE>`
