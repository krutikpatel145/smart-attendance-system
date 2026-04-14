import os
import shutil
import socket
import subprocess
import sys
import time


ROOT = os.path.dirname(os.path.abspath(__file__))
BACKEND_DIR = os.path.join(ROOT, "backend")
FRONTEND_DIR = os.path.join(ROOT, "frontend")


def _require_command(command_name: str) -> None:
    if shutil.which(command_name) is None:
        raise RuntimeError(f"Missing required command: {command_name}")


def _is_port_in_use(port: int) -> bool:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.settimeout(0.2)
        return sock.connect_ex(("127.0.0.1", port)) == 0


def main() -> int:
    try:
        _require_command("npm")
    except RuntimeError as exc:
        print(str(exc))
        print("Install Node.js 18+ and try again.")
        return 1

    if _is_port_in_use(8000):
        print("Port 8000 is already in use. Stop the old backend process and run again.")
        return 1
    if _is_port_in_use(5173):
        print("Port 5173 is already in use. Stop the old frontend process and run again.")
        return 1

    npm_cmd = "npm.cmd" if os.name == "nt" else "npm"

    backend_cmd = [
        sys.executable,
        "-m",
        "uvicorn",
        "main:app",
        "--host",
        "127.0.0.1",
        "--port",
        "8000",
    ]
    frontend_cmd = [npm_cmd, "run", "dev", "--", "--host", "127.0.0.1", "--port", "5173"]

    print("Starting Smart Attendance System...")
    print("Frontend: https://127.0.0.1:5173")
    print("Backend:  http://127.0.0.1:8000")
    print("Press Ctrl+C to stop.")

    processes: list[subprocess.Popen] = []
    try:
        backend = subprocess.Popen(backend_cmd, cwd=BACKEND_DIR)
        processes.append(backend)
        frontend = subprocess.Popen(frontend_cmd, cwd=FRONTEND_DIR)
        processes.append(frontend)

        while True:
            if any(proc.poll() is not None for proc in processes):
                break
            time.sleep(0.5)
    except KeyboardInterrupt:
        pass
    finally:
        for proc in processes:
            if proc.poll() is None:
                proc.terminate()
        for proc in processes:
            if proc.poll() is None:
                try:
                    proc.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    proc.kill()

    if len(processes) != 2:
        return 1

    backend_code = processes[0].poll()
    frontend_code = processes[1].poll()
    if backend_code not in (0, None) or frontend_code not in (0, None):
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
