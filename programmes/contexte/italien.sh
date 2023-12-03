langue=$1
compteur=$2
egrep "alber(o|i)" -C 2 ../dumps-text/dump-text-${langue}-${compteur}.txt > ../contextes/contexte-${langue}-${compteur}.txt