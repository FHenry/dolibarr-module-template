#!/bin/bash

# USAGE 
# First args is lower case module name 
# Second args is Camel case module name 
# Third args args is module number 

if [ $# -lt 3 ] ; then
    echo 'USAGE'
    echo 'create_module.sh newmodule NewModule 1025455 "my beautiful module" "Jean Dupont  <Jean.dupont@toto.fr>"'
    echo 'First args is lower case module name '
    echo 'Second args is Camel case module name'
    echo 'Third args is module number'
    echo '4 args is module short desc (optionnal)'
    echo '5 args is module author name and email (optionnal)'
    exit 0
fi


cd ..
cd ..
rm -R $1

#Copy Files
rsync -rv --exclude=.git dolibarr-module-template/ $1
cd $1

# rename files
find . -name '*mymodule*' -print0 | xargs -0 -n1 bash -c 'mv "$0" "${0/mymodule/'$1'}"'
find . -name '*MyModule*' -print0 | xargs -0 -n1 bash -c 'mv "$0" "${0/MyModule/'$2'}"'

# rename text into files
find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/mymodule/'$1'/g" "$0"'
find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/MyModule/'$2'/g" "$0"'
find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/Module10000/Module'$3'/g" "$0"'
find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/dolibarr-module-template/'$1'/g" "$0"'
#find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/one line to give the program*s name and a brief idea of what it does./'$4'/g" "$0"'
find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/<year>/2016/g" "$0"'
#find . -type f -print0 | xargs -0 -n1 bash -c 'sed -i "s/<name of author>/'$5'/g" "$0"'

