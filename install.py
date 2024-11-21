import sys
import os
import shutil
from pathlib import Path

"""
How this Works:
    The "CONFIGS" Object contains 3 Settings for each Application:
        - files_base 
            Starting Directory / Base Directory for "files"
        - files
            All Files that shall be copied, based on files_base
        - target
            The Target Directory
        - symlinks
            Use symlinks instead of copy
"""

CONFIGS = {
    "zsh": {
        "files_base": ".",
        "files": [
            ".zshrc"
        ],
        "target": {
            "windows": "@none",
            "unix": "."
        },
        "symlinks": True,
        "post_install": {
            "windows": [],
            "unix": []
        }
    },
    "nvim": {
        "files_base": "nvim/",
        "files": [ 
            "lua/shared.lua",
            "lua/utils.lua",
            "lua/settings.lua",
            "lua/lualine_config.lua",
            "lua/ui_config.lua",
            "lua/spectre_config.lua",
            "lua/telescope_config.lua",
            "lua/mason_config.lua",
            "lua/lsp_config.lua",
            "lua/dap_config.lua",
            "lua/dotnet_debug.lua",
            "lua/tasks.lua",
            "lua/formatting.lua",
            "init.lua" 
        ],
        "target": {
            "windows": "appdata/local/nvim",
            "unix": ".config/nvim"
        },
        "symlinks": True,
        "post_install": {
            "windows": [ "nvim +PackerSync" ],
            "unix": [ "nvim +PackerSync" ]
        } 
    },
    "alacritty": {
        "files_base": "alacritty/",
        "files": [ "alacritty.toml", "themes/cyberdream.toml" ],
        "target": {
            "windows": "appdata/roaming/alacritty",
            "unix":".config/alacritty"
        },
        "symlinks": True,
        "post_install": {
            "windows": [],
            "unix": []
        }
    },
    "tmux": {
        "files_base": ".",
        "files": [ ".tmux.conf" ],
        "target": {
            "windows": "@none",
            "unix": ""
        },
        "symlinks": True,
        "post_install": {
            "windows": [],
            "unix": []
        }
    },
    "spacenavd": {
        "files_base": ".",
        "files": [ "spnavrc" ],
        "target": {
            "windows": "@none",
            "unix": "/etc"
        },
        "symlinks": True,
        "post_install": {
            "windows": [],
            "unix": [ "systemctl restart spacenavd" ]
        }
    },
    "neofetch": {
        "files_base": "neofetch/",
        "files": [ "config.conf" ],
        "target": {
            "windows": "@none",
            "unix": ".config/neofetch"
        },
        "symlinks": True,
        "post_install": {
            "windows": [],
            "unix": []
        }
    }
}

def prompt_yn(message):
    """Prompts for a y/n Message"""
    response = input(f"{message} (y/n): ").strip().lower()
    return response == 'y'

def create_symlink(s, d):
    """Creates Symlink from s->d"""
    d = Path(d)
    if d.exists() or d.is_symlink():
        d.unlink()
    os.symlink(s, d)
    print(f" + Created Symlink: {s}<=>{d}")

def ensure_path(path):
    """Ensures a Directory Path exists"""
    dir_path = os.path.dirname(path)
    Path(dir_path).mkdir(parents=True, exist_ok=True)
    print(f" + Creating Path: {path}")

def check_installed(p):
    """Checks if a Application is installed -> available in PATH"""
    if shutil.which(p) is None:
        print(f"Program {p} is not installed!")
        return False
    return True

def is_windows():
    return os.name == 'nt'

def install(app, headless = False, install_check = False):
    # Ask if it should proceed
    if not headless:
        if not prompt_yn(f"Configure {app}"):
            return
    print(f"Configuring {app}")
   
    # Check if installed
    if install_check:
        if not check_installed(app):
            return
    
    # Get Platform specific Destination Path
    # If Target Path for Platform is "", skip for this Platform
    dst_p = ""
    if is_windows():
        if CONFIGS[app]["target"]["windows"] == "@none":
            print(f" > No Windows Configuration for {app}. Skipping.")
            return
        dst_p = os.path.join(Path.home(), CONFIGS[app]["target"]["windows"])
    else:
        if CONFIGS[app]["target"]["unix"] == "@none":
            print(f" > No Unix-like Configuration for {app}. Skipping.")
            return
        dst_p = os.path.join(Path.home(), CONFIGS[app]["target"]["unix"])

    # Make sure Path exists
    ensure_path(dst_p)

    # Local Base Path
    local_base = os.path.join(os.getcwd(), CONFIGS[app]["files_base"])
    if not os.path.exists(local_base):
        print(f" - Local Path {local_base} not found")
        return
   
    # Post Install Commands
    post_install = []
    if is_windows():
        post_install = CONFIGS[app]["post_install"]["windows"]
    else:
        post_install = CONFIGS[app]["post_install"]["unix"]

    # Loop over Files
    for file in CONFIGS[app]["files"]:
        # Full Local Path
        full_src_path = os.path.join(local_base, file)
        full_dst_path = os.path.join(dst_p, file)
        
        print(f" + Processing File: {file}")

        ensure_path(full_dst_path)

        try:
            # Either create a Symlink or Copy Files
            if CONFIGS[app]["symlinks"]:
                create_symlink(full_src_path, full_dst_path)
            else:
                shutil.copyfile(full_src_path, full_dst_path)
        except PermissionError:
            print(f" - Permission Error while processing {file}")
            continue

    if post_install == []:
        print(f"No Post-Install Commands for {app}. Skipping.")
        return

    for pic in post_install:
        print(f" + Executing Post Install Command: {pic}")
        os.system(pic)


def main():

    def interactive():
        for app in CONFIGS:
            install(app)

    def headless():
        for arg in sys.argv:
            if CONFIGS.__contains__(arg):
                install(arg, True, False)

    if len(sys.argv) == 1:
        interactive()
    else:
        headless()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        exit()
