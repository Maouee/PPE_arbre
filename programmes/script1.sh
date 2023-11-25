file=$1
langue=$2
compteur=1

#vérifie que l'utilisateur entre deux arguments
if [ $# -ne 2 ]
then
	echo "Ce script demande en argument un fichier d'URLS et une langue."
	exit
fi

echo "<!DOCTYPE html>
    <html>
        <head>
            <link rel="stylesheet" href="../../Css/main.css">
        </head>
        <body>
            <div class ="container">
            <table id="table">" > ../tableaux/${langue}/tableau_${langue}.html

echo "<tr>
    <th>ligne</th>
    <th>URL</th>
    <th>code</th>
    <th>encodage</th>
    <th>aspirations</th>
    <th>dumps</th>
    </tr>" >> ../tableaux/${langue}/tableau_${langue}.html
lineno=1

while read -r URL
do
    ## ASPIRATION
    curl $URL > ../aspirations/${langue}/aspiration${compteur}.html
    ## EXTRACTION
    lynx -dump -nolist ../aspirations/${langue}/aspiration${compteur}.html > ../extractions/${langue}/extraction${compteur}.txt
    
    #récupère la valeur de l'encodage et l'écrit à la fin du fichier
    encodage=$(curl -L -I -s $URL | egrep -o "charset.+\b" | tail -1 | tr -d "\r\d" | tr -d "charset=")

    bash ../comptage/${langue}.sh ../extractions/${langue}/extraction${compteur}.txt

    #iconv -f ${encodage} -t UTF-8 ../extractions/${langue}/extraction${compteur}.txt > ../extractions/${langue}/extraction${compteur}.txt


    ## TABLEAU

    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    echo "<tr>
    <td>$lineno</td>
    <td><a href=$URL>URL</a></td>
    <td>$response</td>
    <td>$encoding</td>
    <td>
    <a href="https://maouee.github.io/PPE_arbre/aspirations/${langue}/aspiration${compteur}.html">aspiration</a>
    </td>
    <td>
    <a href="https://maouee.github.io/PPE_arbre/extractions/${langue}/extraction${compteur}.txt">extraction</a></td>
    </tr>" >> ../tableaux/${langue}/tableau_${langue}.html
    lineno=$(expr $lineno + 1)
    #incrémente le compteur de 1 avant de passer au fichier suivant
    ((compteur++))
done < $file

echo "</table></div></body></html>" >> ../tableaux/${langue}/tableau_${langue}.html
