langue=$1
compteur=$2
egrep "(дерев(а|у|е|ом?|ь(ев|я(х|ми?)?)))" -C 2 ../dumps-text/dump-text-${langue}-${compteur}.txt > ../contextes/contexte-${langue}-${compteur}.txt