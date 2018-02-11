#!/bin/bash

ES_PATH_CONF="/etc/elasticsearch"
ES_HOME="/opt/elasticsearch"
ES_HOME_CONF="${ES_HOME}/config"

echo "network.host: 0.0.0.0" >> ${ES_HOME_CONF}/elasticsearch.yml

for file in `ls ${ES_HOME_CONF}`; 
do 
	if [[ ! -f ${ES_PATH_CONF}/$file ]]; then
		echo $file
		cp -f ${ES_HOME_CONF}/$file ${ES_PATH_CONF}
	fi
done


if [[ $1 == 'elasticsearch' ]]; then
	cd ${ES_HOME}
	chown -R elasticsearch:elasticsearch ${ES_HOME}
	exec gosu elasticsearch "${ES_HOME}/bin/elasticsearch"
	

elif [[ $1 == 'install-plugin' ]]; then
	cd ${ES_HOME}
	chown -R elastisearch:elasticsearch ${ES_HOME}
	exec gosu elasticsearch "${ES_HOME}/bin/elasticsearch-plugin" "install" "${@:2}"
fi 
