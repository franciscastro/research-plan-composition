// function that accepts a single parameter, an integer n
function sumOfSquares(n) {
	// variable to keep track of sum of squares
	var sum = 0;

	// loop from 1 to n
	for (i=1; i<=n; i++) {
		// add every "squared" amount to variable sum
		sum += i*i;
	}

	// returns the sum
	return(sum);
}