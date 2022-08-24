#!/bin/bash

pwd
read -p "Enter the path you want to execute script into: " LOCATION
cd $LOCATION

location=$(pwd)
echo $location | ls -al | grep '^-'

read -p "Choose file to manipulate with: " choose
cat ./$choose

read -p "Enter string that you want to change: " enterWhat
ThisISWhatUserWantToChange=$(echo "${enterWhat}" | sed -e 's/[]$.*[\^]/\\&/g' )
echo "You have choosed '$ThisISWhatUserWantToChange' to change"

read -p "Enter string that you want to change with: " enterWith
ThisISWhatUserWantToChangeWith=$(echo "${enterWith}" | sed -e 's/[]$.*[\^]/\\&/g' )
echo "You have choosed '$ThisISWhatUserWantToChangeWith' to change with"

read -p "Do you want to change all occurrences? (yes/no) " yn
case $yn in 
    yes )
    text=$(cat $choose | sed "s/$ThisISWhatUserWantToChange/$ThisISWhatUserWantToChangeWith/g" > $choose )
    cat "$choose"
    ;;
    no ) 
    read -p "Do you want to change whole specific row?(yes/no) " row
    case $row in
        yes )
        read -p "which one?(row number) " rowNumber
        text=$(cat $choose | sed "$rowNumber s/$ThisISWhatUserWantToChange/$ThisISWhatUserWantToChangeWith/g" > $choose )
        cat "$choose"
        ;;
        no )
        read -p "than you must choose row number: (number) " rowNumber2
        read -p "and which occurrence in that row: (number) " occurrence
        text=$(cat $choose | sed "$rowNumber2 s/$ThisISWhatUserWantToChange/$ThisISWhatUserWantToChangeWith/$occurrence" > $choose )
        cat "$choose"
    esac
    ;;
    * ) 
    echo "invalid response" 
    exit 1;;
esac