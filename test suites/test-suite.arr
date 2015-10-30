# this is student's solution
import my-gdrive("nile-code.arr") as sm
# this is TA's solution
import shared-gdrive("nile-solution-code.arr", "SOLUTION_ID") as s

check "popular-pairs between two files where three pairs are represented on both":
  same-rec(sm.popular-pairs([list: bl4, bl1]), s.recommendation(2, [list: "ff+dd", "ee+ff", "dd+ee"])) is true
end

# a lot of check blocks