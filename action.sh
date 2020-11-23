#!/usr/bin/env bash

set -e;
packagesURIsFile=$1;

if [ -f "$packagesURIsFile" ]; then
	for envVar in ${!ACTION_*};
	do
		unset $envVar;
	done

	for envVar in ${!GITHUB_*};
	do
		unset $envVar;
	done

	for envVar in ${!INPUT_*};
	do
		unset $envVar;
	done

	if python3 -m build --help > /dev/null; then
		buildCommand="python3 -m build -xnw";
	else
		buildCommand="python3 ./setup.py bdist_wheel";
	fi;

	for repoURI in $(cat "${packagesURIsFile}" | grep -v "^$"); do
		echo "##[group] Installing pip package from ${repoURI}"
		git clone --depth=50 $repoURI PKG_DIR;
		cd ./PKG_DIR;
		git submodule update --init;
		rm -rf ./build ./dist;
		${buildCommand};
		sudo pip3 install --upgrade --pre --no-deps ./dist/*.whl;
		cd ..;
		rm -rf ./PKG_DIR;
		echo "##[endgroup]"
	done;
else
	echo "$packagesURIsFile is not present. Nothing to do."
fi;
