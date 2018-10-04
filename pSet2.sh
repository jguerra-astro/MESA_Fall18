#!bin/bash

#title           :stellarScript.sh
#description     :Stellar Astrophysics Problem set 2 - P7,P8
#author          :Juan Guerra
#date            : 08/11/18
#usage           :bash mkscript.sh
#==============================================================================


# Added mixing_length_alpha=2 to inlist_project							-- Needed for problem 8
# set stopping parameter by commenting: stop_near_zams = .true. and
# uncommented: xa_central_lower_limit(1) = 4.5d-1  						-- Don't know if this needs to be changed for Problem 8

# make sure to be in /scratch/juan, and that scripts.sh is in same directory 
# import scripts.sh so that i can use change_param() <-ask joel if I need the other functions for some reason 

. ./scripts.sh
./mk

# Problem 7:
# The mass luminosity relation of stars using MESA: Make models of mass 1 to 5 Msun in intervals of 0.2 Msun. 
# Keep the initial abundances and mixing length parameters and other physics the same for all of them. At the 
# point where the central central hydrogen mass fraction is 0.45, examine whether the relation L ∝ M^3 does indeed hold. 
# The central hydrogen mass fraction is printed out in the history file.


# I set xa_central_lower_limit(1) = 4.5d-1 so that I only have to look at the last points of L for each run. Then I'll plot L vs M to see if  L ∝ M^3 
M_0=1.0
step='.2'   # addding decimals in bash scripts is apparently annoying to do -- but i found the following way of doing it online.


for i in {0..20}
do
	change_param initial_mass "$(echo "$M_0 + $step * $i " | bc)" inlist_project
	./rn
	mv LOGS LOGS_M_"$(echo "$M_0 + $step * $i " | bc)"
	# chage_param log_directory 'LOGS_"$(echo "$start + $M_0 * $i " | bc)"' inlist_project
done

# Then I'll plot L vs M to see if  L ∝ M^3 


#Problem 8:
# The effect of the mixing length parameter: Change the mixing length parameter of the models by ±0.4 and remake the models, 
# for this exercise a mass interval of 1Msun is sufficient. Plot the tracks for the three different mixing lengths. What is 
# the most notable difference in terms of radius and temperature. You should keep the abundances the same.

initialAlpha=1.6
aplhaStep='.4'
change_param xa_central_lower_limit\(1\) 1d-3 inlist_project

#Running this for
for k in {1..5}
do	
	change_param initial_mass $k inlist_project
	for j in {0..2}
	do 
			change_param mixing_length_alpha $(echo "$initialAlpha + $aplhaStep * $i") inlist_project
			./rn 
			mv LOGS LOGS_M_$k\_alpha_$j
	done
done 
}





