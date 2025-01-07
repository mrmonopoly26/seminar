#!/bin/bash
if [ $# -ne 1 ]
then
  exit
fi

mkdir -p build



TEMPLATE_FILE_NAME=./template/FigPreview.tex

PREVIEW_FILE_TEX="./build/preview_fig.tex"
PREVIEW_FILE_PDF="./build/preview_fig.pdf"
PDF_VIEWER=evince

Is_PDF_Viewer_Open() {
  if !  ps aux | grep -v grep | grep -q "$PDF_VIEWER.*$FIG_NAME_PDF"; then
    return 0
  fi
  return 1
}

rm -f PREVIEW_FILE_TEX PREVIEW_FILE_PDF
FIG_NAME=$(echo "$1" | sed -E 's|.*/||; s|\.[^.]+$||; s/\.$//')
FIG_NAME_TEX=./build/$FIG_NAME.tex
FIG_NAME_PDF=./build/$FIG_NAME.pdf

sed 's/__BASE_NAME__/'"$FIG_NAME"'/g' $TEMPLATE_FILE_NAME > $PREVIEW_FILE_TEX

rm  $FIG_NAME_PDF
make -s $FIG_NAME_PDF ;
if  Is_PDF_Viewer_Open -eq 1 ; then
  $PDF_VIEWER $FIG_NAME_PDF &
fi

while true 
do
  make -s $FIG_NAME_PDF ;  
  if  Is_PDF_Viewer_Open -eq 1 ; then
    exit
  fi
done
