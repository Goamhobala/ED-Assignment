# run.py
import os
import time
import subprocess
import csv
import random
import sys


def set_up(languages):
    """Compile the code"""

    for lang in languages:
          print(f"setting up {lang['name']}...")
          lang["total"] = 0
          if lang["compile"] != "":
              subprocess.run(lang["compile"].split())
          if lang["warmup"] == True:
              print("Warming up " + lang["name"]) 
              for i in range(3):
                  "warm up the code to get more accurate results"
                  subprocess.run(f"{lang['run_env']}leibniz{lang['subscript']}".split())
              print("Done warming up " + lang["name"])
          

def benchmark(rounds, languages=list):
    """Perform benchmarking for each language in the languages list"""
    for lang in languages:
        lang["result"] = f"../results/{lang['name']}{rounds}.csv"
        with open(lang["result"], mode= "a") as result:
            print("Testing " + lang["name"])
            start_time = time.perf_counter_ns()
            subprocess.run(f"{lang['run_env']}leibniz{lang['subscript']}".split())
            end_time = time.perf_counter_ns()
            duration = (end_time - start_time) * (10**-6)
            writer = csv.writer(result)
            writer.writerow([duration])
            lang['total'] += duration

def run(languages, rounds="100000000", sample_size=10):
    rounds = int(rounds) * (10**-6)
    # randomising order
    random.shuffle(languages)
    
    for i in range(int(sample_size)):
        benchmark(rounds, languages)
    
    # writing mean values
    for lang in languages:
        lang["mean"] = lang["total"] / int(sample_size)
        with open(f"../results/avg_{lang['name']}_{rounds}.csv", mode= "a") as result: 
            writer = csv.writer(result)
            writer.writerow([lang["mean"]])
            # reinitialise total
            lang["total"] = 0
        
def main(rounds="100000000", sample_size=10, num_samples=1):
    
    c = {"name" : "c",
         "compile": "gcc leibniz.c -o leibnizc -O0 ",
         "warmup": True,
         "run_env": "./",
         "subscript": "c"}
    cpp = {"name" : "cpp",
         "compile": "g++ leibniz.c -o leibnizcpp -O0 -std=c++11",
         "warmup": True,
         "run_env": "./",
         "subscript": "cpp"}
    java = {"name" : "java",
         "compile": "javac leibniz.java",
         "warmup": True,
         "run_env": "java ",
         "subscript": ".java"}
    javascript = {"name" : "javascript",
         "compile": "",
         "warmup": True,
         "run_env": "node ",
         "subscript": ".js"}
    python = {"name" : "python",
         "compile": "",
         "warmup": False,
         "run_env": "python3 ",
         "subscript": ".py"}
    r = {"name" : "r",
         "compile": "",
         "warmup": False,
         "run_env": "Rscript ",
         "subscript": ".r"}
    php = {"name" : "php",
         "compile": "",
         "warmup": True,
         "run_env": "php ",
         "subscript": ".php"}
    ruby = {"name" : "ruby",
         "compile": "",
         "warmup": False,
         "run_env": "ruby ",
         "subscript": ".rb"}
    
    #languages = [c, cpp, java, ruby, python, r]
    languages = [c, cpp]
    os.chdir("src")
    set_up(languages)
    for i in range(int(num_samples)):
        print(f"Sample  {i}..." )
        run(languages, rounds, sample_size)

    
if __name__ == "__main__":
    args = sys.argv
    globals()[args[1]](*args[2:])
