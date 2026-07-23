#!/bin/bash
# Link the version-controlled user.js into Firefox's install-selected profiles.

set -u

FIREFOX_ROOT="${FIREFOX_ROOT:-$HOME/.mozilla/firefox}"
PROFILES_INI="$FIREFOX_ROOT/profiles.ini"
SOURCE="${XDG_CONFIG_HOME:-$HOME/.config}/firefox/user.js"

if [ ! -f "$PROFILES_INI" ]; then
    echo "Firefox profiles file not found: $PROFILES_INI" >&2
    exit 1
fi

if [ ! -f "$SOURCE" ]; then
    echo "Managed user.js not found: $SOURCE" >&2
    echo "Run: stow -t ~ firefox" >&2
    exit 1
fi

mapfile -t relative_profiles < <(
    awk -F= '
        function flush_profile() {
            if (in_profile && relative == "1" && path != "") print path
        }
        /^\[/ {
            flush_profile()
            in_profile = ($0 ~ /^\[Profile[0-9]+\]$/)
            path = ""
            relative = ""
            next
        }
        in_profile && $1 == "Path" { path = substr($0, index($0, "=") + 1) }
        in_profile && $1 == "IsRelative" { relative = $2 }
        END { flush_profile() }
    ' "$PROFILES_INI"
)

mapfile -t selected_profiles < <(
    awk -F= '
        /^\[Install[^]]+\]$/ { in_install = 1; next }
        /^\[/ { in_install = 0; next }
        in_install && $1 == "Default" {
            print substr($0, index($0, "=") + 1)
        }
    ' "$PROFILES_INI" | awk '!seen[$0]++'
)

if [ "${#selected_profiles[@]}" -eq 0 ]; then
    mapfile -t selected_profiles < <(
        awk -F= '
            function flush_profile() {
                if (in_profile && is_default == "1" && path != "") print path
            }
            /^\[/ {
                flush_profile()
                in_profile = ($0 ~ /^\[Profile[0-9]+\]$/)
                path = ""
                is_default = ""
                next
            }
            in_profile && $1 == "Path" {
                path = substr($0, index($0, "=") + 1)
            }
            in_profile && $1 == "Default" { is_default = $2 }
            END { flush_profile() }
        ' "$PROFILES_INI"
    )
fi

if [ "${#selected_profiles[@]}" -eq 0 ]; then
    echo "No default Firefox profile found in $PROFILES_INI" >&2
    exit 1
fi

installed=0
for profile in "${selected_profiles[@]}"; do
    known=0
    for relative_profile in "${relative_profiles[@]}"; do
        if [ "$profile" = "$relative_profile" ]; then
            known=1
            break
        fi
    done

    if [ "$known" -ne 1 ]; then
        echo "Refusing unlisted or non-relative profile path: $profile" >&2
        exit 1
    fi

    destination="$FIREFOX_ROOT/$profile/user.js"
    if [ -e "$destination" ] || [ -L "$destination" ]; then
        if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$SOURCE" ]; then
            echo "Already installed: $destination"
            continue
        fi

        echo "Refusing to replace existing file: $destination" >&2
        exit 1
    fi

    ln -s "$SOURCE" "$destination"
    echo "Installed: $destination -> $SOURCE"
    installed=$((installed + 1))
done

if [ "$installed" -gt 0 ]; then
    echo "Restart Firefox to apply the preferences."
fi
