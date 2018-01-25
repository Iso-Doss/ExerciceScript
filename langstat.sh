
#!/bin/bash

#Vérification de la présence du paramètre indiquant le nom du fichier dictionnaire à utiliser
if [ -z $1 ]
then
	echo "Parametre manquant. veuillez réesayer en saisissant un bon paramètre"
	exit
else
	fichier=$1
fi

#Vérification de la présence du second paramétre pour afficher par ordre croissant ou décroissant
#Afficher par ordre décroissant si le paramétre n'est pas présent
if [ -z $2 ]
then
	ordre="DESC"
	echo "Second Paramètre abscent - Affichage par défaut - Par ordre décroissant";
elif [ $2 = "DESC" ]
then
	ordre="DESC"
	echo "Second Paramètre " $ordre " - Affichage par ordre décroissant"
elif [ $2 = "ASC" ]
then
	ordre="ASC"
	echo "Second Paramètre " $ordre " - Affichage par ordre croissant"
else
	ordre="DESC"
	echo "Second Paramètre invalide - Affichage par défaut - Par ordre décroissant"
fi


#Vérification que le fichier dictionnaire existe bel et bien
if [ ! -e $fichier ] || [ ! -f $fichier ]
then
	echo "Parametre introuvable. Veuillez réesayer"
	exit
fi

#Boucle qui compte pour chaque lettre de l'alphabet le nombre d'occurence dans le fichier puis redirection de chaque résultats dans un fichier langstat.txt
for lettre in 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'
do
	test=`grep -o $lettre $fichier | wc -l`
	echo $test ' - ' $lettre >> langstat.txt
done

#Trie du fichier contenant les statistique sur chaque lettre
#Affichage du nombre de fois que le fichier est utilisée
#Puis suppression des fichier temporaire de travail sur le disque dur

if [ $ordre = "ASC" ]
then
        sort -n langstat.txt > langstat ; cat langstat ; rm langstat langstat.txt
else
        sort -rn langstat.txt > langstat ; cat langstat ; rm langstat langstat.txt
fi

nombreMot=`wc -w $fichier`
nombreOctets=`wc -c $fichier`
nombreCarateres=`wc -m $fichier`

echo "Résumé: Votre fichier $fichier contient $nombreMot Mots, $nombreOctets Octets et $nombreCarateres caractères"
