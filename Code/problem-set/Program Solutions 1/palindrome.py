# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Palindrome Detection Modulo Spaces and Capitalization

"""
A palindrome is a string with the same letters in each of forward and reverse order (ignoring capitalization).
Design a program called isPalindrome that consumes a string and produces a boolean indicating whether the string 
with all spaces and punctuation removed is a palindrome.  
Treat any character other than a letter or digit as punctuation.

Example:
isPalindrome(“a man, a plan, a canal: Panama”) yields true.
isPalinidrome(“abca”) yields false
"""

import re

def isPalindrome( stringinput ) :

	# Remove spaces and punctuation, convert all to lowercase
	clean_string = re.sub( '[.,;:!?@#$% ]', '', stringinput.lower() )
	
	# Check string against its reverse
	if ( clean_string == clean_string[::-1] ) :
		return True
	else :
		return False