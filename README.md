LaTeX Computer Graphics Paper Template
======================================

This a Latex built environment designed for computer graphic papers. 
It has the following features:

- Organized template for writing computer graphic papers.
- Makefile-based build process
- Includes templates from common graphics journals and conferences
- Inkscape-Latex support: vector-graphics with selectable text in the same font of the paper.
- Auto-Preview script for the entire document
- Auto-Preview script for Inkscape-Latex figures.
- Auto-Preview script for tables.
- Auto-Preview script for bibliography.
- Templates for multiple journals and conferences
- Inkscape color-palette template.
- Inkscape style templates for various publications.
- Works with native Linux, Linux on WSL2, and in virtual machines.
- Auto downloads templates for non-CTAN packages

# Installation

## A Linux Work Environment
You need a Linux distribution. 
I use Ubuntu 22.04.3 LTS.
On Windows, you can install it from WSL2.
You find resources on the internet on how to install WSL2 and Ubuntu.

## Install Linux Packages 
You need the following packages in your Linux distribution:
- ```make``` for building various artifacts
- ```pdflatex``` as latex compiler
- ```bibtex``` for the bibliography
- ```inkscape``` for editing and converting vector-graphics
- ```texlive-full``` as your Latex Environment
- ```evince``` for viewing the document and figures.

To install them on Ubuntu 22.04.3 LTS, open a bash and type
```
sudo apt update
sudo apt install make inkscape texlive-full evince 
```
Note that ```texlive-full``` is large, but you will be on the save side. 
You can get away with a much smaller installation if you use the so-hier-method ("so hier" is German for "well, let's see" ):
Type ```make```, see what is missing, and install the missing packages. 
Then repeat until you get no more error messages.

## Programs 
You need a **text editor**, like Visual Studio Code. 
You further need **inkscape** for editing and converting svg graphics.
WSL users can use either the Windows version of those programs or the Linux version.
I lean towards the Windows version. 

# User Guide

## Select a Template
To select a template, find out what templates are in the ```templates``` folder.
For example, in a shell type
```
> ls -a templates/
```
and you will see
``` 
.  ..  eg  acmart  jcgt
```
In our case, there are four templates, i.e., eg, acmart, and jcgt.

Say you want to submit for jcgt. 
Open the ```Makefile``` located in the root folder and find the line where the variable ```TEMPLATE_PATH``` is declared and defined.
You might find for example something like:
```
TEMPLATE_PATH				:= templates/eg
``` 
Change it to
```
TEMPLATE_PATH				:= templates/jcgt
``` 

In the shell run

```make rebuild```

to rebuild the document.
Your document should now use the jcgt file.

If you want to use another template, exchange ```jgct``` with whatever template you want and find in the templates folder.

## Template structure

Every template should contain the following files:
- ```BibPreview.tex```: A document that contains all the bibliography of ```common/bibliography.bib```.
- ```FontSample.svg```: A document showing the difference between fonts generated by Latex (shown in red) and fonts rendered by inkscape.
- ```main.tex```: The main document that builds the entire document.
- ```NAMETemplate.svg```, where ```NAME``` is the name of the name of the template: A template svg for inkscape drawings.
- ```FigPreview.tex```: A template document for previewing pdf-latex svgs.
- ```TabPreview.tex```: A template document for previewing tables.

## Paper Filename and Blind Submission
Set the paper filename without the pdf extension in the ```Makefile```.
Find the line that says
```
MAINFILE					:= Paper1024
```
and change ```Paper1024``` to whatever value you want.

Further you can set, whether you want a blind submission or not by locating the variable
```
BLIND_SUBMISSION			:= 1
```
and set it to ```1``` for a blind submission and ```0``` for non-blind submission.
Good templates should properly deal with variable by hiding author information and acknowledgements. 
But it is in your responsibility to make sure, no author information is revealed if that is necessary. 

## Set Authors, Title, and other Paper-Related Information
Since every template handles setting  authors, title, and other paper-related information differently and it is hard to find common abstractions, you must set this information for each template separately. 

