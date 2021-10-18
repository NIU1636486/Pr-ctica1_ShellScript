#!/bin/bashva
i=$1
awk -F"," -v buscar="$i" '$1 ~ buscar' CAvideos.csv > CABUSCAR1.temp
awk -F"," -v buscar="$i" '$3 ~ buscar' CAvideos.csv > CABUSCAR2.temp
if [ "$#" != 0 ]; then
	if [ -s "$CABUSCAR1.temp" ]; then
		echo "buscar1"
	if [ -s "$CABUSCAR2.temp"]; then
		echo "buscar2"	
	else
		echo "caca"
	fi
fi

if [ "$#" == 0 ]; then
	#Abans de començar els exercicis aquesta línia canvia les comes que hi ha a cada casella (dintre de strings) per tal de que l'AWK pugui fer servir les comes com a separadors.
	awk -F'"' -v OFS='"' '{ for (i=2; i<=NF; i+=2) gsub(",", "aixohauriadeserunacoma", $i) } 1' CAvideos.csv > CAvideos0.temp
	#Exercici 1: Eliminar les columnes 12 i 16
	cut -d',' -f 12,16 --complement CAvideos0.temp > CAvideos1.temp
	#Exercici 2
	awk -F ',' 'NR==1 || $12=="True" || $12=="False"' CAvideos1.temp > CAvideos2.temp
	#Exercici 3
	awk -F ',' 'NR==1 || $14=="False"|| $14!= "True" ' CAvideos2.temp > CAvideos3.temp
	#Exercici 4: Crear ranking. Si la columna 8 conté "views", imprimirar "Ranking_Views" per tal de crear el nom de la columna.
	awk -F"," '{OFS=FS}{ if ($8 <= 1000000) $15="Bueno"; else if ($8=="views") $15="Ranking_Views"; else if ($8 > 10000000) $15="Estrella"; else $15="Excelente";print}' CAvideos3.temp > CAvideos4.temp
	#Exercici 5: Crear columna Rlikes
	awk 'BEGIN{FS=OFS=","} {AKA="%"} {if (NR==1) print $0 OFS "Rlikes"} {if (NR!=1) (resultat=($9*100)/$8)} {if (NR!=1) print $0 OFS resultat AKA}' CAvideos4.temp > CAvideos5.temp
	#Exercici 5: Crear columna Rdislikes
	awk 'BEGIN{FS=OFS=","} {AKA="%"} {if (NR==1) print $0 OFS "Rdislikes"} {if (NR!=1) (resultat=($10*100)/$8)} {if (NR!=1) print $0 OFS resultat AKA}' CAvideos5.temp > CAvideos6.temp
	#Tornar a posar les comes substituïdes al principi.
	awk -F'"' -v OFS='"' '{ for (i=2; i<=NF; i+=2) gsub("aixohauriadeserunacoma", ",", $i)} 1' CAvideos6.temp > CAvideosFINAL.csv
	#Eliminar arxius temporals creats a cada exercici
	rm *.temp
fi