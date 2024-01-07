file=$1
langue=$2
compteur=$3
echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../Css/main.css>
            <script src="https://kit.fontawesome.com/b0d5fca4a5.js" crossorigin="anonymous"></script>
        </head>" > ../Concordances/concordances-${langue}-${compteur}.html

echo '      <body class="has-background-white-bis">
        <div class="container has-text-centered">
            <div class="block is-centered">
                <nav class="navbar is-fixed-top is-success" role="navigation" aria-label="main navigation">
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
            </div> ' >> ../Concordances/concordances-${langue}-${compteur}.html
                

echo "<br><br>
                <table id=table>
                    <tr>
                    <th> contexte gauche </th>
                    <th> mot </th>
                    <th> contexte droit </th>
                    </tr>" >> ../Concordances/concordances-${langue}-${compteur}.html
        
while read -e line;do
    # "$line" entre guillemets pour garder les tabs. Sinon les tabs sont interprétés comme des espaces et son collapsed.
    contexte_gauche=$(echo -n "$line" | cut -f 1 -d '§')
    contexte_droit=$(echo  -n "$line" | cut -f 3 -d '§')
    mot=$(echo  -n "$line" | cut -f 2 -d '§')

# if [ -n "$contexte_gauche" ] && [ -n "$contexte_droit" ] && [ -n "$mot" ]; then
    echo "              <tr>
                        <td>${contexte_gauche}</td>
                        <td>${mot}</td>
                        <td>${contexte_droit}</td>
                        </tr> " >> ../Concordances/concordances-${langue}-${compteur}.html
# fi
done < $file

echo "</div></body></html>" >> ../Concordances/concordances-${langue}-${compteur}.html