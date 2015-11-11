# this is student's solution
import my-gdrive("palindrome.arr") as st-palindrome
import my-gdrive("sum.arr") as st-sum
import my-gdrive("adding.arr") as st-adding

is-palindrome = st-palindrome.is-palindrome
sum-largest = st-sum.sum-largest
adding-machine = st-adding.adding-machine

#########################################################
# Palindrome Detection Modulo Spaces and Capitalization #
#########################################################

# Phrase input

check "palindrome: Non-matching punctuation and capitalization":
  is-palindrome("Are we not drawn onward, we few, drawn onward to new era?") is true
  is-palindrome("Try to say: Bucky! the Bucktooth Bunny!") is false
end

check "palindrome: Matching punctuation, non-matching capitalization":
  is-palindrome("?Are, we not; drawn onward we few drawn onward ;to new ,era?") is true
end

check "palindrome: Non-matching punctuation, matching capitalization":
  is-palindrome("Are We not Drawn onward, We feW, drawn onwarD to neW erA?") is true
end

check "palindrome: Matching punctuation and capitalization":
  is-palindrome("?Are, We not; Drawn onward We feW drawn onwarD ;to neW ,erA?") is true
end

# Single-word input

check "palindrome: Non-matching punctuation and capitalization":
  is-palindrome("Kayak!") is true
  is-palindrome("Abca!") is false
end

check "palindrome: Matching punctuation, non-matching capitalization":
  is-palindrome("!Ka-y-ak!") is true
  is-palindrome("!Ab-ca!") is false
end

check "palindrome: Non-matching punctuation, matching capitalization":
  is-palindrome("KaYaK!") is true
  is-palindrome("A-bcA!") is false
end

check "palindrome: Matching punctuation and capitalization":
  is-palindrome("!Ka-Y-aK!") is true
  is-palindrome("!Ab-cA!") is false
end

check "palindrome: All punctuation":
  is-palindrome("!@#$%:,") is true
end


##################
# Sum Over Table #
##################

check "sum: No duplicate elements in rows (all +, all -, mixed)":
  sum-largest([list: [list: 1,7,5,3], [list: 20], [list: 6,9] ]) is 36
  sum-largest([list: [list: -1,-7,-5,-3], [list: -20], [list: -6,-9] ]) is -27
  sum-largest([list: [list: 1,7,-5,3], [list: 20], [list: 6,-9] ]) is 33
end

check "sum: With duplicate elements in rows (all +, all -, mixed)":
  sum-largest([list: [list: 1,7,5,7], [list: 20], [list: 6,9,6] ]) is 36
  sum-largest([list: [list: -1,-7,-5,-7], [list: -20], [list: -6,-9,-6] ]) is -27
  sum-largest([list: [list: 1,7,-5,7], [list: 20], [list: 6,-9,-9] ]) is 33
end

check "sum: All single element rows":
  sum-largest([list: [list: 7], [list: 20], [list: 9] ]) is 36
  sum-largest([list: [list: -7], [list: -20], [list: -9] ]) is -36
  sum-largest([list: [list: 7], [list: 20], [list: -9] ]) is 18
end

check "sum: All zero-valued element rows":
  sum-largest([list: [list: 0,0,0,0], [list: 0], [list: 0,0] ]) is 0
end

##################
# Adding Machine #
##################

# Regular input

check "adding: No special case":
  adding-machine([list: 1,2,0,7,0,5,4,1,0,0,6]) is [list: 3,7,10]
  adding-machine([list: 8,5,-3,0,2,6,5,0,1,19,-9,4,0,9,3,4,7,6,0,0,12,3,4,7,0,-8,-13,4,13,4]) is [list: 10,13,15,29]
end

check "adding: Has sublist that sums to zero":
  adding-machine([list: 8,-13,-4,13,-4,0,2,6,3,5,0,1,19,9,4,0,0,12,3,4,7,0]) is [list: 0,16,33]
  adding-machine([list: 7,4,3,11,0,2,6,0,8,-13,-4,13,-4,0,9,3,4,7,6,0,0,12,3,4,7,0,16,4,7]) is [list: 25,8,0,29]
end

check "adding: Input starts with 0 delimiter":
  adding-machine([list: 0,4,-3,0,2,-5,0,0,5,8,3]) is [list: 1,-3]
  adding-machine([list: 0,1,2,0,7,0,5,4,1,0,0,6]) is [list: 3,7,10]
end

check "adding: Input starts with 0 delimiter with sublist that sums to zero":
  adding-machine([list: 0,12,-6,13,0,14,-1,2,0,-1,2,-1,0,0]) is [list: 19,15,0]
  adding-machine([list: 0,1,2,0,5,-4,-1,0,7,0,0,6]) is [list: 3,0,7]
end

check "adding: Has two 0-0 patterns":
  adding-machine([list: 12,-5,0,7,12,-2,0,5,4,1,-11,0,0,6,13,-12,0,2,14,-5,0,0,5,8,1]) is [list: 7,17,-1]
  adding-machine([list: 0,1,12,-5,0,7,12,0,5,4,1,0,0,6,13,12,0,2,14,-5,0,0,5,8,1]) is [list: 8,19,10]
end

# No 0-0 pattern

check "adding: Last list has no 0 delimiter":
  adding-machine([list: 9,3,14,7,6,0,2,0,8,5,4,13]) is [list: 39,2,30]
  adding-machine([list: 21,6,13,0,14,1,0,2]) is [list: 40,15,2]
end

check "adding: Last list has 0 delimiter":
  adding-machine([list: 1,19,9,4,0,16,4,7,0]) is [list: 33,27]
  adding-machine([list: -4,6,12,15,0,31,-13,16,5,0]) is [list: 29,39]
end

##################

check "adding: Empty list as input, output":
  adding-machine(empty) is empty
  adding-machine([list: 0,0,9,1,7,3,6,0]) is empty
end

check "adding: All 0 delimiters / 0-0 pattern":
  adding-machine([list: 0,0,0,0]) is empty
end

check "adding: Single sublist with no 0 or 0-0":
  adding-machine([list: 12,3,4,7]) is [list: 26]
  adding-machine([list: 4,-12,7,3]) is [list: 2]
end