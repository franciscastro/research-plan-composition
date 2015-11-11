// function that accepts one parameter, a string
function isPalindrome(string) {
	// remove all characters that are alpha characters ([a-zA-Z]), then transforms string to lowercase
	string = string.replace(/[^a-zA-Z]/g, '').toLowerCase();
	// returns the result of palindrome checker
	return string == string.split('').reverse().join('');
}