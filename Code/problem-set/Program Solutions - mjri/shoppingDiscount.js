// function that accepts a single parameter, an array
function checkout(items) {
	// variable to keep track of shoes amount
	var shoes = 0;
	// variable to keep track of hats amount
	var hats = 0;
	// variable to keep track of bags amount
	var bags = 0;
	// hat counter
	var hatCtr = 0;
	// variable to keep track of total amount
	var total = 0;

	// loops through items array
	for (i=0; i<items.length; i++) {
		// if item has description "shoes"
		if (items[i][0] == "shoes") {
			// add amount to shoes variable
			shoes += items[i][1];
		// if item has description "bag"
		} else if (items[i][0] == "bag") {
			// add amount to bag variable
			bags += items[i][1];
		// if item has description "hat"
		} else if (items[i][0] == "hat") {
			// add amount to hat variable
			hats += items[i][1];
			// increment hatCtr
			hatCtr++;
		}
	}

	// if amount of shoes is more than 100
	if (shoes > 100) {
		// take 20% off the cost of all shoes
		shoes *= .8;
	}

	// adds total
	total = shoes + hats + bags;

	// if cart contains at least two hats
	if (hatCtr > 2) {
		// take 10 off the total of the cart
		total -= 10;
	}

	// return total amount
	return(total);
}