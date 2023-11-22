file=$1
langue=$2
compteur=1

#vérifie que l'utilisateur entre deux arguments
if [ $# -ne 2 ]
then
	echo "Ce script demande en argument un fichier d'URLS et une langue."
	exit
fi


while read -r URL
do
    #récupère le contenu textuel et l'envoie vers un fichier .txt
    lynx -dump -nolist $URL > ../extractions/${langue}/extraction${compteur}.txt
    
    #récupère la valeur de l'encodage et l'écrit à la fin du fichier
    curl -L -I -s $URL | egrep -o "charset.+\b" | tail -1 | tr -d "\r\d" | tr -d "charset=" >> ../extractions/${langue}/extraction${compteur}.txt

    #incrémente le compteur de 1 avant de passer au fichier suivant
    ((compteur++))
done < $file