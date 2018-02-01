#!/bin/bash

shopt -s dotglob

exclude=($(basename $0) .gitignore .git '.*~' .ssh_config .config)

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"


function create_link {
    source=$1
    target=$2
    #echo "$source -> $target"
    if [[ -L $target ]]; then
	return
    elif [[ -e $target ]]; then
	echo "Warning: $target allready exists, skipping"
    else
	echo "Linking $source to $target"
	ln -s $source $target  
    fi
}


for f in $DIR/*  ; do
    #echo $f
    skip=""
    for pattern in ${exclude[*]}; do
	#echo "TESTING PATTERN $pattern"
	if [[ "$f" =~ $pattern ]]; then
	    skip="true"
	    break
	fi
    done
    if [[ -n "$skip" ]]; then
	#echo "Skipping file $f"
	continue
    fi

    create_link $f $HOME/$(basename $f)
done

create_link $DIR/.config/i3 $HOME/.config/i3
