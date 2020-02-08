/*
 * Prabhat Bhootra
 * CPSC 316
 * Assignment 7
 * 
 * n value |  threads  | time (milliseconds) | Dotproduct
 * ------------------------------------------------------------
 * 100     |     10    |          3		     |  1641750
 * 1000    |     10    |          4		     |  1664167500
 * 10000   |  	 10	   |          6		     |  1666416675000
 * 100000  |  	 10	   |          5		     |  8084210824752
 *
 * n value |  threads  | time (milliseconds) | Dotproduct
 * ------------------------------------------------------------
 * 10000   |     2     |          1		     |  1666416675000
 * 10000   |     4     |          4		     |  1666416675000
 * 10000   |  	 5	   |          2		     |  1666416675000
 * 10000   |  	100    |          25	     |  1666416675000
 */ 

public class ThreadedDotProduct extends Thread {
	private int myrank;
	private int n, t;
	private int lo, hi;
	private int[] a, b;
	private static long[] locals;
	public ThreadedDotProduct(int rank, int nVar, int tVar, int loVar, int hiVar, int[] aVar, int[] bVar) {
		this.myrank = rank;
		this.n = nVar;
		this.t = tVar;
		this.lo = loVar;
		this.hi = hiVar;
		this.a = aVar;
		this.b = bVar; 
	}

	public void run() {
        for (int i = lo; i < hi; i++) {
           locals[myrank] += a[i] * b[i];
        }
    }

	public static void add(int nVal, int tVal, int[] aArr, int[] bArr) throws InterruptedException {
		ThreadedDotProduct[] mythread = new ThreadedDotProduct[tVal];
		for (int i = 0; i < tVal; i++) {
			mythread[i] = new ThreadedDotProduct(i, nVal, tVal, (i*aArr.length)/tVal, ((i + 1)*aArr.length)/tVal, aArr, bArr);
			mythread[i].start();
		}
		for (int i = 0; i < tVal; i++) {
            mythread[i].join();
        }
	}

	public static void main(String[] args) throws InterruptedException {
		locals = new long[Integer.parseInt(args[1])];
		long dotprod = 0;
		int[] x = new int[Integer.parseInt(args[0])];
		int[] y = new int[Integer.parseInt(args[0])];
		for (int i = 0; i < Integer.parseInt(args[0]); i++) {
			x[i] = i;
			y[i] = i*5;
		}

		long start = System.nanoTime();
		add(Integer.parseInt(args[0]), Integer.parseInt(args[1]), x, y);
		for (int k = 0; k < Integer.parseInt(args[1]); k++) {
			dotprod += locals[k];
		}
		long end = System.nanoTime();
		long elapsed = (end - start) / 1000000;
		System.out.println("Execution time is " + elapsed + " milliseconds");
		System.out.println("Dotproduct = " + String.valueOf(dotprod));
	}

}