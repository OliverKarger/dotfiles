import os
import shutil
import subprocess
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
    "nvim": {
        "files_base": "nvim/",
        "files": [ "init.lua" ],
        "target": {
            "windows": "appdata/local/nvim",
            "unix": ".config/nvim"
        },
        "symlinks": True
    },
    "alacritty": {
        "files_base": "alacritty/",
        "files": [ "alacritty.toml", "themes/cyberdream.toml" ],
        "target": {
            "windows": "appdata/roaming/alacritty",
            "unix":".config/alacritty"
        },
        "symlinks": True
    },
    "tmux": {
        "files_base": ".",
        "files": [ ".tmux.conf" ],
        "target": {
            "windows": "",
            "unix": "~"
        },
        "symlinks": True
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
    Path(path).mkdir(parents=True, exist_ok=True)
    print(f" + Creating Path: {path}")

def check_installed(p):
    """Checks if a Application is installed -> available in PATH"""
    if shutil.which(p) is None:
        print(f"Program {p} is not installed!")
        return False
    return True

def is_windows():
    return os.name == 'nt'

def main():
    for app in CONFIGS:

        # Ask if it should proceed
        if not prompt_yn(f"Configure {app}"):
            continue
        print(f"Configuring {app}")
        
        # Check if installed
        if not check_installed(app):
            continue
        
        # Get Platform specific Destination Path
        # If Target Path for Platform is "", skip for this Platform
        dst_p = ""
        if is_windows():
            if CONFIGS[app]["target"]["windows"] == "":
                print(f" > No Windows Configuration for {app}. Skipping.")
                continue
            dst_p = os.path.join(Path.home(), CONFIGS[app]["target"]["windows"])
        else:
            if CONFIGS[app]["target"]["unix"] == "":
                print(f" > No Unix-like Configuration for {app}. Skipping.")
                continue
            dst_p = os.path.join(Path.home(), CONFIGS[app]["target"]["unix"])

        # Make sure Path exists
        ensure_path(dst_p)

        # Local Base Path
        local_base = os.path.join(os.getcwd(), CONFIGS[app]["files_base"])
        if not os.path.exists(local_base):
            print(f" - Local Path {local_base} not found")
            continue
        
        # Loop over Files
        for file in CONFIGS[app]["files"]:
            # Full Local Path
            file_path = os.path.join(local_base, file)
            print(f" + Processing File: {file_path}")
            
            # Either create a Symlink or Copy Files
            if CONFIGS[app]["symlinks"]:
                create_symlink(file_path, os.path.join(dst_p, file))
            else:
                shutil.copyfile(file_path, os.path.join(dst_p, file))
    
if __name__ == "__main__":
    main()
