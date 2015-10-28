# Francisco Enrique Vicente G. Castro
# Last update: 18 August 2014

# Shopping Discount

"""
An online clothing store applies discounts during checkout.
A shopping cart is a list of the items being purchased.
Each item has a description (a string like “shoes”) and a price (a real number like 12.50).
Design a program called checkout that consumes a shopping cart and 
produces the total cost of the cart after applying the following two discounts:
- if the cart contains at least 100 worth of shoes, take 20% off the cost of all shoes 
	(match only items whose exact description is “shoes”)
- If the cart contains at least two hats, take 10 off the total of the cart 
	(match only items whose exact description is “hat”)

Example: 
checkout([(“shoes”, 25), (“bag”, 50), (“shoes”, 85), (“hat”, 15)]) 
yields 153 (175 total for the cart minus 20% of 110 worth of shoes)

"""

def checkout( shoppingcart ) :

	# Initialize helper variables
	total_shoes = 0
	num_hats = 0
	cart_total = 0

	# For each item in the shopping cart
	for item in shoppingcart :
		
		# Get total of shoes for possible discount computation
		if ( item[0] == "shoes" ) :
			total_shoes += item[1]
		# Count hats for possible discount computation
		elif( item[0] == "hat" ) :
			num_hats += 1
			cart_total += item[1]
		# Add all other items to total
		else :
			cart_total += item[1]
	
	# Compute discount for total of shoes, if applicable
	if ( total_shoes >= 100 ) :
		total_shoes *= 0.80

	# Compute total of all items in cart plus discounted shoes, if applicable
	cart_total += total_shoes

	# Compute discount from hats, if applicable
	if ( num_hats >= 2 ) :
		cart_total -= 10

	return cart_total