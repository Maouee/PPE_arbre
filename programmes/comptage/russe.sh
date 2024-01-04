file=$1
cat $file | tr "[A-Z]" "[a-z]"| egrep -o "(дерев(а|у|е|ом?|ь(ев|я(х|ми?)?)))" | wc -l