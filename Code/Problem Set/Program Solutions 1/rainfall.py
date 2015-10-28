# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Rainfall

"""
Design a program called rainfall that consumes a list of real numbers representing daily rainfall readings.
The list may contain the number -999 indicating the end of the data of interest.
Produce the average of the non-negative values in the list up to the first -999 (if it shows up).
There may be negative numbers other than -999 in the list (representing faulty readings).

Example: rainfall([1, -2, 5, -999, 8]) yields 3
"""

def rainfall( readings ) :

	# Initialize helper variables
	num_of_readings = len( readings )
	sum_of_readings = 0
	count = 0

	# For each item in the list of readings
	for item in readings:

		# Check if not the end of data of interest
		if ( item != -999 ) :

			# Skip faulty readings
			if ( item > -1 ) :

				# Get sum of valid readings
				sum_of_readings += item
				count += 1
		else :
			break

	# Compute average
	average = ( sum_of_readings // count )

	return average