#!/bin/bash

FILE=${1}

echo "Filename"$'\t'"number_of_alignments"$'\t'"percentage_from_total_reads"$'\t'"yield_GB"$'\t'"mean_coverage"$'\t'"N50"$'\t'"N75"$'\t'"median_length"$'\t'"mean_length"$'\t'"median_identity"$'\t'"mean_identity"$'\t'"modal_identity" > ${FILE}.transposed.craminoStats.txt


number_of_alignments=$(cat ${FILE}.cramino.txt | awk 'NR == 2 {print $4}')
percentage_from_total_reads=$(cat ${FILE}.cramino.txt | awk 'NR == 3 {print $5}')
yield_GB=$(cat ${FILE}.cramino.txt | awk 'NR == 4 {print $3}')
mean_coverage=$(cat ${FILE}.cramino.txt | awk 'NR == 5 {print $3}')
yield_GB_gt_25kb=$(cat ${FILE}.cramino.txt | awk 'NR == 6 {print $4}')
N50=$(cat ${FILE}.cramino.txt | awk 'NR == 7 {print $2}')
N75=$(cat ${FILE}.cramino.txt | awk 'NR == 8 {print $2}')
median_length=$(cat ${FILE}.cramino.txt | awk 'NR == 9 {print $3}')
mean_length=$(cat ${FILE}.cramino.txt | awk 'NR == 10 {print $3}')
median_identity=$(cat ${FILE}.cramino.txt | awk 'NR == 11 {print $3}')
mean_identity=$(cat ${FILE}.cramino.txt | awk 'NR == 12 {print $3}')
modal_identity=$(cat ${FILE}.cramino.txt | awk 'NR == 13 {print $3}')
#num=number, perc=percentage, mb=megabases

printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" $FILE $number_of_alignments $percentage_from_total_reads $yield_GB $mean_coverage $yield_GB_gt_25kb $N50 $N75 $median_length $mean_length $median_identity $mean_identity $modal_identity  >> ${FILE}.transposed.craminoStats.txt
