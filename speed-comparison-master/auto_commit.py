import os
import subprocess
import sys

def main(rounds, sample_size, num_samples):
	subprocess.run(f"python3 run.py main {rounds} {sample_size} {num_samples}".split())
	os.system("mv results/* data/scilabB/fifteen30")
	subprocess.run(["git", "add", "."])
	subprocess.run(["git", "commit", "-m", "Auto: Push scilab data to github"])
	subprocess.run(["git", "push", "git@github.com:Goamhobala/ED-Assignment.git"])



args = sys.argv
globals()[args[1]](*args[2:])
