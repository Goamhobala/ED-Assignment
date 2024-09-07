import os
import time
import subprocess
import csv
import random


def set_up(languages):
    """Compile the code"""
    for lang in languages:
          print("setting up...")
          lang["result"] = f"../results/{lang['name']}{rounds}.csv"
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
    rounds = int(rounds) * (10**-9)
    
    for lang in languages:
        with open(lang["result"], mode= "a") as result:
            print("Testing " + lang["name"])
            start_time = time.perf_counter_ns()
            subprocess.run(f"{lang['run_env']}leibniz{lang['subscript']}".split())
            end_time = time.perf_counter_ns()
            duration = end_time - start_time
            writer = csv.writer(result)
            writer.writerow([duration * (10**-6)])
            lang['total'] += duration
     
     

def run(languages):
    os.chdir("src")
    with open("rounds.txt", mode="r") as f:
     rounds = f.read()
    # some predefined languages info
    set_up(languages)
    benchmark(rounds, languages)


        

            
        
    
