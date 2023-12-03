langue="anglais"
file="../urls/urls_${langue}.txt"
compteur=1



echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../../Css/main.css>
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
    if [ "$response" == "200" ]; then
        compte=$(bash comptage/${langue}.sh ../dumps-text/dump-text-${langue}-${compteur}.txt)
        bash contexte/${langue}.sh $langue $compteur
        contexte="contexte"
    fi


    echo "            <tr>
                    <td>$compteur</td>
                    <td><a href=$URL>URL</a></td>
                    <td>$response</td>
                    <td>$encoding</td>
                    <td>
                    <a href='../../aspirations/aspiration-${langue}-${compteur}'>aspiration</a>
                    </td>
                    <td>
                    <a href='../../dumps-text/dump-text-${langue}-${compteur}.txt'>dump-text</a>
                    </td>
                    <td>$compte</td>
                    <td>
                    <a href='../../contextes/contexte-${langue}-${compteur}.txt'>${contexte}</a>
                    </td>
                    </tr>
    " >> ../tableaux/tableau_${langue}.html
    compteur=$(expr $compteur + 1)
    #incrémente le compteur de 1 avant de passer au fichier suivant
    ((compteur++))
done < $file

echo "</table></div></body></html>" >> ../tableaux/tableau_${langue}.html