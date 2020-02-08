/*
 * Prabhat Bhootra
 * CPSC 316
 * Assignment 7
 * 
 * n value   | time (milliseconds) | Dotproduct
 * ----------------------------------------------------
 * 100       |          0		   |  1641750
 * 1000      |          0		   |  1664167500
 * 10000     |          0		   |  1666416675000
 * 100000    |          3		   |  8084210824752
 */

import java.lang.*;

public class DotProduct {
	public static void main(String[] args) {
		long dotprod = 0;
		int n = Integer.parseInt(args[0]);
		int[] x = new int[n];
		int[] y = new int[n];

		long start = System.nanoTime();
		for (int i = 0; i < n; i++) {
			x[i] = i;
			y[i] = i*5;
			dotprod += x[i]*y[i];
		}
		long end = System.nanoTime();
		long elapsed = (end - start) / 1000000;
		System.out.println("Execution time is " + elapsed + " milliseconds");
		System.out.println("Dotproduct = "+ String.valueOf(dotprod));
	}
}