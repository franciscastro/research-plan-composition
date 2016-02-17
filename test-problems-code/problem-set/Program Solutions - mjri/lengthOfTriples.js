function maxTripleLength(array) {
	// variable to keep track of max triple length
	var maxLength = 0;

	// loop through array
	for (i=0; i+2<array.length; i++) {
		// variable length that resets every iteration
		var length = 0;

		// gets total length of three consecutive elements
		length = array[i].length + array[i+1].length + array[i+2].length;

		// determines maxLength
		if (length > maxLength) {
			maxLength = length;
		}
	}

	// return max triple length
	return(maxLength);
}