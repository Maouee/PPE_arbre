langue=$1
compteur=1


echo "<lang=$langue>" > ../itrameur/contextes/contextes-${langue}.txt


for file in ../contextes/contexte-${langue}* ;
do

dump=$(cat $file | sed -e "s/>/\@gt\;/g" -e "s/</\@lt\;/g" -e "s/&/\@amp\;/g")

echo "<page='extraction$compteur'>
    <text>
    $dump
    </text>
    </page>" > test3.txt >> ../itrameur/contextes/contextes-${langue}.txt

    ((compteur++))

done

echo "</lang>" >> ../itrameur/contextes/contextes-${langue}.txt