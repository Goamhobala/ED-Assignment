# Compiler and Interpreter commands
CC = gcc
CXX = g++
PYTHON = python3
JAVA = javac
NODE = node
DOTNET = dotnet
RSCRIPT = Rscript

# Executable names
C_EXEC = leibniz_c
CPP_EXEC = leibniz_cpp
JAVA_EXEC = Leibniz
CS_EXEC = bin/Debug/net6.0/leibniz.dll

# Targets
all: $(C_EXEC) $(CPP_EXEC) $(JAVA_EXEC) leibniz.py leibniz.js leibniz.csproj leibniz.r

$(C_EXEC): leibniz.c
	$(CC) leibniz.c -o $(C_EXEC)

$(CPP_EXEC): leibniz.cpp
	$(CXX) leibniz.cpp -o $(CPP_EXEC)

$(JAVA_EXEC): leibniz.java
	$(JAVA) leibniz.java

leibniz.py: leibniz.py
	@echo "Running Python script..."
	$(PYTHON) leibniz.py

leibniz.js: leibniz.js
	@echo "Running JavaScript script..."
	$(NODE) leibniz.js

leibniz.csproj: leibniz.csproj
	@echo "Running C# project..."
	$(DOTNET) run --project leibniz.csproj

leibniz.r: leibniz.r
	@echo "Running R script..."
	$(RSCRIPT) leibniz.r

clean:
	rm -f $(C_EXEC) $(CPP_EXEC) $(JAVA_EXEC) $(CS_EXEC) *.class