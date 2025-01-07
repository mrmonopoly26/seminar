#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <templatefile>"
    exit
fi
TEMPLATE_NAME=$1

PathToCommand=`wslpath -au 'C:\Windows\System32\cmd.exe'`
WindowsHome=`$PathToCommand /c 'echo %USERPROFILE%'`
WindowsHomeAsWSL=`wslpath -au $WindowsHome | sed 's/\r//g'`
InkscapeTemplateFolderWindows="/AppData/Roaming/inkscape/templates"
if [ -d "$WindowsHomeAsWSL$InkscapeTemplateFolderWindows" ]; then
  echo "Copying $TEMPLATE_NAME to $WindowsHomeAsWSL$InkscapeTemplateFolderWindows/"
  cp $TEMPLATE_NAME $WindowsHomeAsWSL$InkscapeTemplateFolderWindows/.
else
  echo "Failed to copy $TEMPLATE_NAME to $WindowsHomeAsWSL$InkscapeTemplateFolderWindows/"
fi

InkscapeTemplateFolderLinux=~/.config/inkscape/templates
if [ -d "$InkscapeTemplateFolderLinux" ]; then
  echo "Copying $TEMPLATE_NAME to $InkscapeTemplateFolderLinux/."
  cp $TEMPLATE_NAME $InkscapeTemplateFolderLinux/.
else
  echo "Failed to copy $TEMPLATE_NAME to $InkscapeTemplateFolderLinux/"
fi


