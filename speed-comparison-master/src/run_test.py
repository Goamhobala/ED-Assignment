import os
import time
import subprocess
import csv
import random


def set_up(languages):
    """Compile the code"""
    for lang in languages:
        if lang["compile"] != "":
            subprocess.run(lang["compile"].split())

def benchmark(rounds, languages=list):
    """Perform benchmarking for each language in the languages list"""
    rounds = int(rounds) * (10**-9)
    
    for lang in languages:
        lang["result"] = f"../results/{lang['name']}{rounds}.csv"
        if lang["warmup"] == True:
            print("Warming up " + lang["name"]) 
            for i in range(3):
                "warm up the code to get more accurate results"
                subprocess.run(f"{lang['run_env']}leibniz{lang['subscript']}".split())
            print("Done warming up " + lang["name"])
        with open(lang["result"], mode= "a") as result:
            print("Testing " + lang["name"])
            start_time = time.perf_counter_ns()
            subprocess.run(f"{lang['run_env']}leibniz{lang['subscript']}".split())
            end_time = time.perf_counter_ns()
            duration = end_time - start_time
            writer = csv.writer(result)
            writer.writerow([duration * (10**-6)])
            

def main(rounds):
    os.chdir("src")
    # some predefined languages info
    c = {"name" : "c",
         "compile": "gcc leibniz.c -o leibnizc -O3 ",
         "warmup": True,
         "run_env": "./",
         "subscript": "c"}
    cpp = {"name" : "cpp",
         "compile": "g++ leibniz.c -o leibnizcpp -O3 -std=c++11",
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
    
    languages = [c, cpp, java, ruby, python, r]
    # randomising order
    random.shuffle(languages)
    set_up(languages)
    benchmark(rounds, languages)


with open("src/rounds.txt", mode="r") as f:
     rounds = f.read()
     
main(rounds)
        

            
        
    
