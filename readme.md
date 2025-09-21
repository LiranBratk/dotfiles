straight up just dotfiles for my fedora sway configuration. I hope this will work :sob:

## Dependencies (Fedora)

Only the stuff actually referenced in these dotfiles (configs + scripts). Split into required vs optional enhancements.

Required (core environment used directly in config/scripts):
```
sudo dnf install \
	sway waybar rofi kitty \                # WM, bar, launcher, terminal
	swaylock swayidle swaynag \             # lock + idle + exit prompt
	wl-clipboard cliphist wtype \           # clipboard + picker + key injection
	brightnessctl playerctl pavucontrol \   # brightness + media (MPRIS) + audio mixer GUI
	pulseaudio-utils pactl \                # volume control in scripts/config
	network-manager-tui nmtui \             # network config (Waybar module)
	blueman bluetui \                       # bluetooth manager + TUI launched from bar
	yad thunar file-roller \                # dialogs (keyhint), file manager, archive tool
	htop \                                  # launched from Waybar (cpu/memory click)
	swaybg notify-send libnotify \          # wallpaper switching + notifications
	wlogout \                               # power menu
	wlsunset \                              # night light script
	autotiling \                            # window auto-tiler (exec_always)
	jq curl sed grep findutils coreutils rsync util-linux which
```

Optional (theme/fonts/cursors & extras mentioned but not strictly needed):
```
sudo dnf install fira-code-fonts fira-sans-fonts fontawesome-6-free-fonts \
	volantes-cursors adwaita-icon-theme
```

If package names differ:
- `autotiling`: if missing in repos, use `pip install --user autotiling`.
- `bluetui`: may require `cargo install bluetui` (Rust tool) if not in Fedora.
- `volantes-cursors` might appear as `volantes-cursor-theme` or be unavailable; substitute any preferred cursor theme.

Notes:
- `notify-send` comes from `libnotify` (ensure installed for wallpaper change notifications).
- Ensure your user can modify backlight (often group `video` or udev rule).
- If you prefer a lighter base, you can drop anything you don’t personally launch (e.g., `thunar`, `file-roller`, `wlogout`).

Minimal bare essentials (just to make the bar + scripts not error):
```
sudo dnf install sway waybar rofi kitty wl-clipboard cliphist wtype brightnessctl playerctl pavucontrol pulseaudio-utils swaylock swayidle yad jq curl grep sed coreutils findutils
```

Full list of everything installed on my machine when exporting these configs lives in `full_package_list.txt` (not all needed, just reference).

Apply the dotfiles:

```
./apply_configs.sh
```

After applying, sway reload and waybar restart are triggered automatically.
