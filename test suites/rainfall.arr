# this is student's solution
#import my-gdrive("plancomp-code.arr") as st

# this is definition file
#import shared-gdrive("plancomp-definition.arr", "DEFINITION_ID") as def

# this is a correct solution
#import shared-gdrive("plancomp-key-solution.arr", "SOLUTION_ID") as sol

# this is a helper file for grading
#import shared-gdrive("plancomp-grading-helper.arr", "GRADING_ID") as gr-help

############
# Rainfall #
############

check "All positives":
  st.rainfall([list: 17, 9, 3, 6, 4, 0, 2, 4, -999, 8, 3, 6, 0, 1, 3, 15]) is sol.rainfall([list: 17, 9, 3, 6, 4, 0, 2, 4, -999, 8, 3, 6, 0, 1, 3, 15])
  st.rainfall([list: 6, 23, 11, -999, 8, 3, 4, 1]) is sol.rainfall([list: 6, 23, 11, -999, 8, 3, 4, 1])
end

check "All negatives":
  st.rainfall([list: -13, -7, -44, -2, -999, -5, -13]) is sol.rainfall([list: -13, -7, -44, -2, -999, -5, -13])
  st.rainfall([list: -9, -1, -19, -999, -1000, -4]) is sol.rainfall([list: -9, -1, -19, -999, -1000, -4])
end

check "Mixed positives and negatives":
  st.rainfall([list: -17, 11, -2, 5, -999, 9]) is sol.rainfall([list: -17, 11, -2, 5, -999, 9])
  st.rainfall([list: 17, 21, -2, 5, 8, -1000, 11, 4, 5, -999, 9, 13]) is sol.rainfall([list: 17, 21, -2, 5, 8, -1000, 11, 4, 5, -999, 9, 13])
end

check "All zeros before -999":
  st.rainfall([list: 0, 0, 0, 0, 0, 0, 0, -999, 0, 0]) is sol.rainfall([list: 0, 0, 0, 0, 0, 0, 0, -999, 0, 0])
end

check "No -999 (all +, all -, mixed)":
  st.rainfall([list: 14, 8, 31, 5, 23]) is sol.rainfall([list: 14, 8, 31, 5, 23])
  st.rainfall([list: -12, -5, -31, -7, -3, -16]) is sol.rainfall([list: -12, -5, -31, -7, -3, -16])
  st.rainfall([list: 23, -9, 7, 14, 0, -4, 31, 1]) is sol.rainfall([list: 23, -9, 7, 14, 0, -4, 31, 1])
end

check "Empty list as input, output":
  st.rainfall(empty) is sol.rainfall(empty)
  st.rainfall([list: -999, 9, 3, -7, -1, 6, 4]) is sol.rainfall([list: -999, 9, 3, -7, -1, 6, 4])
end

check "Two -999s, (variations: all +, all -, mixed, empty list as output)":
  st.rainfall([list: 23, 5, 13, 7, 9, 31, 8, 5, -999, 4, 16, 8, 3, 0, -999, 5, 19, 21, 3]) is sol.rainfall([list: 23, 5, 13, 7, 9, 31, 8, 5, -999, 4, 16, 8, 3, 0, -999, 5, 19, 21, 3])
  st.rainfall([list: -33, -7, -999, -44, -2, -999]) is sol.rainfall([list: -33, -7, -999, -44, -2, -999])
  st.rainfall([list: -17, 11, -2, 5, -999, 9, -4, 2, 7, -999, 0, 5]) is sol.rainfall([list: -17, 11, -2, 5, -999, 9, -4, 2, 7, -999, 0, 5])
  st.rainfall([list: -999, 9, 3, -999, -7, -1, 6, 4]) is sol.rainfall([list: -999, 9, 3, -999, -7, -1, 6, 4])
end