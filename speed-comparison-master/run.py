# run.py
import subprocess
import sys


def main(rounds="100000000", iterations=1):
    with open("src/rounds.txt", mode="w") as file:
        file.write(rounds)
    
    for i in range(int(iterations)):
        subprocess.run(["python3", "src/run_test.py"])
    
    
if __name__ == "__main__":
    args = sys.argv
    globals()[args[1]](*args[2:])