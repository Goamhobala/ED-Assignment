### What this test is about
This test suite benchmarks the performance of various programming languages. This is done by measuring the time taken for each language to approximate $\pi$ using Leibniz's formula up to a very large term.
The formula is given as follows:

$$
\pi = 4 \left( 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} ±... \right) = \sum_{k=0}^{\infty}\frac{(-1)^k}{2k+1}
$$

### How to run
To run the code, the user will need to first have the following dependencies installed:
```
sudo apt install g++
sudo apt install gcc
sudo apt install python3
sudo apt install java
sudo apt install php
sudo apt install r
```

Note: For Windows user, please install <a href="https://cygwin.com/">cygwin</a> instead, and have the below pacakages selected when running the installer. Then, run the below command in cygwin.
* gcc-core
* gcc-g++
* php
* python3
* php
* R
* git

```python
python3 run.py main $times
# Where times is the number of times the Leibniz's formula  is applied
# for example
python3 run.py main 1000000000
# This will benchmark the code performance when applying the leibniz formula a billion times
```
