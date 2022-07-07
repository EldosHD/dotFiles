# Tmux cheat sheet

- Command mode: `C + a`
- Delete line: `C + u`

## In command mode

- Enter Copy mode: `[`
- List all Keys: `?`
- Split Vertical: `|`
- Split Horizontal: `-`
- Arrange Panes nicely: `M + 4`
- Jump to the beginning of the line: `C + a`
- New window: `c`
- Next window: `C + n`
- Previous window: `C + p`
- window number (0-9): `(0-9)`

## In Copy mode

- Search: `C + s`
- Scroll up: `C + up`
- Scroll down: `C + down`
- Scroll up half page: `M + up`
- Scroll down half page: `M + down`

## In search mode

- Next match: `n`
- Previous match: `N` // change to `p`

## config file

- `-n` flag means that the key is bound in the root tabel:
  - `bind-key C-t COMMAND` binds `C-t` to command in the prefix table (so the real keybinding is `C-a C-t`)
  - `bind-key -n C-t COMMAND` binds `C-t` to command in the root table (so the real keybinding is `C-t`)