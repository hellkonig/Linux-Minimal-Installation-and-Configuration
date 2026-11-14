#!/bin/bash
# Keep Wayland's desktop theme settings consistent with the Nord GTK files.
# Use the installed Python GIO bindings; the gsettings CLI is not required.

exec python3 - <<'PY'
from gi.repository import Gio

settings = Gio.Settings.new('org.gnome.desktop.interface')
for key, value in {
    'gtk-theme': 'Nord-Darker',
    'color-scheme': 'prefer-dark',
}.items():
    if settings.get_string(key) != value and not settings.set_string(key, value):
        raise SystemExit(f'Unable to set {key} to {value}')
Gio.Settings.sync()
PY
