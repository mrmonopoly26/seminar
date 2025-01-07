#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <gplfile>"
    exit
fi
PALETTE_NAME=$1


PathToCommand=`wslpath -au 'C:\Windows\System32\cmd.exe'`
WindowsHome=`$PathToCommand /c 'echo %USERPROFILE%'`
WindowsHomeAsWSL=`wslpath -au $WindowsHome | sed 's/\r//g'`
InkscapePaletteFolderWindows="/AppData/Roaming/inkscape/palettes"
if [ -d "$WindowsHomeAsWSL$InkscapePaletteFolderWindows" ]; then
  echo "Copying $PALETTE_NAME to $WindowsHomeAsWSL$InkscapePaletteFolderWindows/"
  cp $PALETTE_NAME $WindowsHomeAsWSL$InkscapePaletteFolderWindows/.
else
  echo "Failed to copy $PALETTE_NAME to $WindowsHomeAsWSL$InkscapePaletteFolderWindows/"
fi

InkscapePaletteFolderLinux=~/.config/inkscape/palettes
if [ -d "$InkscapePaletteFolderLinux" ]; then
  echo "Copying $PALETTE_NAME to $InkscapePaletteFolderLinux/."
  cp $PALETTE_NAME $InkscapePaletteFolderLinux/.
else
  echo "Failed to copy $PALETTE_NAME to $InkscapePaletteFolderLinux/"
fi


