langue=$1
compteur=1


echo "<lang=$langue>" > ../itrameur/${langue}/dump.txt


for file in ../extractions/${langue}/* ;
do

dump=$(cat $file)

echo "<page='extraction$compteur'>
    <text>
    $dump
    </text>
    </page>" > test3.txt >> ../itrameur/${langue}/dump.txt

    ((compteur++))

done

echo "</lang>" >> ../itrameur/${langue}/dump.txt