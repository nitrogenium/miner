#!/usr/bin/env bash



function getHR(){

# echo $

	cat ton/stats/pminer_$1.json|jq -r ".instant_speed"

}



#total_gpu_count=$(gpu-stats |jq ".brand" | grep 'nvidia\|amd'|wc -l)
#source /home/user/ton/env.sh
total_gpu_count=2



counter=0
total_hr="0";
hr_array=();
while [ $counter -lt $total_gpu_count ]
do

	hr=$(getHR $counter)
	hr_array+=($hr)
	 total_hr=$(echo "$total_hr + $hr"|bc -l)

	((counter++))
done


#convert an array into a comma separated string
delim=""
joined=""
for item in "${hr_array[@]}"; do
  joined="$joined$delim$item"
  delim=", "
done


stats=$(echo "{\"hs\": [$joined], \"hs_units\":\"khs\" }")
khs=$total_hr


# { 
# 	"hs": [123, 223.3], //array of hashes
# 	"hs_units": "khs", //Optional: units that are uses for hashes array, "hs", "khs", "mhs", ... Default "khs". 

# }



