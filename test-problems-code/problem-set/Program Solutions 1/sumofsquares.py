# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Sum of Squares

"""
Design a program sumOfSquares that consumes an integer n and produces 
the sum of the squares of all numbers from 1 through n.  
You may assume that n is at least 1.

Example: sumOfSquares(4) yields 30
"""

def sumOfSquares( n ) :

	# Initialize helper variables
	sum_of_squares = 0

	# Go through all integers from 1 until n
	for x in range( 1, ( n + 1 ) ) :
		
		# Add x^2 to the running sum
		sum_of_squares += ( x ** 2 )

	return sum_of_squares