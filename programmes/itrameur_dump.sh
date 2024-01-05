langue=$1
compteur=1


echo "<lang=$langue>" > ../itrameur/dumps-text-${langue}.txt


for file in ../dumps-text/dump-text-${langue}* ;
do

dump=$(cat $file | sed -e "s/>/\@gt\;/g" -e "s/</\@lt\;/g" -e "s/&/\@amp\;/g")

echo "<page='dump$compteur'>
    <text>
    $dump
    </text>
    </page>" >> ../itrameur/dumps-text-${langue}.txt

    ((compteur++))

done

echo "</lang>" >> ../itrameur/dumps-text-${langue}.txt