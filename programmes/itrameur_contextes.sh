langue=$1
compteur=1


echo "<lang=$langue>" > ../itrameur/contextes/${langue}/contextes.txt


for file in ../contextes/${langue}/* ;
do

dump=$(cat $file | sed -e "s/>/\@lg\;/g" -e "s/</\@lt\;/g" -e "s/&/\@amp\;/g")

echo "<page='extraction$compteur'>
    <text>
    $dump
    </text>
    </page>" > test3.txt >> ../itrameur/contextes/${langue}/contextes.txt

    ((compteur++))

done

echo "</lang>" >> ../itrameur/contextes/${langue}/contextes.txt