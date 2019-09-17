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
    fi
fi

echo -e "\n**************************************************************"
echo -e "\n****  Pausing 10 seconds in case this isn't what you want **** "
echo -e "\n**************************************************************"

echo -e "\n\n${SOLR_ROOT} being targeted"

if [ ! -z ${defaultsolr+x} ] ; then echo "  Solr url taken from default. Set via \$SOLR_URL"; fi

echo -e "\n$core used as corename"
if [ ! -z ${defaultcore+x} ]; then echo -e "   Corename taken from current dir.\n   Pass as arg to this script if necessary"; fi

echo -e "\n**************************************************************"
echo -e "\n****  Pausing 10 seconds in case this isn't what you want **** "
echo -e "\n**************************************************************"

echo -e "\n\n\n"




sleep 10


curl "${SOLR_ROOT}/admin/cores?action=CREATE&name=$core&config=solrconfig.xml&dataDir=data&instanceDir=$dir&wt=json"
