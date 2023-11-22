file=$1
langue=$2
compteur=1
#vérifie que l'utilisateur entre un argument
if [ $# -ne 2 ]
then
	echo "Ce script demande en argument un fichier d'URLS et une langue."
	exit
fi

while read -r URL
do
    lynx -dump -nolist $URL > ../extractions/${langue}/extraction${compteur}.txt
    curl -L -I -s $URL | egrep -o "charset.+\b" | tail -1 | tr -d "\r\d" | tr -d "charset=" >> ../extractions/${langue}/extraction${compteur}.txt
    ((compteur++))
done < $file