# Variables
ARG iterations=1
ARG warmups=2
ARG timeas="second"

# Dependencies
FROM alpine:3.14 AS base
RUN apk add hyperfine

#build
FROM crystallang/crystal:1.6-alpine as builder
WORKDIR /app
# COPY ./src/rounds.txt ./


COPY  /scmeta ./
WORKDIR /app/scmeta
RUN shards install --production -v
RUN crystal build src/scmeta.cr --release --static -o bin/scmeta
COPY bin/scmeta /scmeta

# compile java using custom image
FROM eclipse-temurin:19_36-jdk-alpine
WORKDIR /app/src/
COPY /src ./
RUN javac ./leibniz.java



FROM base

RUN apk add \
    gcc \
    g++ \
    python3 \
    nodejs \
    npm \
    R \
    bash
    # && rm -rf /var/lib/apt/lists/*

# Compile the C, C++, and Java programs
WORKDIR /app/src/
COPY /src ./
RUN gcc ./leibniz.c -o leibniz -O3 -s -static -flto -march=athlon64 -mtune=generic -fomit-frame-pointer -fno-signed-zeros -fno-trapping-math -fassociative-math
RUN g++ ./leibniz.cpp -o leibniz -O3 -s -static -flto -march=athlon64 -mtune=generic -fomit-frame-pointer -fno-signed-zeros -fno-trapping-math -fassociative-math



# Bench marking

# --name="c" --lang="C (gcc)" --version="gcc --version" --cmd="./leibniz"

WORKDIR /app
ARG name="c"
ARG lang="C (gcc)"
ARG version="gcc --version"
ARG cmd="./leibniz"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta/scmeta.json ./results/c.json

# --name="cpp" --lang="C++ (g++)" --version="g++ --version" --cmd="./leibniz"
ARG name="cpp"
ARG lang="C++ (g++)"
ARG version="g++ --version"
ARG cmd="./leibniz"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta.json ./results/cpp.json

# --name="java" --lang="Java" --version="echo 19.36" --cmd="java leibniz"
ARG name="java"
ARG lang="Java"
ARG version="echo 17"
ARG cmd="java leibniz"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta/scmeta.json ./results/java.json


# --name="nodejs" --lang="Javascript (nodejs)" --version="node --version" --cmd="node leibniz.js"
ARG name="nodejs"
ARG lang="Javascript"
ARG version="node --version"
ARG cmd="node leibniz.js"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta.json ./results/nodejs.json

# --name="pypy" --lang="Python (PyPy)" --version="pypy3 --version" --cmd="pypy3 leibniz.py"

ARG name="cpython"
ARG lang="Python(cpythony)"
ARG version="python3 --version"
ARG cmd="python3 leibniz.py"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta.json ./results/pypy.json

# --name="r" --lang="R" --version="R --version" --cmd="Rscript --vanilla --default-packages=base leibniz.r"

ARG name="r"
ARG lang="R"
ARG version="R --version"
ARG cmd="Rscript --vanilla --default-packages=base leibniz.r"
RUN hyperfine "$cmd" --warmup $warmups --runs $iterations --time-unit $timeas --export-json "./hyperfine.json" --output "./pi.txt"
RUN ./scmeta --lang-name="$lang" --lang-version="$version" --hyperfine="./hyperfine.json" --pi="./pi.txt" --output="./scmeta.json" --lang-version-match-index="$index"
RUN mv ./scmeta/scmeta.json ./results/r.json



# pip install requiremnets
FROM python:3.11-slim
WORKDIR /app
COPY ./requirements.txt ./
RUN pip install -r ./requirements.txt
COPY ./*.py ./
COPY ./src/rounds.txt ./
COPY results ./
# Combine all results
CMD ["python3", "data_writer.py", "--folder" , "./results/" , "--out", "./", "--rounds", "./rounds.txt"]
# RUN python3 data_writer.py --folder ./results/ --out ./ --rounds ./rounds.txt
# COPY ./*.csv ./results/