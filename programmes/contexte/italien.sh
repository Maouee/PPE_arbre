langue=$1
compteur=$2
egrep "alber(o|i)" num -2 ../extractions/${langue}/extraction${compteur}.txt > ../../contextes/${langue}/contexte${compteur}.txt