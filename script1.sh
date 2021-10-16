#!/bin/bash
cut -d',' -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 CAvideos.csv > CAvideos1.csv
awk -F ',' 'NR==1 || $12=="True" || $12=="False"' CAvideos1.csv > CAvideos2.csv
awk -F ',' 'NR==1 || $14=="False"|| $14!= "True" ' CAvideos2.csv > CAvideos3.csv
awk -F"," '{OFS=FS}{ if ($8 <= 1000000) $15="Bueno"; else if ($8=="views") $15="Ranking_Views"; else if ($8 > 10000000) $15="Estrella"; else $15="Excelente";print}' CAvideos3.csv > CAvideos4.csv
