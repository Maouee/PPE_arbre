langue=$1
compteur=$2
egrep "trees?" num -2 ../extractions/${langue}/extraction${compteur}.txt > ../../contextes/${langue}/contextes${compteur}.txt