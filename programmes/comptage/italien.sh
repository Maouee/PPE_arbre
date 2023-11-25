file=$1
cat $file | tr "[A-Z]" "[a-z]" | egrep -o "alber(o|i)" | wc -l 