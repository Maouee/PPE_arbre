langue=$1
file="../urls/urls_${langue}.txt"
compteur=1

#vérifie que l'utilisateur entre deux arguments
if [ $# -ne 1 ]
then
	echo "Ce script demande en argument une langue (italien, anglais ou russe)."
	exit
fi
if [ "$langue" != "russe" ] && [ "$langue" != "anglais" ] && [ "$langue" != "italien" ]; then
    echo "Ce script demande en argument une langue (italien, anglais ou russe)."
	exit
fi

echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../../Css/main.css>
            <script src='https://kit.fontawesome.com/b0d5fca4a5.js' crossorigin='anonymous'></script>
        </head>" > ../tableaux/${langue}/tableau_${langue}.html

echo "    <body>
        <div class='container is-max-desktop'>
        <h1 class='title is-bordered has-text-centered has-background-success-light has-background-centered'>
            Programmation et projet encadré
        </h1>
        <div class='tabs is-centered'>" >> ../tableaux/${langue}/tableau_${langue}.html

if [ $langue == "russe" ]; then
    echo "            <ul>
            <li>
                <a href='../../index.html'>
                    <span class='icon is-small'><i class='fa-solid fa-house' aria-hidden='true'></i></span>
                    <span>Accueil</span>
                </a>
            </li>
            <li class='is-active'>
                <a>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau russe</span>
                </a>
            </li>
            <li>
                <a href='../anglais/tableau_anglais.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau anglais</span>
                </a>
            </li>
            <li>
                <a href='../italien/tableau_italien.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau italien</span>
                </a>
            </li>
    </ul>
        </div>
        <table id=table>" >> ../tableaux/${langue}/tableau_${langue}.html
elif [ $langue == "anglais" ]; then
    echo "             <ul>
            <li>
                <a href='../../index.html'>
                    <span class='icon is-small'><i class='fa-solid fa-house' aria-hidden='true'></i></span>
                    <span>Accueil</span>
                </a>
            </li>
            <li>
                <a href='../russe/tableau_russe.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau russe</span>
                </a>
            </li>
            <li class='is-active'>
                <a>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau anglais</span>
                </a>
            </li>
            <li>
                <a href='../italien/tableau_italien.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau italien</span>
                </a>
            </li>
    </ul>
        </div>
        <table id=table>" >> ../tableaux/${langue}/tableau_${langue}.html
elif [ $langue == "italien" ]; then
    echo "             <ul>
            <li>
                <a href='../../index.html'>
                    <span class='icon is-small'><i class='fa-solid fa-house' aria-hidden='true'></i></span>
                    <span>Accueil</span>
                </a>
            </li>
            <li>
                <a href='../russe/tableau_russe.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau russe</span>
                </a>
            </li>
            <li>
                <a href='../anglais/tableau_anglais.html'>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau anglais</span>
                </a>
            </li>
            <li class='is-active'>
                <a>
                    <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                    <span>Tableau italien</span>
                </a>
            </li>
    </ul>
        </div>
        <table id=table>" >> ../tableaux/${langue}/tableau_${langue}.html
fi

echo
echo "            <tr>
                <th>ligne</th>
                <th>URL</th>
                <th>code</th>
                <th>encodage</th>
                <th>aspirations</th>
                <th>dumps</th>
                <th>compte</th>
                <th>contexte</th>
                </tr>" >> ../tableaux/${langue}/tableau_${langue}.html

lineno=1
while read -r URL
do
    ## ASPIRATION
    curl $URL > ../aspirations/${langue}/aspiration${compteur}.html
    ## EXTRACTION
    links -dump -codepage utf-8 ../aspirations/${langue}/aspiration${compteur}.html > ../extractions/${langue}/extraction${compteur}.txt
    

    compte=$(bash comptage/${langue}.sh ../extractions/${langue}/extraction${compteur}.txt)
    bash contexte/${langue}.sh $langue $compteur
    #iconv -f ${encodage} -t UTF-8 ../extractions/${langue}/extraction${compteur}.txt > ../extractions/${langue}/extraction${compteur}.txt


    ## TABLEAU

    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | egrep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    echo "            <tr>
                    <td>$lineno</td>
                    <td><a href=$URL>URL</a></td>
                    <td>$response</td>
                    <td>$encoding</td>
                    <td>
                    <a href='../../aspirations/${langue}/aspiration${compteur}.html'>aspiration</a>
                    </td>
                    <td>
                    <a href='../../extractions/${langue}/extraction${compteur}.txt'>extraction</a></td>
                    <td>$compte</td>
                    <td>
                    <a href='../../contextes/${langue}/contexte${compteur}.txt'>contexte</a></td>
                    </tr>
    " >> ../tableaux/${langue}/tableau_${langue}.html
    lineno=$(expr $lineno + 1)
    #incrémente le compteur de 1 avant de passer au fichier suivant
    ((compteur++))
done < $file

echo "</table></div></body></html>" >> ../tableaux/${langue}/tableau_${langue}.html