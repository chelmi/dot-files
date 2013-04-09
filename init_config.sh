#!/bin/bash

shopt -s dotglob

exclude=($(basename $0) .gitignore .git *~)

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

for f in $DIR/*  ; do
    #echo $f
    skip=""
    for pattern in ${exclude[*]}; do
	#echo "TESTING PATTERN $pattern"
	if [[ "$f" =~ "$pattern" ]]; then
	    skip="true"
	    break
	fi
    done
    if [[ -n "$skip" ]]; then
	#echo "Skipping file $f"
	continue
    fi
    
    source=$f
    target=$HOME/$(basename $f)

    if [[ -L $target ]]; then
	continue
    elif [[ -e $target ]]; then
	echo "Warning: $target allready exists, skipping"
    else
	ln -s $source $target
	echo "Linking $source to $target"
    
    fi
done