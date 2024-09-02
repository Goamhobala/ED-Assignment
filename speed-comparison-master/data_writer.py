
from argparse import ArgumentParser
import os
import json
import pandas as pd

def main():
    parser = ArgumentParser()
    parser.add_argument(
        "--folder",
        dest="folder",
        help="Path to folder which contains JSON files.",
    )
    parser.add_argument(
        "--out",
        dest="out",
        help="Path to generate output file to.",
    )
    parser.add_argument(
        "--rounds",
        dest="rounds",
        help="Path to the rounds.txt file.",
    )

    args = parser.parse_args()

    data = {
        "name": [],
        "version": [],
        "trials": [],
        "median": [],
        "min": [],
        "max": [],
        "accuracy": [],
    }

    # r=root, d=directories, f = files
    for r, d, f in os.walk(args.folder):
        for file in f:
            if file.endswith(".json"):
                with open(os.path.join(r, file), "r") as reader:
                    # TODO: Add check if the file is formatted correctly
                    json_data = json.load(reader)
                    data["trials"].append(json_data["TimesPerRun"])
                    data["name"].append(json_data["Language"])
                    data["version"].append(json_data["Version"])
                    data["median"].append(
                        # We want milliseconds (ms) in the end
                        round(
                            pd.Timedelta(json_data["Median"]).total_seconds()
                            * 1000,
                            2,
                        )
                    )
                    data["max"].append(
                        round(
                            pd.Timedelta(json_data["Max"]).total_seconds()
                            * 1000,
                            2,
                        )
                    )
                    data["min"].append(
                        round(
                            pd.Timedelta(json_data["Min"]).total_seconds()
                            * 1000,
                            2,
                        )
                    )
                    data["accuracy"].append(round(json_data["Accuracy"], 4))
    df = pd.DataFrame(data)
    df.sort_values(by=["min"], inplace=True)

    file_base = f"combined_results"
    png = f"{file_base}.png"
    csv = f"{file_base}.csv"
    df.to_csv(
        csv,
        index=False,
        encoding="utf-8",
    )
main()