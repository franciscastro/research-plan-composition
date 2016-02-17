// function for rainfall problem that accepts 
// a single parameter (an array of numbers)
function rainfall(numArray) {
	
	// variable to keep track of positive #s
	var positiveCtr = 0;
	
	// variable to keep track of positive #s' sum
	var total = 0;

	// variable for computed average
	var average = 0;

	// iterate through numArray
	for (i=0; i<numArray.length; i++) {
		// returns false if number is negative
		if (numArray[i] == -999 ) {
			break;
		} else if (numArray[i] >= 0) {
			// adds positive numbers as loop iterates
			total += numArray[i];
			// increments positive num counter
			positiveCtr++;
		} 
	}

	// compute average
	average = total / positiveCtr;
	// returns average
	return(average);
}