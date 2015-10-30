# this is student's solution
#import my-gdrive("plancomp-code.arr") as st

# this is definition file
#import shared-gdrive("plancomp-definition.arr", "DEFINITION_ID") as def

# this is a correct solution
#import shared-gdrive("plancomp-key-solution.arr", "SOLUTION_ID") as sol

# this is a helper file for grading
#import shared-gdrive("plancomp-grading-helper.arr", "GRADING_ID") as gr-help

##################
# Sum Over Table #
##################

check "No duplicate elements in rows (all +, all -, mixed)":
  st.sum-largest([list: [list: 1,7,5,3], [list: 20], [list: 6,9] ]) is 36
  st.sum-largest([list: [list: -1,-7,-5,-3], [list: -20], [list: -6,-9] ]) is -27
  st.sum-largest([list: [list: 1,7,-5,3], [list: 20], [list: 6,-9] ]) is 33
end

check "With duplicate elements in rows (all +, all -, mixed)":
  st.sum-largest([list: [list: 1,7,5,7], [list: 20], [list: 6,9,6] ]) is 36
  st.sum-largest([list: [list: -1,-7,-5,-7], [list: -20], [list: -6,-9,-6] ]) is -27
  st.sum-largest([list: [list: 1,7,-5,7], [list: 20], [list: 6,-9,-9] ]) is 33
end

check "All single element rows":
  st.sum-largest([list: [list: 7], [list: 20], [list: 9] ]) is 36
  st.sum-largest([list: [list: -7], [list: -20], [list: -9] ]) is -30
  st.sum-largest([list: [list: 7], [list: 20], [list: -9] ]) is 18
end

check "All zero-valued element rows":
  st.sum-largest([list: [list: 0,0,0,0], [list: 0], [list: 0,0] ]) is 0
end
