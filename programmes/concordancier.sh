file=$1
langue=$2
compteur=$3
echo "<!DOCTYPE html>
    <html>
        <head>
            <meta charset='UTF-8'>
            <link rel=stylesheet href=../Css/main.css>
        </head>" > ../Concordances/concordances-${langue}-${compteur}.html
echo "      <body>
                <div class='container is-max-desktop'>
                <table id=table>
                    <tr>
                    <th> contexte gauche </th>
                    <th> mot </th>
                    <th> contexte droit </th>
                    </tr>" >> ../Concordances/concordances-${langue}-${compteur}.html
        
while read  line;do
    # "$line" entre guillemets pour garder les tabs. Sinon les tabs sont interprétés comme des espaces et son collapsed.
    contexte_gauche=$(echo "$line" | cut -f 1)
    contexte_droit=$(echo "$line" | cut -f 3)
    mot=$(echo "$line" | cut -f 2)
if [ -n "$contexte_gauche" ] && [ -n "$contexte_droit" ] && [ -n "$mot" ]; then
    echo "              <tr>
                        <td>${contexte_gauche}</td>
                        <td>${mot}</td>
                        <td>${contexte_droit}</td>
                        </tr> " >> ../Concordances/concordances-${langue}-${compteur}.html
fi
done < $file
