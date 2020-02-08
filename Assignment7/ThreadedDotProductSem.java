/*
 * Prabhat Bhootra
 * CPSC 316
 * Assignment 7
 * 
 * n value |  threads  | time (milliseconds) | Dotproduct
 * ------------------------------------------------------------
 * 100     |     10    |          3		     |  1641750
 * 1000    |     10    |          4		     |  1664167500
 * 10000   |  	 10	   |          4		     |  1666416675000
 * 100000  |  	 10	   |          6		     |  8084210824752
 *
 * n value |  threads  | time (milliseconds) | Dotproduct
 * ------------------------------------------------------------
 * 10000   |     2     |          2		     |  1666416675000
 * 10000   |     4     |          9		     |  1666416675000
 * 10000   |  	 5	   |          3		     |  1666416675000
 * 10000   |  	100    |          44	     |  1666416675000
 */

import java.util.concurrent.Semaphore;

public class ThreadedDotProductSem extends Thread {
	private int n, t;
	private int lo, hi;
	private int[] a, b;
	public static volatile long dotprod;
	private static Semaphore semaphore;
	public ThreadedDotProductSem(int nVar, int tVar, int loVar, int hiVar, int[] aArr, int[] bArr) {
		this.n = nVar;
		this.t = tVar;
		this.lo = loVar;
		this.hi = hiVar;
		this.a = aArr;
		this.b = bArr;
		semaphore = new Semaphore(1);
	}

	public void run() {
		long mydotprod = 0;
        for (int i = lo; i < hi; i++) {
            mydotprod += a[i] * b[i];
        }
        try {
        	semaphore.acquire();
        	dotprod += mydotprod;
        	semaphore.release();
        }
        catch (InterruptedException exc) {
            System.out.println(exc); 
        }
    }

	public static void add(int nVal, int tVal, int[] aArr, int[] bArr) throws InterruptedException {
		ThreadedDotProductSem[] mythread = new ThreadedDotProductSem[tVal];
		for (int i = 0; i < tVal; i++) {
			mythread[i] = new ThreadedDotProductSem(nVal, tVal, (i*aArr.length)/tVal, ((i + 1)*aArr.length)/tVal, aArr, bArr);
			mythread[i].start();
		}
		for (int i = 0; i < tVal; i++) {
            mythread[i].join();
        }
	}

	public static void main(String[] args) throws InterruptedException {
		int[] x = new int[Integer.parseInt(args[0])];
		int[] y = new int[Integer.parseInt(args[0])];
		for (int i = 0; i < Integer.parseInt(args[0]); i++) {
			x[i] = i;
			y[i] = i*5;
		}

		long start = System.nanoTime();
		add(Integer.parseInt(args[0]), Integer.parseInt(args[1]), x, y);
		long end = System.nanoTime();
		long elapsed = (end - start) / 1000000;
		System.out.println("Execution time is " + elapsed + " milliseconds");
		System.out.println("Dotproduct = " + String.valueOf(dotprod));
	}
}