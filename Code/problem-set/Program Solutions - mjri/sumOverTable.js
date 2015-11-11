// function that accepts a single parameter, an array
function sumLargest(array) {
	// variable to keep track of largest sum
	var sum = 0;

	// loop through array
	for (i=0; i<array.length; i++) {
		// add largest number to sum variable
	    sum += Math.max.apply(Math, array[i]);
	}

	// return largest sum
	return(sum);
}