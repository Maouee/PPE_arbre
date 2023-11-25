langue=$1
compteur=$2
cat $file | tr "[A-Z]" "[a-z]"| egrep -C 2 "(дерев[ауе]|деревом?|деревьях?|деревьями?|деревьев)" ../extractions/${langue}/extraction${compteur}.txt > ../contextes/${langue}/contexte${compteur}.txt