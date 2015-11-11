# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Tester program for the Plan-Composition Study Problems

from rainfall import rainfall
from palindrome import isPalindrome
from shoppingdiscount import checkout
from sumofsquares import sumOfSquares
from sumovertable import sumLargest
from lengthoftriples import maxTripleLength

print( rainfall( [1, -2, 5, -999, 8] ) )

print()

print( isPalindrome( "a man, a plan, a canal: Panama" ) )
print( isPalindrome( "abca" ) )

print()

print( checkout( [ ("shoes", 25), ("bag", 50), ("shoes", 85), ("hat", 15) ] ) )

print()

print( sumOfSquares( 4 ) )

print()

print( sumLargest( [ [1,7,5,3], [20], [6,9] ] ) )

print()

print( maxTripleLength( ["a", "bb", "c", "dd"] ) )