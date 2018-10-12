#!/bin/bash 
# Useful building blocks on the shell for MESA
# Some of these originally written by Earl Bellinger
# (formerly grad student at Yale, now a postdoc at the SAC in Aarhus)
# To use these, either source this file, or include these function
# definitions at the beginning of the shell script from which you
# are invoking MESA.

change_param() { 
	# Modifies a parameter in the current inlist. 
	# args: ($1) name of parameter 
	#       ($2) new value 
	#       ($3) filename of inlist where change should occur 
	# Additionally changes the 'inlist_0all' inlist. (you can comment this out)
	# example command: change_param initial_mass 1.3 inlist_1pms
	# example command: change_param log_directory 'LOGS_MS' inlist_project
	# example command: change_param do_element_diffusion .true. inlist
	param=$1 
	newval=$2 
	filename=$3 
	search="^\s*\!*\s*$param\s*=.+$" 
	replace="      $param = $newval" 
	sed -r -i.bak -e "s/$search/$replace/g" $filename 
	
#	if [ ! "$filename" == 'inlist_0all' ]; then 
#		change_param $1 $2 "inlist_0all" 
#	fi 
} 

set_inlist() { 
	# Changes to a different inlist by modifying where "inlist" file points 
	# args: ($1) filename of new inlist  
	# example command: change_inlists inlist_2ms 
	# By assumption, extra_star_job_inlist1_name (and controls) points
	# to inlist_0all.
	newinlist=$1 
	echo "Changing to $newinlist" 
	change_param "extra_star_job_inlist2_name" "'$newinlist'" "inlist" 
	change_param "extra_controls_inlist2_name" "'$newinlist'" "inlist" 
}

restart_run() {
	./re `/usr/bin/ls tracks/photos -t | head -n 1`
}
