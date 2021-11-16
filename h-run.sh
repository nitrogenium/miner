#!/usr/bin/env bash

[[ -e $WALLET_CONF ]] && . $WALLET_CONF

total_gpu_count=$(gpu-stats |jq ".brand" | grep 'nvidia\|amd'|wc -l)
amd_gpu_count=$(gpu-stats |jq ".brand" | grep 'amd'|wc -l)

miner=cuda

if [ $amd_gpu_count -gt 0 ]; then
        miner=opencl
fi

echo "$miner - $total_gpu_count";

#Default values
boost=128
p_id=0

giver=$CUSTOM_URL
wallet=$CUSTOM_TEMPLATE


#override:
	# boost
	# p_id
	# total_gpu_count
	# etc
source /home/user/ton/env.sh

FILE=/etc/resolv.conf
if test -f "/home/user/ton/giver"; then
    giver=$(cat /home/user/ton/giver)
else 
	echo "Use default giver"
fi

echo "Wallet: $wallet"
echo "Giver: $giver"
echo "Boost: $boost"
echo "Platform id $p_id"

echo "======================----------------" >> exits
sleep 40;
counter=0
while [ $counter -lt $total_gpu_count ]
do

	while true; 
		do 
			# echo "Start $counter" >> exits;
			miners/$miner/tonlib-$miner-cli -v 3 -C global.config.json -e "pminer start $giver $wallet $counter $boost $p_id" -l result; 
			echo "Died $counter" >> exits;
			sleep 7;
		done &
	# while true; do echo $counter; done &
	((counter++))
	sleep 7;
done

echo "Ready..."

wait