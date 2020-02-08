(* This is my first Pascal program. *)
(* Prabhat Bhootra *)
Program Hello;

(* Function to check if a number n is prime *)
function isPrime(n: integer): boolean;
var
	i: integer;
begin
	if n <= 3 then
		isPrime := (n > 1)
	else if (n mod 2 = 0) or (n mod 3 = 0) then
		isPrime := false
	else begin
		i := 5;
		while i*i <= n do begin
			if (n mod i = 0) or (n mod (i + 2) = 0) then begin
				isPrime := false;
				exit
			end;
			i := i + 6
		end;
		isPrime := true
	end;
end;

(* Driver of program to print all primes less than 100 *)
var
	x: integer;
Begin

	(* Writeln('Hello, World!'); *)
	for x := 1 to 100 do begin
		if (isPrime(x)) then
			Writeln(x)
	end;
End.
