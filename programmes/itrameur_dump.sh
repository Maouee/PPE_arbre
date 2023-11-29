langue=$1
compteur=1


echo "<lang=$langue>" > ../itrameur/dumps/${langue}/dumps.txt


for file in ../extractions/${langue}/* ;
do

dump=$(cat $file | sed -e "s/>/\@lg\;/g" -e "s/</\@lt\;/g" -e "s/&/\@amp\;/g")

echo "<page='extraction$compteur'>
    <text>
    $dump
    </text>
    </page>" > test3.txt >> ../itrameur/dumps/${langue}/dumps.txt

    ((compteur++))

done

echo "</lang>" >> ../itrameur/dumps/${langue}/dumps.txt