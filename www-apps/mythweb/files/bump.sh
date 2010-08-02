#!/bin/bash

source="mythweb-0.23_p25065"
target="mythweb-0.23.1_p25396"

for src in $(ls *${source}*); do
	dst=`echo $src | sed -e "s/${source}/${target}/g"`
	echo "$src -> $dst"
	cp $src $dst
done