Therefore, open the file ```template/main.tex``` and set all the information according to the template's guidelines.

## Edit Document

### Sections
In the folder ```secs```, you can place your LaTeX text content.
Typically, those are the sections or chapters of your document.
You can order them in the ```secs/structure.tex``` file and use the LaTeX ```\input``` command.

### Teaser and Abstract
An exception are ```A0abstract.tex``` and ```A0teaser.tex```.
The ```template/main.tex``` inputs them appropriately.
Therefore, you must name them ```A0abstract.tex``` and ```A0teaser.tex```, otherwise the template will not find them.

### Common

In the common folder, you find acronyms, commands, packages, and the bibliography that typically persist across multiple papers. 
They are automatically included in each template.

### Bibliography
Making sure that the bibliography looks good, requires frequent tweaking.
Therefore, there is a the ```BibPreview.sh``` script that builds a document ```BibPreview.pdf``` with the entire bibliography in the current template style. 
You can interactively edit the bibliography file.
Upon saving, the script will update ```BibPreview.pdf```.

Alternatively, you can type ```make bibpreview``` or ```make BibPreview.pdf``` to create ```BibPreview.pdf```.

## Building the Document, Viewing the Document, and Interactive Editing and Viewing

For building and viewing the document, we offer several commands.

### Build
Type ```make``` to build the document.
In case you made an error, the console will tell you the error.
After fixing, you can launch ```make``` again and see if the error is fixed.

### Viewing
For viewing the document, type ```make view```. 
It will open ```evince``` that will show the document.
You can use any other PDF Viewer, too, but some lock the file while viewing and you need to close it before building the document again.

### Interactive Viewing and Editing
For interactive viewing, use the script

```
./Preview.sh
```

It will detect changes and automatically rebuild your document.
This is very convenient.

### Clean
For removing all output, type
```
make clean
```

### Rebuild
To rebuild from scratch, type
```
make rebuild
```
This might become necessary in case you get weird errors.

