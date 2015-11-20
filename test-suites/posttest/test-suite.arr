# this is student's solution
import my-gdrive("bmi-1.arr") as st-bmi1
import my-gdrive("datasmooth-1.arr") as st-datasmooth1
import my-gdrive("frequentwords-1.arr") as st-frequentwords1
import my-gdrive("earthquake-1.arr") as st-earthquake1

bmi-report = st-bmi1.bmi-report
data-smooth = st-datasmooth1.data-smooth
frequent-words = st-frequentwords1.frequent-words
daily-max-for-month = st-earthquake1.daily-max-for-month


##########################################
# Data for BMI Sorter and Data Smoothing #
##########################################

u1 = phr( "Eugene Cannon", 1.96, 62.36, 77 )
u2 = phr( "Ray Cox", 1.77, 62.36, 84 )
u3 = phr( "Toni Lane", 1.83, 57.6, 100 )
n1 = phr( "Matty Ward", 1.55, 58.17, 56 )
n2 = phr( "Dwight Pierce", 1.9, 73, 72 )
n3 = phr( "Shannon Sully", 1.61, 62.14, 72 )
ov1 = phr( "Carla Stokes", 1.78, 87, 50 )
ov2 = phr( "Gretchen Johnston", 1.84, 91.58, 89 )
ov3 = phr( "Charlie Morris", 1.64, 74.13, 55 )
ob1 = phr( "Kristi Long", 1.11, 60.98, 80 )
ob2 = phr( "Mike Clark", 1.6, 97.94, 64 )
ob3 = phr( "Brittany Young", 1.44, 86.4, 97 )


##################
# The BMI Sorter #
##################

