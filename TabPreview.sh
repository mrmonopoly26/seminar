#!/bin/bash
if [ $# -ne 1 ]
then
  exit
fi

mkdir -p build



TEMPLATE_FILE_NAME=./template/TabPreview.tex

PREVIEW_FILE_TEX="./build/preview_tab.tex"
PREVIEW_FILE_PDF="./build/preview_tab.pdf"
PDF_VIEWER=evince

Is_PDF_Viewer_Open() {
  if !  ps aux | grep -v grep | grep -q "$PDF_VIEWER.*$TABLE_NAME_PDF"; then
    return 0
  fi
  return 1
}

rm -f PREVIEW_FILE_TEX PREVIEW_FILE_PDF
TABLE_NAME=$(echo "$1" | sed -E 's|.*/||; s|\.[^.]+$||; s/\.$//')
TABLE_NAME_TEX=./build/$TABLE_NAME.tex
TABLE_NAME_PDF=./build/$TABLE_NAME.pdf

sed 's/__BASE_NAME__/'"$TABLE_NAME"'/g' $TEMPLATE_FILE_NAME > $PREVIEW_FILE_TEX

rm  $TABLE_NAME_PDF
make -s $TABLE_NAME_PDF ;
if  Is_PDF_Viewer_Open -eq 1 ; then
  $PDF_VIEWER $TABLE_NAME_PDF &
fi

while true 
do
  make -s $TABLE_NAME_PDF ;  
  if  Is_PDF_Viewer_Open -eq 1 ; then
    exit
  fi
done
