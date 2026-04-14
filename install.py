import os
import shutil
import subprocess
import sys


def _require(command_name: str, help_text: str) -> bool:
    if shutil.which(command_name) is None:
        print(f"Missing required command: {command_name}")
        print(help_text)
        return False
    return True


def main() -> int:
    if not _require("python", "Install Python 3.11+ and try again."):
        return 1
    if not _require("npm", "Install Node.js 18+ (includes npm) and try again."):
        return 1

    print("Installing backend dependencies...")
    backend_install = subprocess.run([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
    if backend_install.returncode != 0:
        return backend_install.returncode

    npm_cmd = "npm.cmd" if os.name == "nt" else "npm"

    print("Installing frontend dependencies...")
    frontend_install = subprocess.run([npm_cmd, "install", "--prefix", "frontend"])
    return frontend_install.returncode


if __name__ == "__main__":
    raise SystemExit(main())
