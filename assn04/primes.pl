# This is my first Perl program.
# Prabhat Bhootra

# Function to test whether a number n is prime
sub isPrime
{
	$n = $_[0];
	if ($n <= 3) {
		return ($n > 1);	
	} elsif ($n % 2 == 0 || $n % 3 == 0) {
		return undef;
	} else {
	        $i = 5;
		while ($i*$i <= $n){
			if ($n % $i == 0 || $n % ($i + 2) == 0){
				return undef;
			}
			$i = $i + 6;
		}
	}
	return 1;
}

# Driver part of program to print all primes less than 100
for  ($y = 1; $y <= 100; $y++) {
	if (isPrime($y)) {
		print "$y\n";
	}
}
