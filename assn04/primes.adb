-- This is my first Ada program.
-- Prabhat Bhootra

with Ada.Text_IO; use Ada.Text_IO;

procedure Primes is
   -- Function to check if a number n is prime
   function isPrime (n : Integer) return Boolean is
      i : Integer := 5;
      Result : Boolean := True;
   begin
      if n <= 3 then
         if n = 1 then
            Result := False;
         else
            Result := True;
         end if;
      elsif n mod 2 = 0 or n mod 3 = 0 then
         Result := False;
      end if;
      while i*i <= n loop
         if n mod i = 0 or n mod (i + 2) = 0 then
            Result := False;
            exit;
         end if;
         i := i + 6;
      end loop;
      return Result;
   end isPrime;

--Driver to print primes less than 100
begin
   for X in 1 .. 100 loop
      if isPrime(X) then
         Put_Line (Integer'Image(X));
      end if;
   end loop;
end Primes;
