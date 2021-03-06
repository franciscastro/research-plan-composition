# Francisco Enrique Vicente G. Castro
# Last update: 22 June 2015

# Sum over Table

"""
Assume that we represent tables of numbers as lists of rows, 
where each row is itself a list of numbers. 
The rows may have different lengths.
Design a program sumLargest that consumes a table of numbers and 
produces the sum of the largest item from each row.

Example: 
to run this program on the table shown below, use 
sumLargest([[1,7,5,3],[20],[6,9]]), which yields 36 (7 + 20 + 9)
"""

def sumLargest( table_of_numbers ) :

	# Initialize helper variables
	sum_of_largest_values = 0

	# Go through all lists of numbers
	for item in table_of_numbers :
		
		# Add the largest item to the running total
		sum_of_largest_values += max( item )

	return sum_of_largest_values

print(sumLargest( [ [1,7,5,3], [20], [6,9] ] )) #36
print(sumLargest( [ [1], [0], [-1,-4,-5] ] )) #0
print(sumLargest( [ [-1], [0,0,0], [5,5,11,10,11] ] )) #10
print(sumLargest( [ [9] ] )) #9