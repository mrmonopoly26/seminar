#!/bin/bash
PDF_VIEWER=evince
# Find the line that contains the MAINFILE variable:  grep -m 1 MAINFILE Makefile 
# Get the value:                                      sed 's/^.*= //g'
# Remove carriage return:                             sed 's/\r//'
OUTPUT_FILE=$(grep -m 1 OUTPUT_FILE Makefile | sed 's/^.*= //g' | sed 's/\r//')
# Find the line that contains the MAINFILE variable:  grep -m 1 MAINFILE Makefile 
# Get the value:                                      sed 's/^.*= //g'
# Remove carriage return:                             sed 's/\r//'
OUTPUT_DIR=$(grep -m 1 OUTPUT_DIR Makefile | sed 's/^.*= //g' | sed 's/\r//')


MAIN_PDF="${OUTPUT_DIR}/${OUTPUT_FILE}.pdf"

Is_PDF_Viewer_Open() {
  if !  ps aux | grep -v grep | grep -q "$PDF_VIEWER.*$MAIN_PDF"; then
    return 0
  fi
  return 1
}

make -s

if  Is_PDF_Viewer_Open -eq 1 ; then
  $PDF_VIEWER $MAIN_PDF &
fi



while true 
do
  make -s
  if  Is_PDF_Viewer_Open -eq 1 ; then
    exit
  fi
done
