#!/bin/bash

if [ $# -ne 1 ]
then
  echo "Usage: $0 <svgfile>"
  echo " "
  echo "Description: "
  echo "    This script output all fill colors of the svg elements contained in the file <svgfile> to the stdout."  
  echo "    It separates the color components of each fill color by a white space and formats them as decimal numbers from 0 to 255."
  echo " "
  echo "Example: "  
  echo "  To print the colors on the console, use "
  echo "    $0 Filename.svg "
  echo " "
  
  echo "  To write the colors to the file PaperPalette.gpl, use "
  echo "    $0 Filename.svg > PaperPalette.gpl "
  echo " "
  exit
fi
SVG_NAME=$1
echo GIMP Palette
echo Name: Paper Palette
echo Columns: 3
grep -o 'fill:#\([0-9a-fA-F]\{6\}\)' $1 | sed 's/fill:#//' | awk '{ 
    r = strtonum("0x" substr($1, 1, 2)); 
    g = strtonum("0x" substr($1, 3, 2)); 
    b = strtonum("0x" substr($1, 5, 2)); 
    print r, g, b; 
}'