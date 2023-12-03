langue=$1
compteur=$2
egrep "(дерев[ауе]|деревом?|деревьях?|деревьями?|деревьев)" -C 2 ../dumps-text/dump-text-${langue}-${compteur}.txt > ../contextes/contexte-${langue}-${compteur}.txt