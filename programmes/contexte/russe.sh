langue=$1
compteur=$2
egrep "(дерев[ауе]|деревом?|деревьях?|деревьями?|деревьев)" -C 2 ../extractions/${langue}/extraction${compteur}.txt > ../contextes/${langue}/contexte${compteur}.txt