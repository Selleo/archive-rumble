echo:
	echo "make bench URL= DUR= RATE="

bench:
	echo "GET ${URL}" | vegeta attack -duration=${DUR} -rate=${RATE} | tee results_dur-${DUR}_rate-${RATE}.bin | vegeta report
