import os
import subprocess
import sys

def main(rounds, sample_size, num_samples, machine):
	subprocess.run(f"python3 run.py main {rounds} {sample_size} {num_samples}".split())
	subprocess.run(["git", "pull"])
	os.system(f"mkdir data/{machine}")
	os.system(f"mkdir data/{machine}/fifteen30")
	os.system(f"mv results/* data/{machine}/fifteen30")
	subprocess.run(["git", "add", "."])
	subprocess.run(["git", "commit", "-m", f"Auto: Push {machine}'s data to github"])
	subprocess.run(["git", "push", "git@github.com:Goamhobala/ED-Assignment.git"])



args = sys.argv
globals()[args[1]](*args[2:])
