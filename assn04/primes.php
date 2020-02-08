<?php
/* This is my first PHP program. */
/* Prabhat Bhootra */

/* Function to check whether a number n is prime */
function isPrime($n) {
	if ($n <= 3){
		return ($n > 1);
	} elseif (($n % 2) == 0 || ($n % 3) == 0) {
		return false;
	} else {
		$i = 5;
		while ($i*$i <= $n) {
			if (($n % $i) == 0 || ($n % ($i + 2)) == 0) {
				return false;
			}
			$i = $i + 6;
		}
		return true;
	}
}

/* Driver part of program to print all primes less than 100 */
foreach (range(1, 100) as $x) {
	if (isPrime($x)) {
		echo "$x\n";
	}
}
?>
