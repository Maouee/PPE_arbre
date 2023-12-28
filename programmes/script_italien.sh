langue="italien"
file="../urls/urls_${langue}.txt"
compteur=1



echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../Css/main.css>
            <script src='https://kit.fontawesome.com/b0d5fca4a5.js' crossorigin='anonymous'></script>
        </head>" > ../tableaux/tableau_${langue}.html

echo "    <body>
        <div class='container is-max-desktop'>
        <h1 class='title is-bordered has-text-centered has-background-success-light has-background-centered'>
            Programmation et projet encadré
        </h1>
        <div class='tabs is-centered'>" >> ../tableaux/tableau_${langue}.html


echo "             <ul>
        <li>
            <a href='../index.html'>
                <span class='icon is-small'><i class='fa-solid fa-house' aria-hidden='true'></i></span>
                <span>Accueil</span>
            </a>
        </li>
        <li>
            <a href='tableau_russe.html'>
                <span class='icon is-small'><i class='fa-solid fa-table' aria-hidden='true'></i></span>
                <span>Tableau russe</span>
            </a>
        </li>
        <li>
            <a href='tableau_anglais.html'>
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
    <table id=table>" >> ../tableaux/tableau_${langue}.html


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
                <th>concordances</th>
                </tr>" >> ../tableaux/tableau_${langue}.html


while read -r URL
do
    ## ASPIRATION
    curl $URL > ../aspirations/aspiration-${langue}-${compteur}.html
    ## dump-text
    links -dump -codepage utf-8 ../aspirations/aspiration-${langue}-${compteur}.html > ../dumps-text/dump-text-${langue}-${compteur}.txt
    


    #iconv -f ${encodage} -t UTF-8 ../dumps-text/dump-text-${langue}-${compteur}.txt > ../dumps-text/dump-text-${langue}-${compteur}.txt


    ## TABLEAU

    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | egrep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)

    contexte="NA"
    compte=0
    concordancier="NA"
    if [ "$response" == "200" ]; then
        compte=$(bash comptage/${langue}.sh ../dumps-text/dump-text-${langue}-${compteur}.txt)
        bash contexte/${langue}.sh $langue $compteur
        contexte="contexte"
        # Récupère les occurences du mot avec contexte gauche et droit au format tsv
        ggrep -o -i -P "(\w+\W){0,5}alber(o|i)(\W\w+){0,5}" ../contextes/contexte-${langue}-${compteur}.txt | tr '[:upper:]' '[:lower:]' | sed -E 's/(alber(o|i))/§\1§/g' > ../Concordances/concordances-${langue}-${compteur}.txt
        # Utilise le tsv pour créer un tableau html
        bash concordancier.sh ../Concordances/concordances-${langue}-${compteur}.txt ${langue} ${compteur}
        concordancier="concordancier"
    fi


    echo "            <tr>
                    <td>$compteur</td>
                    <td><a href=$URL>URL</a></td>
                    <td>$response</td>
                    <td>$encoding</td>
                    <td>
                    <a href='../aspirations/aspiration-${langue}-${compteur}.html'>aspiration</a>
                    </td>
                    <td>
                    <a href='../dumps-text/dump-text-${langue}-${compteur}.txt'>dump-text</a>
                    </td>
                    <td>$compte</td>" >> ../tableaux/tableau_${langue}.html
if [ "$contexte" == "NA" ];then
    echo "              <td>
                    ${contexte}
                    </td>
                    <td>
                    ${concordancier}
                    </td>
                    </tr>" >> ../tableaux/tableau_${langue}.html
else
    echo "               <td>
                    <a href='../contextes/contexte-${langue}-${compteur}.txt'>${contexte}</a>
                    </td>
                    <td>
                    <a href='../Concordances/concordances-${langue}-${compteur}.html'>${concordancier}</a>
                    </td>
                    </tr>
    " >> ../tableaux/tableau_${langue}.html
    #incrémente le compteur de 1 avant de passer au fichier suivant
fi
    ((compteur++))
done < $file

echo "</table></div></body></html>" >> ../tableaux/tableau_${langue}.html