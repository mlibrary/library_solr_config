#!/bin/bash

dir=`pwd`
port=$1
core=$2

function usage() {    
    echo
    echo "Usage: load_core.sh port [corename]"
    echo "  * port defaults to 8025"
    echo "  * Corename defaults to the name of the current directory"
    echo "  * Solr url will be http://localhost:$port/solr unless \$SOLR_ROOT is set,"
    echo "    in which case port is ignored"
    echo
    exit 1
}

if [ "$1" == "-h" ]; then
    usage
fi

if [ $# -eq 0 ]; then
    usage
fi




if [ -z $core ]; then
    defaultcore=1
    core=`basename $(pwd)`
fi

if [ -z $SOLR_ROOT ]; then
    SOLR_ROOT="http://localhost:${port}/solr"
    defaultsolr=1
fi

echo -e "\n**************************************************************"
echo -e "\n"
if [ ! -z ${defaultsolr+x} ] ; then
    echo -e "\$SOLR_URL not set"
    echo -e "   Targeting '${SOLR_ROOT}' taken from defaults."
else
    echo -e "   Targeting '$SOLR_ROOT'"
fi

echo -e "\n"
if [ ! -z ${defaultcore+x} ]; then
    echo -e "No argument given for corename"
    echo -e "   '$core' taken from name of current directory"
else
    echo -e "   '$core' used as corename (from second argument)"
fi

echo "Loading config in ${dir}"

echo -e "\n"
echo -e "\n**************************************************************"
echo -e "\n****  Pausing 10 seconds in case this isn't what you want **** "
echo -e "\n**************************************************************"
echo -e "\n"




sleep 1


curl "${SOLR_ROOT}/admin/cores?action=CREATE&name=$core&config=solrconfig.xml&dataDir=data&instanceDir=$dir&wt=json"
