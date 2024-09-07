### What this test is about
This test suite benchmarks the performance of various programming languages. This is done by measuring the time taken for each language to approximate $\pi$ using Leibniz's formula up to a very large term.
The formula is given as follows:

$$
\pi = 4 \left( 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} ±... \right) = \sum_{k=0}^{\infty}\frac{(-1)^k}{2k+1}
$$

### How to run
To run the code, the user will need to first have the following dependencies installed:
```
sudo apt-get install g++
sudo apt-get install gcc
sudo apt-get install python3
sudo apt-get install java
sudo apt-get install ruby
sudo apt-get install r
```

Note: For Windows user, please install <a href="https://cygwin.com/">cygwin</a> instead, and have the following pacakages selected when running the installer. Afterwards, in cygwin, change directory to speed-comparison-master then run the commands below
* gcc-core
* gcc-g++
* python3
* ruby
* R
* git

```python
python3 run.py main $rounds $sample_size %number_of_samples
# Where rounds is the number of times the Leibniz's formula  is applied and sample_size the number of trials to perform for each sample
# for example
python3 run.py main 1000000000 5 20
# This will benchmark 10 performances of the code when applying the leibniz formula a billion times
```