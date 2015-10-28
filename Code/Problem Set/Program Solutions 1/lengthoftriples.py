# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Length of Triples

"""
Design a program called maxTripleLength that consumes a list of strings and 
produces the length of the longest concatenation of three consecutive elements.
Assume the input contains at least three strings.

Example: 
maxTripleLength([“a”, “bb”, “c”, “dd”]) yields 5 (from “bb”, “c”, and “dd”)
"""

def maxTripleLength( list_of_strings ) :

	# Initialize helper variables
	longest_concatenation = 0
	count = 0

	# Loop through the list of strings
	while ( ( count+2 ) < len( list_of_strings ) ) :
		
		# Compute the length of consecutive elements
		length = len( list_of_strings[count] ) + len( list_of_strings[count+1] ) + len( list_of_strings[count+2] )

		# If computed length is greater than the current longest concatenated length
		if ( length > longest_concatenation ) :
			longest_concatenation = length

		# Update count to move to next set of three strings
		count += 1

	return longest_concatenation