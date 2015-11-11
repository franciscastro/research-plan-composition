# this is student's solution
#import my-gdrive("plancomp-code.arr") as st

# this is definition file
#import shared-gdrive("plancomp-definition.arr", "DEFINITION_ID") as def

# this is a correct solution
#import shared-gdrive("plancomp-key-solution.arr", "SOLUTION_ID") as sol

# this is a helper file for grading
#import shared-gdrive("plancomp-grading-helper.arr", "GRADING_ID") as gr-help

#########################################################
# Palindrome Detection Modulo Spaces and Capitalization #
#########################################################

# Phrase input

check "Non-matching punctuation and capitalization":
  st.is-palindrome("Are we not drawn onward, we few, drawn onward to new era?") is true
  st.is-palindrome("Try to say: Bucky! the Bucktooth Bunny!") is false
end

check "Matching punctuation, non-matching capitalization":
  st.is-palindrome("?Are, we not; drawn onward we few drawn onward ;to new ,era?") is true
end

check "Non-matching punctuation, matching capitalization":
  st.is-palindrome("Are We not Drawn onward, We feW, drawn onwarD to neW erA?") is true
end

check "Matching punctuation and capitalization":
  st.is-palindrome("?Are, We not; Drawn onward We feW drawn onwarD ;to neW ,erA?") is true
end

# Single-word input

check "Non-matching punctuation and capitalization":
  st.is-palindrome("Kayak!") is true
  st.is-palindrome("Abca!") is false
end

check "Matching punctuation, non-matching capitalization":
  st.is-palindrome("!Ka-y-ak!") is true
  st.is-palindrome("!Ab-ca!") is false
end

check "Non-matching punctuation, matching capitalization":
  st.is-palindrome("KaYaK!") is true
  st.is-palindrome("A-bcA!") is false
end

check "Matching punctuation and capitalization":
  st.is-palindrome("!Ka-Y-aK!") is true
  st.is-palindrome("!Ab-cA!") is false
end

check "All punctuation":
  st.is-palindrome("!@#$%:,") is true
end
