#!/bin/bash
PDF_VIEWER=evince
# Find the line that contains the BIB_PREVIEW_NAME variable:  grep -m 1 BIB_PREVIEW_NAME Makefile 
# Get the value:                                      sed 's/^.*= //g'
# Remove carriage return:                             sed 's/\r//'
BIB_PREVIEW_NAME=$(grep -m 1 BIB_PREVIEW_NAME Makefile | sed 's/^.*= //g' | sed 's/\r//')
BIB_PREVIEW_NAME_PDF="build/${BIB_PREVIEW_NAME}.pdf"

Is_PDF_Viewer_Open() {
  if !  ps aux | grep -v grep | grep -q "$PDF_VIEWER.*$BIB_PREVIEW_NAME_PDF"; then
    return 0
  fi
  return 1
}

make -s bibpreview

if  Is_PDF_Viewer_Open -eq 1 ; then
  $PDF_VIEWER $BIB_PREVIEW_NAME_PDF &
fi



while true 
do
  make -s bibpreview
  if  Is_PDF_Viewer_Open -eq 1 ; then
    exit
  fi
done
