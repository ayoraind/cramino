#!/bin/bash

FILE=${1}

echo "Filename"$'\t'"number_of_reads"$'\t'"yield_GB"$'\t'"mean_coverage"$'\t'"N50"$'\t'"median_length"$'\t'"mean_length"$'\t'"median_gap_excluded_id"$'\t'"mean_gap_excluded_id" > ${FILE}.transposed.craminoStats.txt


number_of_reads=$(cat ${FILE}.cramino.txt | awk 'NR == 2 {print $4}')
yield_GB=$(cat ${FILE}.cramino.txt | awk 'NR == 3 {print $3}')
mean_coverage=$(cat ${FILE}.cramino.txt | awk 'NR == 4 {print $3}')
N50=$(cat ${FILE}.cramino.txt | awk 'NR == 5 {print $2}')
median_length=$(cat ${FILE}.cramino.txt | awk 'NR == 6 {print $3}')
mean_length=$(cat ${FILE}.cramino.txt | awk 'NR == 7 {print $3}')
median_gap_excluded_id=$(cat ${FILE}.cramino.txt | awk 'NR == 8 {print $3}')
mean_gap_excluded_id=$(cat ${FILE}.cramino.txt | awk 'NR == 9 {print $3}')
#num=number, perc=percentage, mb=megabases

printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" $FILE $number_of_reads $yield_GB $mean_coverage $N50 $median_length $mean_length $median_gap_excluded_id $mean_gap_excluded_id  >> ${FILE}.transposed.craminoStats.txt
