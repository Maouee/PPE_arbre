#initialisation des variables
langue="russe"
file="../urls/urls_${langue}.txt"
compteur=1


#génération de la page html affichant les résultats sous forme de tableau
##metadonnées
echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../Css/main.css>
            <script src='https://kit.fontawesome.com/b0d5fca4a5.js' crossorigin='anonymous'></script>
        </head>" > ../tableaux/tableau_${langue}.html

echo '    <body class="has-background-white-bis">
        <div class="container has-text-centered">
            <div class="is-centered">
                <nav class="navbar is-fixed-top is-success" role="navigation" aria-label="main navigation">' >> ../tableaux/tableau_${langue}.html

echo '
                <div id="navbar" class="navbar-menu">
                    <div class="navbar-start">
                        <a class="navbar-item" href="../index.html">
                            <span class="icon is-small mr-1"><i class="fa-solid fa-tree" aria-hidden="true"></i></span>
                            <span>Accueil</span>
                        </a>
                        <div class="navbar-item has-dropdown is-hoverable">
                            <a class="navbar-link">
                                <span class="icon is-small mr-1"><i class="fa-solid fa-table" aria-hidden="true"></i></span>
                                <span>Tableaux</span>
                            </a>
                            <div class="navbar-dropdown">
                                <a class="navbar-item" href="../tableaux/tableau_anglais.html">
                                    🇬🇧 Anglais
                                </a>
                                <a class="navbar-item" href="../tableaux/tableau_italien.html">
                                    🇮🇹 Italien
                                </a>
                                <a class="navbar-item" href="../tableaux/tableau_russe.html">
                                    🇷🇺 Russe
                                </a>
                            </div>
                        </div>
                        <div class="navbar-item has-dropdown is-hoverable">
                            <a class="navbar-link">
                                <span class="icon is-small mr-1"><i class="fa-solid fa-chart-simple" aria-hidden="true"></i></span>
                                <span>Analyses</span>
                            </a>
                            <div class="navbar-dropdown">
                                <a class="navbar-item" href="../analyses/anglais/anglais.html">
                                    🇬🇧 Anglais
                                </a>
                                <a class="navbar-item" href="../analyses/italien/italien.html">
                                    🇮🇹 Italien
                                </a>
                                <a class="navbar-item" href="../analyses/russe/russe.html">
                                    🇷🇺 Russe
                                </a>
                            </div>
                        </div>
                        <div class="navbar-item has-dropdown is-hoverable">
                            <a class="navbar-link">
                                <span class="icon is-small mr-1"><i class="fa-solid fa-code" aria-hidden="true"></i></span>
                                <span>Scripts</span>
                            </a>
                            <div class="navbar-dropdown">
                                <a class="navbar-item" href="../scripts/script_tableaux.html">
                                    Tableaux
                                </a>
                                <a class="navbar-item" href="../scripts/script_concordanciers.html">
                                    Concordanciers
                                </a>
                                <a class="navbar-item" href="../scripts/script_itrameur.html">
                                    XML
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="navbar-end">
                    <div class="navbar-item">
                        <div class="buttons">
                            <a class="button is-dark" href="https://github.com/Maouee/PPE_arbre">
                                <span class="icon is-small mr-1"><i class="fa-brands fa-github"></i></span>
                                <strong>Github</strong>
                            </a>
                        </div>
                    </div>
                </div>
            </nav>
            <table id=table>' >> ../tableaux/tableau_${langue}.html


echo "<br><br><br>
                <tr>
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

# lis le contenu de la variable file lige par ligne, chaque ligne étant une url
while read -r URL
do
    ## ASPIRATION
    curl $URL > ../aspirations/aspiration-${langue}-${compteur}.html
    ## dump-text
    links -dump -codepage utf-8 ../aspirations/aspiration-${langue}-${compteur}.html > ../dumps-text/dump-text-${langue}-${compteur}.txt
    
    #iconv -f ${encodage} -t UTF-8 ../dumps-text/dump-text-${langue}-${compteur}.txt > ../dumps-text/dump-text-${langue}-${compteur}.txt

    ## TABLEAU
    #récupère la valeur du code de réponse http
    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
    # récupère l'encodage
    encoding="NA"
    # par défaut les valeurs sont nulles
    contexte="NA"
    compte=0
    concordancier="NA"
    if [ "$response" == "200" ]; then
        encoding=$(file ../dumps-text/dump-text-${langue}-${compteur}.txt | tr "," "\n" | tail -n1 | tr -d "text")
        compte=$(bash comptage/${langue}.sh ../dumps-text/dump-text-${langue}-${compteur}.txt)
        bash contexte/${langue}.sh $langue $compteur
        contexte="contexte"
        # Récupère les occurences du mot avec contexte gauche et droit au format tsv
        ggrep -o -i -P "(\p{Cyrillic}+\s){0,5}(дерев(а|у|е|ом?|ь(ев|я(х|ми?)?)))(\s\p{Cyrillic}+){0,5}" ../contextes/contexte-${langue}-${compteur}.txt | sed -E 's/(дерев(а|у|е|ом?|ь(ев|я(х|ми?)?)))/§\1§/g' > ../Concordances/concordances-${langue}-${compteur}.txt
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