check "All categories": 
	bmi-report([list: ob3, ov3, n3, u3, u1, n1, n2, ov1, ob1, u2, ob2, ov2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "Just underweight":
	bmi-report([list: u3, u1, u2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], empty, empty, empty)
end

check "Just normal":
	bmi-report([list: n3, n1, n2 ]) is bmi-summary(empty, [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], empty, empty)
end

check "Just overweight":
	bmi-report([list: ov3, ov1, ov2 ]) is bmi-summary(empty, empty, [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], empty)
end

check "Just obese":
	bmi-report([list: ob3, ob1, ob2 ]) is bmi-summary(empty, empty, empty, [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "All but underweight":
	bmi-report([list: ob3, ov3, n3, n1, n2, ov1, ob1, ob2, ov2 ]) is bmi-summary(empty, [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "All but normal":
	bmi-report([list: ob3, ov3, u3, u1, ov1, ob1, u2, ob2, ov2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], empty, [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "All but overweight":
	bmi-report([list: ob3, n3, u3, u1, n1, n2, ob1, u2, ob2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], empty, [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "All but obese":
	bmi-report([list: ov3, n3, u3, u1, n1, n2, ov1, u2, ov2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], empty)
end

check "Underweight and normal only":
	bmi-report([list: n3, u3, u1, n1, n2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], empty, empty)
end

check "Underweight and overweight only":
	bmi-report([list: ov3, u3, u1, ov1, u2, ov2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], empty, [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], empty)
end

check "Underweight and obese only":
	bmi-report([list: ob3, u3, u1, ob1, u2, ob2 ]) is bmi-summary([list: "Eugene Cannon", "Ray Cox", "Toni Lane"], empty, empty, [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "Normal and overweight only":
	bmi-report([list: ov3, n3, n1, n2, ov1, ov2 ]) is bmi-summary(empty, [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], empty)
end

check "Normal and obese only":
	bmi-report([list: ob3, n3, n1, n2, ob1, ob2 ]) is bmi-summary(empty, [list: "Matty Ward", "Dwight Pierce", "Shannon Sully"], empty, [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "Obese and overweight only":
	bmi-report([list: ob3, ov3, ov1, ob1, ob2, ov2 ]) is bmi-summary(empty, empty, [list: "Carla Stokes", "Gretchen Johnston", "Charlie Morris"], [list: "Kristi Long", "Mike Clark", "Brittany Young"])
end

check "One of each":
	bmi-report([list: u1, n1, ov1, ob1 ]) is bmi-summary([list: "Eugene Cannon"], [list: "Matty Ward"], [list: "Carla Stokes"], [list: "Kristi Long"])
end

check "Empty list as input":
	bmi-report(empty) is bmi-summary(empty, empty, empty, empty)
end


##################
# Data Smoothing #
##################

check "1 entry":
	data-smooth([list: u1]) is [list: 77]
end

check "2 entries":
	data-smooth([list: u1, u2]) is [list: 77, 84]
end

check "3 entries":
	data-smooth([list: u1, u2, u3]) is [list: 77, 87, 100]
end

check "> 3 entries":
	data-smooth([list: u1, u2, u3, n1]) is [list: 77, 87, 80, 56]
	data-smooth([list: u1, n1, ov1, ob1]) is [list: 77, 61, 62, 80]
end

check "Empty list as input":
	data-smooth(empty) is empty
end


#######################
# Most Frequent Words #
#######################

check "No ties":
	frequent-words([list: "orchard", "jedi", "social", "orchard", "near", "near", "social", "midichlorian", "jedi", "near", "orchard", "social", "near", "social", "near" ]) is [list: "near", "social", "orchard" ]
	frequent-words([list: "midichlorian", "orchard", "jedi", "social", "orchard", "near", "near", "social", "jedi", "near", "orchard", "social", "near", "social", "near"]) is [list: "near", "social", "orchard" ]
end

check "With ties: 3 frequent words tied, 1 each":
	frequent-words([list: "social", "orchard", "near" ]) is [list: "near", "social", "orchard"]
end

check "With ties: 2 frequent words tied, 1 each":
	frequent-words([list: "social", "near", "orchard", "near", "near"]) is [list: "near", "social", "orchard"]
end

check "With ties: 2 frequent words tied, > 1":
	frequent-words([list: "orchard", "social", "jedi", "near", "orchard", "midichlorian", "social", "near", "near", "midichlorian"]) is [list: "near", "social", "orchard"]
end

check "With ties: 3 frequent words tied, > 1":
	frequent-words([list: "orchard", "social", "jedi", "near", "orchard", "midichlorian", "social", "near", "near", "orchard", "midichlorian", "social"]) is [list: "near", "social", "orchard"]
end

check "With ties: >= 4 frequent words tied, > 1":
	frequent-words([list: "midichlorian", "orchard", "social", "jedi", "near", "orchard", "social", "near", "near", "orchard", "midichlorian", "social", "midichlorian"]) is [list: "near", "social", "orchard"]
end

check "Empty list as input":
	frequent-words(empty) is empty
end


#########################
# Earthquake Monitoring #
#########################

check "No day skips: 1 month":
	daily-max-for-month([list: 20151028, 200, 150, 175, 20151029, 0.002, 0.03, 20151030, 82, 0.05, 34, 121], 10) is [list: max-hz(28, 200), max-hz(29, 0.03), max-hz(30, 121)]
end

check "No day skips: > 1 month":
	daily-max-for-month([list: 20151029 0.002 0.03 20151030 82 0.05 34 121 20151031 202 145 0.004 11 20151101 14 0.7 20151201 0.23 144 128  20151202 120 0 0.1 3 ], 10) is [list: max-hz(29, 0.03), max-hz(30, 121), max-hz(31, 202)]
end

check "No day skips: Month not in list":
	daily-max-for-month([list: 20151101 14 0.7 20151201 0.23 144 128 20151202 120 0 0.1 3], 10) is empty
end

check "No day skips: With 0 as max":
	daily-max-for-month([list: 20151028, -5, -110, 0, -23, 20151029, 0.002, 0.03, 20151030, 82, 0.05, 34, 121], 10) is [list: max-hz(28, 0), max-hz(29, 0.03), max-hz(30, 121)]
	daily-max-for-month([list: 20151028, 200, 150, 175, 20151029, -5, -110, 0, -23, 20151030, 82, 0.05, 34, 121], 10) is [list: max-hz(28, 200), max-hz(29, 0), max-hz(30, 121)]
end

check "With day skips: 1 month":
	daily-max-for-month([list: 20151028 200 150 175 20151030 82 0.05 34 121 20151031 202 145 0.004 11 ], 10) is [list: max-hz(28, 200), max-hz(30, 121), max-hz(31, 202)]
end

check "With day skips: > 1 month":
	daily-max-for-month([list: 20151028 200 150 175 20151030 82 0.05 34 121 20151031 202 145 0.004 11 20151101 14 0.7 20151201 0.23 144 128 20151202 120 0 0.1 3], 10) is [list: max-hz(28, 200), max-hz(30, 121), max-hz(31, 202)]
end

check "With day skips: >= 2 days skipped":
	daily-max-for-month([list: 20151028 200 150 175 20151031 202 145 0.004 11 20151101 14 0.7 20151201 0.23 144 128], 10) is [list: max-hz(28, 200), max-hz(31, 202)]
end

check "With day skips: With 0 as max":
	daily-max-for-month([list: 20151028 -5, -110, 0, -23, 20151030 82 0.05 34 121 20151031 202 145 0.004 11], 10) is [list: max-hz(28, 0), max_hz(30, 121), max-hz(31, 202)]
	daily-max-for-month([list: 20151028 -5, -110, 0, -23, 20151030 82 0.05 34 121 20151031 202 145 0.004 11 20151101 14 0.7 20151201 0.23 144 128 20151202 120 0 0.1 3], 10) is [list: max-hz(28, 0), max-hz(30, 121), max-hz(31, 202)]
end

check "One entry: Month in entry":
	daily-max-for-month([list: 20151028 200 150 175], 10) is [list: max-hz(28, 200)]
end

check "One entry: Month not in entry":
	daily-max-for-month([list: 20151202 120 0 0.1 3], 10) is empty
end

check "Empty list as input":
	daily-max-for-month(empty, 10) is empty
end

