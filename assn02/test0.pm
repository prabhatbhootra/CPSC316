/* test0.pm -- testing elementary statements and return values from a 
 *              a function
 */

program test0
    
    f : int
    x : int
    y : int
    z : int

    procedure p(c, &d, e : int)
        a, b : int
        begin
            b = 3
            d = c + b
        end

    function q(e, f : int) : int
        a, b, i : int
        c : array[1..10] of int
        begin
            a = 0
            for i in 1..10
                a = a + i
                write("%d\n", a)
            end
            return a
        end
begin
    
    x = 10
    y = 11
    z = 34
    p(x,y,z)
    write("x = %d, y = %d, z = %d\n", x, y, z)
    write("x * y = %d\n", x*y)
    write("sum 1 thru 10 = %d\n", q(x,y))

end
