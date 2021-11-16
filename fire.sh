#!/bin/bash

total_gpu_count=$(gpu-stats |jq ".brand" | grep 'nvidia\|amd'|wc -l)
amd_gpu_count=$(gpu-stats |jq ".brand" | grep 'amd'|wc -l)

miner=cuda

if [ $amd_gpu_count -gt 0 ]; then
        miner=opencl
fi

echo "$miner - $total_gpu_count";


source env.sh
source wallet.sh


echo "-------------======================----------------" >> exits

counter=0
while [ $counter -lt $gpu_count ]
do
#	miners/$sys_version/$gpu/tonlib-$miner-cli -v 3 -C global.config.json -e "pminer start $giver $wallet $counter $boost $p_id" 
	#echo "pminer start $giver $wallet $counter $boost $p_id"
	while true; 
		do 
			echo "Start $counter" >> exits;
			miners/$sys_version/$gpu/tonlib-$miner-cli -v 3 -C global.config.json -e "pminer start $giver $wallet $counter $boost $p_id" -l result; 
			echo "Died $counter" >> exits;
			sleep 5;
		done &
	# while true; do echo $counter; done &
	((counter++))
	sleep 5;
done
