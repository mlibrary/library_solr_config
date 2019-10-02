#!/bin/bash

dir=`pwd`
core=$1

if [ "$1" == "-h" ]; then
    echo
    echo "Usage: load_core.sh [corename]"
    echo "Corename defaults to the name of the current directory"
    echo "Solr url comes from  \$SOLR_URL (default: localhost:8025/solr/biblio)"
    echo
    exit 1
fi


if [ -z $core ]; then
    defaultcore=1
    core=`basename $(pwd)`
fi

if [ -z $SOLR_ROOT ]; then
    if [ ! -z $SOLR_URL ]; then
		components=(${SOLR_URL//\// });

	SOLR_ROOT="${components[0]}/${components[1]}/${components[2]}"
    else
	defaultsolr=1
	SOLR_ROOT="http://localhost:8025/solr"
	SOLR_URL="${SOLR_ROOT}/$core"
    fi
fi

echo -e "\n**************************************************************"
echo -e "\n"
if [ ! -z ${defaultsolr+x} ] ; then
    echo -e "\$SOLR_URL not set. Can't derive solr root"
    echo -e "   Targeting '$SOLR_ROOT' taken from default."
else
    echo -e "   Targeting '$SOLR_ROOT'"
fi

echo -e "\n"
if [ ! -z ${defaultcore+x} ]; then
    echo -e "No argument given for corename"
    echo -e "   '$core' taken from name of current directory"
else
    echo -e "   '$core' used as corename (from first argument)"
fi

echo "Loading config in ${dir}"

echo -e "\n"
echo -e "\n**************************************************************"
echo -e "\n****  Pausing 10 seconds in case this isn't what you want **** "
echo -e "\n**************************************************************"
echo -e "\n"




sleep 1


curl "${SOLR_ROOT}/admin/cores?action=CREATE&name=$core&config=solrconfig.xml&dataDir=data&instanceDir=$dir&wt=json"
