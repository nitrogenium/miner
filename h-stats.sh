#!/usr/bin/env bash



function getHR(){

	# Проверка если отчет устарал нах его

	
	last_report=$(cat ton/stats/pminer_$1.json|jq -r ".timestamp")
	current_time=$(date +"%s")

	diff=$(echo "$current_time - $last_report"|bc)
	

	if (( $(echo "$diff < 30" |bc -l) )); then

		cat ton/stats/pminer_$1.json|jq -r ".instant_speed"

	else

		echo 0

	fi;


}


total_gpu_count=$(gpu-stats |jq ".brand" | grep 'nvidia\|amd'|wc -l)
source /home/user/ton/env.sh
#total_gpu_count=2



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


stats=$(echo "{\"hs\": [$joined], \"hs_units\":\"mhs\", \"algo\": \"randomx\" }")
khs=$(echo "$total_hr * 1000"|bc)


[[ -z $khs ]] && khs=0
[[ -z $stats ]] && stats="null"

#echo $stats

# { 
# 	"hs": [123, 223.3], //array of hashes
# 	"hs_units": "khs", //Optional: units that are uses for hashes array, "hs", "khs", "mhs", ... Default "khs". 

# }



