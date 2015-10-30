# this is student's solution
#import my-gdrive("plancomp-code.arr") as st

# this is definition file
#import shared-gdrive("plancomp-definition.arr", "DEFINITION_ID") as def

# this is a correct solution
#import shared-gdrive("plancomp-key-solution.arr", "SOLUTION_ID") as sol

# this is a helper file for grading
#import shared-gdrive("plancomp-grading-helper.arr", "GRADING_ID") as gr-help

##################
# Adding Machine #
##################

# Regular input

check "No special case":
  st.adding-machine([list: 1,2,0,7,0,5,4,1,0,0,6]) is [list: 3,7,10]
  st.adding-machine([list: 8,5,-3,0,2,6,5,0,1,19,-9,4,0,9,3,4,7,6,0,0,12,3,4,7,0,-8,-13,4,13,4]) is [list: 10,13,15,29]
end

check "Has sublist that sums to zero":
  st.adding-machine([list: 8,-13,-4,13,-4,0,2,6,3,5,0,1,19,9,4,0,0,12,3,4,7,0]) is [list: 0,16,33]
  st.adding-machine([list: 7,4,3,11,0,2,6,0,8,-13,-4,13,-4,0,9,3,4,7,6,0,0,12,3,4,7,0,16,4,7]) is [list: 25,8,0,29]
end

check "Input starts with 0 delimiter":
  st.adding-machine([0,4,-3,0,2,-5,0,0,5,8,3]) is [1,-3]
  st.adding-machine([0,1,2,0,7,0,5,4,1,0,0,6]) is [3,7,10]
end

check "Input starts with 0 delimiter with sublist that sums to zero":
  st.adding-machine([0,12,-6,13,0,14,-1,2,0,-1,2,-1,0,0]) is [19,15,0]
  st.adding-machine([0,1,2,0,5,-4,-1,0,7,0,0,6]) is [3,0,7]
end

check "Has two 0-0 patterns":
  st.adding-machine([12,-5,0,7,12,-2,0,5,4,1,-11,0,0,6,13,-12,0,2,14,-5,0,0,5,8,1]) is [7,17,-1]
  st.adding-machine([0,1,12,-5,0,7,12,0,5,4,1,0,0,6,13,12,0,2,14,-5,0,0,5,8,1]) is [8,19,10]
end

# No 0-0 pattern

check "Last list has no 0 delimiter":
  st.adding-machine([list: 9,3,14,7,6,0,2,0,8,5,4,13]) is [list: 39,2,30]
  st.adding-machine([list: 21,6,13,0,14,1,0,2]) is [list: 40,15,2]
end

check "Last list has 0 delimiter":
  st.adding-machine([list: 1,19,9,4,0,16,4,7,0]) is [list: 33,27]
  st.adding-machine([list: -4,6,12,15,0,31,-13,16,5,0]) is [list: 29,39]
end

##################

check "Empty list as input, output":
  st.adding-machine(empty) is empty
  st.adding-machine([list: 0,0,9,1,7,3,6,0]) is empty
end

check "All 0 delimiters / 0-0 pattern":
  st.adding-machine([list: 0,0,0,0]) is empty
end

check "Single sublist with no 0 or 0-0":
  st.adding-machine([list: 12,3,4,7]) is [list: 26]
  st.adding-machine([list: 4,-12,7,3]) is [list: 2]
end
