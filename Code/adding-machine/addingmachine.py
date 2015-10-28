def cleanList( numberList ):
	
	# empty list, single element case
	if ( numberList==[] or len(numberList)==1 ):
		return numberList

	# all other cases
	else:
		auxlist = []
		i = 0

		while( i < len(numberList) ):
			# (current elt is 0) and (next index not out of bounds) and (next elt is 0)
			if (  (numberList[i]==0 ) and ((i+1) != len(numberList)) and (numberList[i+1]==0) ):
				return auxlist
			else:
				auxlist.append(numberList[i])
				i += 1

		return numberList


def addingMachine( numberList ):

	cleanedList = cleanList( numberList )
	currentSum = 0
	auxlist = []

	# non-empty list
	if (cleanedList != []):

		for number in cleanedList:
			# found non-zero number
			if (number != 0):
				currentSum += number
				flagRunningSum = True
			# found zero
			else:
				auxlist.append(currentSum)
				currentSum = 0
				flagRunningSum = False

		# running sum is still present (list did not end in 0)
		if (flagRunningSum):
			auxlist.append(currentSum)

		return auxlist

	# empty list
	else:
		return cleanedList

	
# Tests for cleanList
"""
print(cleanList( [1,2,0,7,0,5,4,1,0,0,6] )) #[1,2,0,7,0,5,4,1]
print(cleanList( [] )) #[]
print(cleanList( [0,0] )) #[]
print(cleanList( [1] )) #[1]
print(cleanList( [1,2] )) #[1,2]
print(cleanList( [0] )) #[0]
print(cleanList( [0,1,2] )) #[0,1,2]
"""
# Tests for addingMachine
"""
print(addingMachine( [1,2,0,7,0,5,4,1,0,0,6] )) #[3,7,10]
print(addingMachine( [1,2,0,7,0,5,4,1,0] )) #[3,7,10]
print(addingMachine( [] )) #empty
print(addingMachine( [0, 0] )) #empty
print(addingMachine( [1] )) #[1]
print(addingMachine( [1,2] )) #[3]
print(addingMachine( [0] )) #[0]
print(addingMachine( [1,2,3,4,5,6,7] )) #[28]
"""