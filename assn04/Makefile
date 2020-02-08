# Makefile for Assignment 4
# 
# CPSC 316 Foundations of Programming Languages

OBJ = primes.ali primes.o 
GRD = Makefile primes.adb primes.f90 primes.pp primes.pl primes.php

ada: primes.adb
	gnatmake primes.adb

fortran: primes.f90
	gfortran -o primes primes.f90

pascal: primes.pp
	fpc primes.pp

perl: primes.pl
	perl primes.pl

php: primes.php
	php primes.php

clean: 
	rm -f primes ${OBJ}

grade:
	tar cvf - ${GRD} > myassn04.tar
