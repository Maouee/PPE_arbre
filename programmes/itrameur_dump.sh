langue=$1
compteur=1


echo "<lang=$langue>" > 


for file in ../extractions/${langue}/* ;
do

dump=$(cat $file)

echo "<page='extraction$compteur'>
    <text>
    $dump
    </text>
    </page> §" > test3.txt

    ((compteur++))

done

echo "</lang>"