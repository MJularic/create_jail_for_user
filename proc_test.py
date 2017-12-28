import subprocess

try:
    subprocess.run(['python3'])
except:
    print("[OK] Unable to fork another process, process limiting is working!")