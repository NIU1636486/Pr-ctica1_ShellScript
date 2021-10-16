#!/bin/bash
awk -F'"' -v OFS='"' '{ for (i=2; i<=NF; i+=2) gsub(",", "aixohauriadeserunacoma", $i) } 1' CAvideos.csv > CAvideos0.temp
cut -d',' -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 CAvideos0.temp > CAvideos1.temp
awk -F ',' 'NR==1 || $12=="True" || $12=="False"' CAvideos1.temp > CAvideos2.temp
awk -F ',' 'NR==1 || $14=="False"|| $14!= "True" ' CAvideos2.temp > CAvideos3.temp
awk -F"," '{OFS=FS}{ if ($8 <= 1000000) $15="Bueno"; else if ($8=="views") $15="Ranking_Views"; else if ($8 > 10000000) $15="Estrella"; else $15="Excelente";print}' CAvideos3.temp > CAvideos4.temp
awk 'BEGIN{FS=OFS=","} {AKA="%"} {if (NR==1) print $0 OFS "Rlikes"} {if (NR!=1) (resultat=($9*100)/$8)} {if (NR!=1) print $0 OFS resultat AKA}' CAvideos4.temp > CAvideos5.temp
awk 'BEGIN{FS=OFS=","} {AKA="%"} {if (NR==1) print $0 OFS "Rdislikes"} {if (NR!=1) (resultat=($10*100)/$8)} {if (NR!=1) print $0 OFS resultat AKA}' CAvideos5.temp > CAvideos6.temp
awk -F'"' -v OFS='"' '{ for (i=2; i<=NF; i+=2) gsub("aixohauriadeserunacoma", ",", $i)} 1' CAvideos6.temp > CAvideosFINAL.csv
rm *.temp