### WSL Performance
Place the project files in your WSL home directory and run make from there.
When placing the project files in a native Windows directory, I observed a performance penality of up to 3x.
To access the files from Windows, enter ```\\WSL$\``` in the address path of your explorer.

## Figures

In computer graphics, figures are important. 
There we have templates, 

### Templates

In the folder ```figs``` there is a BaseTemplate.svg with colors, line widths, dashes, line caps, arrows, and colors.

For editing graphics in inkscape, each template folder should have a ```*Template.svg``` in its template folder. 
Use the script ```tools/InstallInkscapeSVGTemplate.sh``` copies the template to the inkscape folder. 
Copy it into the Inkscape palette folder which is either
- ```%USERPROFILE%/AppData/Roaming/inkscape/templates``` (Windows)
-   ```~/.config/inkscape/templates``` (Linux)

#### Palettes

You can find a palette file in ```common/inkscape/PaperPalette.gpl```.
Copy it into the Inkscape palette folder which is either
- ```%USERPROFILE%/AppData/Roaming/inkscape/palettes``` (Windows)
-   ```~/.config/inkscape/palettes``` (Linux)

There is a script in ```tools/InstallPalette.sh``` that attempts to copy the file to the Inkscape configuration folder.
See the scripts's help message for more details.

#### Create Palettes
In case you want to create your own palette file, proceed as follows:
- Create an svg with boxes and use fill colors.
- Order the boxes back to front in the order in which you want the colors to appear in your palette file.
- Use the script ```ColorPaletteCreator.sh``` to create a gpl file.

See the scripts's help message for more details.

### PDFTex Figures
Inkscape has the ability to split an svg into a pdf and tex file.
It puts everything that is text into the tex file and the rest in pdf.
The tex file loads the pdf and places the text at the appropriate location.

This has the advantage that your fonts are always consistent with the template.
Further they are selectable by the viewer of your document.
You can also use Latex maths in your figures.
The disadvantage is that the text placement can be cumbersome at times, but see the following section "Edit and Preview" for a tool that deals with the problem.

To include them in your document use
```
\includesvg{figs/figure.pdf_tex}
```

#### Interactive Preview
In can at times be cumbersome to have the Latex text placed at the right location when using PDFTex for figures.
Constant rebuilding of the entire document is time consuming.

To alleviate this problem, use the script ```FigPreview.sh```.
From a single svg file, it creates a pdf and tex file, and creates a special pdf that just shows that figure.
Whenever the input svg changes, the script rebuilds the pdf.

By this you can almost interactively tweak the output.

To run the script, call

```
./FigPreview.sh figs/figure.svg
```

where figure.svg is the figure.svg you want to watch.
See the scripts's help message for more details.

### SVG Figures

To include svg figures without going through latex use
```
\includesvg[inkscapelatex=false]{figs/figure}
```
where ```figure.svg``` is your figure.
Note that you are not supposed to add the ```.svg``` extension to the filename.
Hence, ```figs/figure.svg``` would be the wrong argument for ```\includesvg```.
Also note, that you bypass inkscape-latex with the optional argument ```inkscapelatex=false``` 

### Pixel-Graphics

To include pixel-graphics use 

```
\includegraphics{imgs/image.png}
```

However, you also include the screenshots in svg files. 

## Tables

Place tables in the ```tabs``` folder. 
You include tables in your document with ```\input``` command.

For example, if you want to include the table ```tabs/mytable.tex``` use
```
\input{tabs/mytable.tex}
```

You can preview a table with the script ```TabPreview.sh```
Type
```
TabPreview ./tabs/mytable.tex
```
and the table will be displayed in a custom pdf that the script auto updates in case you modify ```tabs/mytable.tex```.

## Fonts

For having font consistency between templates and figures, especially when your not making using Inkscape's  export-latex feature, you need to figure out what fonts your document is using, so that you can set them in other tools.

To find out what fonts are used, use the tool ```pdffonts```.
```
user@host:~/$ pdffonts build/main.pdf
name                                 type              encoding         emb sub uni object ID
------------------------------------ ----------------- ---------------- --- --- --- ---------
CJSCAC+NimbusRomNo9L-ReguItal        Type 1            Custom           yes yes yes     17  0
PQPZGB+NimbusRomNo9L-Regu            Type 1            Custom           yes yes yes     18  0
OMLVZQ+NimbusSanL-Bold               Type 1            Custom           yes yes yes     20  0
OCEVAD+NimbusRomNo9L-Medi            Type 1            Custom           yes yes yes     21  0
NMAAKQ+NimbusSanL-Regu               Type 1            Custom           yes yes yes     23  0
KXUMIR+NimbusSanL-ReguItal           Type 1            Custom           yes yes yes     54  0
EAAPUO+CMMI6                         Type 1            Builtin          yes yes yes     70  0
QEFADV+CMR6                          Type 1            Builtin          yes yes yes     71  0
WKFGUA+CMMI10                        Type 1            Builtin          yes yes yes     72  0
```
The last three rows contain "CM" which is short for Computer Modern.
Those fonts do not typically come with Windows, but you can get them from

- Nimbus, https://github.com/ArtifexSoftware/urw-base35-fonts/tree/master/fonts 
- Computer Modern, https://ctan.org/pkg/cm-unicode
- Linux Libertine and Biolinum, https://ctan.org/pkg/libertine

and install them.
Once you have them, you can use them in Inkscape.

Every template should have a ```FontSample.svg``` located in its folder.
They, we approximate the fonts from the Inkscape's PDF import, called "Cairo import" with regular Inkscape fonts. 
It is not perfect, but works most of the time.

Alternatively, you can copy fonts from Linux to a temporary Windows directory. 
Then, in Windows you install them, by right-clicking on the font in the Windows Explorer and selecting "Install" from the popup menu.
For example, in my Linux installation, some fonts like Nimbus Roman are in  ```/usr/share/texmf/fonts/opentype/public/lm/```.

## Packaging

Publishers require tex sources of your document in a simple format. 
To create that, call 

```make package```

and a folder ```build/package``` and a zip file ```build\package.zip``` with its contents will be created.
Make sure that the paper can be built by executing the following commands:
```
cd build/package
make view

