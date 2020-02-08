! This my Fortran program
! Prabhat Bhootra      
program Primes

   ! Driver program to print all primes less than 100
   integer :: x
   do x = 1, 100, 1
      if (isPrime(x)) then
        print *, x
      end if
   end do
contains

! Function to check whether a number n is prime
function isPrime(n) result(val)
   integer, intent(IN) :: n
   logical :: val
   integer :: i
   if (n .LE. 3) then
      if (n .EQ. 1) then
         val = .FALSE.
         return
      else
         val = .TRUE.
         return
      end if
   else if (mod(n,2) == 0 .OR. mod(n,3) == 0) then
      val = .FALSE.
      return 
   end if
   i = 5
   do while (i*i <= n)
      if (mod(n, i) == 0 .OR. mod(n, i + 2) == 0) then
         val = .FALSE.
         return
      end if
      i = i + 6
   end do
   val = .TRUE.
end function

end program Primes