```


# Style Guide

## Rules

### Formatting
1. For better merging, use a line-break after period.            
    
1. Use correct punctuation also with line equations.

1. Avoid abbreviations.

1. Use the acronym package.

### Common Abbreviations
- et al.,
- e.g.,
- i.e.,
- Fig.~\ref{}
- Tab.~\ref{}
- Sec.~\ref{}

### Figures
1. Use vector graphics
1. Use Latex commands directly in Inkscape text boxes.
1. Use templates
    - use its shown line widths, only.
    - use its shown colors, only.
    - use its arrow caps, only.
    - use its dashes, only.
1. Avoid transparency.
1. Place screenshots in svgs.
       
### Bibliography & Citation
1. Place copies of PDFs in the Bibliography folder.

    Reason: We want to be able to quickly access them.
    
1. Use the following LaTeX citation keys:

    `auth(0,1).capitalize+shortyear+shorttitle(3,3).abbr`
    
    - `auth(0,1).capitalize`:       Capitalized family name of the first author    
    - `shortyear`:                  Last to digits of the year
    - `shorttitle(3,3).abbr`        Take the first letters of the first three significant words of the title.

    Example:
    
    **Unterguggenberger, J., Kerbl, B., Pernsteiner, J. Wimmer, M.**, 2021, *Conservative Meshlet Bounds for Robust Culling of Skinned Meshes*
    
    We use Unterguggenberger21CMB.

    
1. Never use a reference as a noun!

    Do not write
    
    `As suggested by~\cite{Unterguggenberger21CMB}, ...`,
    
    but write
    
    
    - `Meslets are used for skinned meshes~\cite{Unterguggenberger21CMB}.`; or
    - `Unterguggenberger et al.~\shortcite{Unterguggenberger21CMB} use Meshlets, too.`,
    
    instead.
    
    
### Assets
1. When using screenshots of an asset, use the following process

    1. Create an `Asset` folder.
    1. Create a separate folder for the asset inside the `Asset` folder.
    1. In that folder include
        - A text `AssetInformation.txt` file stating 
            - The author of the asset
            - Author contact information
            - the source (e.g., URL) 
            - the date when you obtained it
            - the name of the person who obtained it
        - The license file.
        - A a screenshot showing the model and license from the source from the asset was obtained.
1. Prefer Creaative Common files if possible.
1. Do not use the following models
    1. "Lenna": IEEE, Taylor & Francis,  and Nature Publishing Group are examples of publishers disallowing or discouraging the use of this image.

# History
I have always been using LaTeX to create my computer graphics research papers. 
Even though I work on Windows, I found that Linux systems provide the best LaTeX environments.
Before WSL, I wrote my LaTeX documents in a Linux virtual machine.
Since there is WSL2, I use it directly in Windows. 

While I maintain this template on a Windows machine, I anticipate that you can use on a native Linux, too.

# Open Issues

- TODO Improve Hochschule Coburg Template?            
    - TODO: Support both German and English.
    - TODO: Tab Preview
    - TODO: Fig Preview
    - TODO: Bib Preview
    - TODO: Glossar Preview
    - TODO: Acronym Preview
    - TODO: List of Symobls Preview
    - TODO: Font Sample
    - TODO: Create latex class and latex for FEIF    
    - TODO: Create FEIFTemplate.svg
- TODO Should we add a template for lecture notes?
- TODO Should we add a template for grant applications?
- TODO Refine Tufte Template
- TODO Packacking for tempaltes with download parts does not work
- TODO For packaging, run inkscape latex from command line
- TODO Make a macro to include graphics and tables.
