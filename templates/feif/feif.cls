\def\fileversion{1.0}
\def\filedate{2025/01/26}
\def\docdate {2025/01/26}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{feif}[\filedate \space FEIF Document Class v\fileversion]

\newcommand{\praxisbericht}{false}
\DeclareOption{praxis}{\renewcommand{\praxisbericht}[0]{true}}
\ProcessOptions\relax

\LoadClass[a4paper, 12pt]{article}
\RequirePackage{fix-cm}                           % Fix sizes at which CM and EC fonts can be used
\RequirePackage[ngerman]{babel, translator}       % German LaTeX-intern descriptors (Abbildungen, ...)
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{mathptmx}
\RequirePackage{courier}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{hyperref}
\RequirePackage{microtype}
\RequirePackage[onehalfspacing]{setspace}         % Set line spacing to be 1.5x the default
\RequirePackage[titles]{tocloft}                  % More options to modify list of figures & tables
\RequirePackage[ddmmyyyy]{datetime}               % Reformat times from LaTeX commands like \today
\RequirePackage{listings}
\RequirePackage{pdfpages}                         % Include existing PDFs into the work
\RequirePackage{ifthen}                           % Include existing PDFs into the work
\RequirePackage{nomencl}                          % Support for nomenclatures ("List of Symbols")
\RequirePackage{etoolbox}                         % Easily patch commands
\RequirePackage{amsmath}                          % Includes a plethora of mathematical packages 
\RequirePackage{amssymb}                          % Source mathematical symbols like \sin
\RequirePackage{amsthm}                           % Better theorems
% Track the total count of different environments
% Needs to be imported because LaTeX resets these counter on a chapter basis
\RequirePackage[figure,table,lstlisting,xspace]{totalcount}


% -------------------------------------------------------------------
% Document Structure Settings
% -------------------------------------------------------------------
% Only allow nesting 3 layers (down to subsubsections)
\setcounter{secnumdepth}{3}

% -------------------------------------------------------------------
% Usability Settting
% -------------------------------------------------------------------
% Set toc sections to be clickable
\hypersetup{colorlinks, citecolor=black, filecolor=black, linkcolor=black}

% -------------------------------------------------------------------
% Visual Settings
% -------------------------------------------------------------------
% Align captions to the left (cut-off or "rag" right part of the 
% caption line.).
% This should also hold for single-line captions, which would otherwise be 
% centered.
\captionsetup{justification=raggedright, singlelinecheck=false}

% Disable single lines at the start of a paragraph (Schusterjungen)
\clubpenalty=10000

% Disable single lines at the end of a paragraph (Hurenkinder)
\widowpenalty=10000
\displaywidowpenalty=10000

% Page margins
\geometry{left=2.5cm, right=2.5cm, top=2.5cm, bottom=3cm}

% Create a better looking header and footer
\pagestyle{fancy}
\fancyhf{}
\lhead{\nouppercase{\leftmark}}
\rfoot{\thepage}

% New page after every section.
\AddToHook{cmd/section/before}{\clearpage}

% Insert one space after a sentence, not 2
\frenchspacing                                                 


% Don't indent start of paragraph
\setlength{\parindent}{0cm}
% Lines are separated by 6pt (0.2116666666666667cm)
\setlength{\parskip}{6pt}                               

\setlength{\headheight}{1.25cm}
\setlength{\footskip}{1cm}
\setlength{\headsep}{1cm}

% Don't display "a as ä etc.
\shorthandoff{"}

% -------------------------------------------------------------------
% Names
% -------------------------------------------------------------------
\newcommand*{\hscrefname}{Literaturverzeichnis}               % Bibliography

\numberwithin{equation}{section}                               % Numbering of equations should be x.x (locally scoped to their respective section)
\renewcommand{\UrlFont}{\color{blue}\rmfamily\itshape}         % URLs should be displayed in blue
\renewcommand{\dateseparator}{.}                               % Dates are written like 01.01.1970, not 01-01-1970

\addto{\captionsngerman}{
  \renewcommand*{\figurename}{Abb.}                            % Figures should be displayed as "Abb. x"
  \renewcommand*{\tablename}{Tab.}                             % Tables  should be displayed as "Tab. x"
  \renewcommand*{\lstlistingname}{Code}                        % Code    should be displayed as "Code x"  
  \renewcommand*{\lstlistlistingname}{Codebeispielverzeichnis} % List of listings
  \renewcommand*{\nomname}{Symbolverzeichnis}                  % Nomenclature
  \renewcommand*{\acronymname}{Abkürzungsverzeichnis}          % List of acronyms
  \renewcommand*{\refname}{\hscrefname}                        % Bibliography  
  \providecommand{\declarationname}{}
  \renewcommand*{\declarationname}{Ehrenwörtliche Erklärung}   % Declaration of honor
}

\addto{\extrasngerman}{%
  \def\sectionautorefname{Kapitel}%                              1st level sections should be called "Kapitel"
  \def\subsectionautorefname{Abschnitt}%                         2nd level sections should be called "Abschnitt"
  \def\subsubsectionautorefname{Unterabschnitt}%                 3rd level sections should be called "Unterabschnitt"
}

% -------------------------------------------------------------------
%                        Code listing setup
% -------------------------------------------------------------------
\lstset{
  basicstyle=\small\ttfamily\color{black},              % Font size used for the code
  commentstyle=\ttfamily\color{gray},                   % Comment style
  keywordstyle=\ttfamily\color{blue},                   % Keyword style
  stringstyle=\color{ForestGreen!30!LimeGreen},         % String literal style
  frame=single,                                         % Add a frame around the code
  showstringspaces=false,                               % Don't underline spaces within strings only
  captionpos=b,                                         % Set caption-position to bottom
  backgroundcolor=\color{white},                        % Background color
}

% Register Listings for list of codes.
% To style lstlistlisting like the lof, you first have to register it
% to tocloft, as mentioned in https://tex.stackexchange.com/a/27648/27635
\makeatletter
\begingroup\let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{listings}{lol}{\lstlistlistingname}
\endgroup
\let\l@lstlisting\l@listings
\makeatother

% -------------------------------------------------------------------
% Redefining geometry
% -------------------------------------------------------------------
% Automatically generate a box around figure environments
\floatstyle{boxed}
\restylefloat{figure}

% Figures
\renewcommand{\cftfigpresnum}{\figurename~}
\renewcommand{\cftfigaftersnum}{:}
\setlength{\cftfignumwidth}{2cm}
\setlength{\cftfigindent}{0cm}

\AtBeginEnvironment{figure}{\vspace{1em}}               % Increase spacing of images from the text above

% Tables
\renewcommand{\cfttabpresnum}{\tablename~}
\renewcommand{\cfttabaftersnum}{:}
\setlength{\cfttabnumwidth}{2cm}
\setlength{\cfttabindent}{0cm}

% Listings
\renewcommand*{\cftlistingspresnum}{\lstlistingname~}
\renewcommand*{\cftlistingsaftersnum}{:}
\settowidth{\cftlistingsnumwidth}{\cftlistingspresnum}
\addtolength{\cftlistingsnumwidth}{1cm}
\setlength{\cftlistingsindent}{0cm}

% -------------------------------------------------------------------
% Larger clickable references to page items
% -------------------------------------------------------------------
\newcommand{\imgref} [1]{\hyperref[#1]{Abbildung~\getrefnumber{#1}}}
\newcommand{\tabref} [1]{\hyperref[#1]{Tabelle~\getrefnumber{#1}}}
\newcommand{\coderef}[1]{\hyperref[#1]{Code~\getrefnumber{#1}}}
\newcommand{\mathref}[1]{\hyperref[#1]{Gleichung~\getrefnumber{#1}}}
\newcommand{\secref} [1]{\autoref{#1}}

% -------------------------------------------------------------------
% Commands
% -------------------------------------------------------------------
\renewcommand\maketitle
{    
    \newgeometry{left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm}    
    \begin{titlepage}
        \ifthenelse{\equal{\praxisbericht}{true}}
          {
            \centering
            \includesvg[width=.8\textwidth]{template/logo_hscoburg_de_rot}

            \begin{Large}
            Hochschule für angewandte Wissenschaften Coburg\\
            Fakultät Elektrotechnik und Informatik\par
            \end{Large}
            \vspace{1.5cm}

            \Large{Studiengang: \Studiengang}
            \vspace{1.5cm}

            \Large{Praxisbericht}
            
            \vspace{1cm}
            
            \huge{\Autorenname}

            \vspace{1.0cm}
            
            \normalsize
            
            \begin{tblr}{colspec={|X[3]|X[11]|}}
            \hline
            Unternehmen & \Unternehmen        \\
                        & \Abteilung          \\
                        & \Strasse            \\
                        & \Ort                \\
            \hline
            Zeitraum    & \Beginn \ bis \Ende \\
            \hline
            \end{tblr}           

            \large{Abgabe des Berichts: \Abgabe}
            \normalsize            
            \begin{flushleft}Freigabe zur Vorlage des Praxisberichts an der HS Coburg:\end{flushleft}%            
            \begin{tblr}{|X[3]|X[6]|X[5]|}                
                \hline
                Betreuer & \Betreuer & \\
                \hline
                Funktion & \Funktion & \textbf{\textit{Ort, Datum}}\\
                \hline
                Telefon & \Telefon & \\
                \cline{1-2}
                E-Mail & \Email & \\
                \hline
                & & \textbf{\textit{Unterschrift Betreuer}}\\
                \hline
            \end{tblr}            
          }
          {
            \centering
            \includesvg[width=.8\textwidth]{template/logo_hscoburg_de_rot}%
            
            \begin{Large}
                Hochschule für angewandte Wissenschaften Coburg\\
                Fakultät Elektrotechnik und Informatik\par
            \end{Large}
            \vspace{1.5cm}

            \Large{Studiengang: \Studiengang}
            \vspace{1.5cm}

            \Large{\ThesisType}
            \vspace{1cm}

            \Huge{\Titel}
            \vspace{2cm}

            \huge{\Autorenname}
            \vspace{2cm}

            \Large{Abgabe der Arbeit: \Abgabe}

            \Large{Betreut durch:}

            \Large{\Dozent, Hochschule Coburg}
          }
    \end{titlepage}    
    \restoregeometry    
    % Title page is considered the 1st page
    \addtocounter{page}{1}
}

% Declaration Of Honor
\newcommand\MakeDeclarationOfHonor
{  
  \clearpage
  \phantomsection
  \addcontentsline{toc}{section}{\declarationname}
  \lhead{\declarationname}
  \thispagestyle{empty}

    \includepdf[
    pages=-,
    pagecommand={},
    picturecommand*={
        \put(75,714){\large \Autorenname}
        \put(75,683){\large \Geburtsdatum}
        \put(75,652){\large \Studiengang}
        \put(75,622){\large \Matrikelnummer}
        \put(75,81.5){\large \Ort, den \today}
    }
    ]{template/_declaration_of_honor.pdf}
}

% -------------------------------------------------------------------
%                    Custom counters & commands
% -------------------------------------------------------------------
\newtoggle{anySymbols}
\pretocmd{\nomenclature}{\toggletrue{anySymbols}}{}{}

\newtoggle{anyCitations}
\pretocmd{\cite}{\toggletrue{anyCitations}}{}{}

\newcommand*{\nomen}[2]{\nomenclature{#1}{#2}\stepcounter{countnomen}}
\newcommand{\nomunit}[1]{\renewcommand{\nomentryend}{\hspace*{\fill}#1}}
\newcommand{\nomsi}[1]{\nomunit{$\left[\si{#1}\right]$}}
% -------------------------------------------------------------------
% Document Structure
% -------------------------------------------------------------------
% Frontmatter
\newcommand\frontmatter
{
% Peripheral pages have to be numbered using roman numerals
\pagenumbering{Roman}
}

% Mainmatter
\newcommand\mainmatter
{
  % Save page counter, used for consecutive numbering of peripherals following main content
  \newcounter{HSCPeripheralNumbering}
  \setcounter{HSCPeripheralNumbering}{\value{page}}  

  % Set numbering of pages to arabic for main content
  \pagenumbering{arabic}
}

% Backmatter
\newcommand\backmatter
{
  % Reset numbering to use roman numerals for rest of peripheral files
  \pagenumbering{Roman}
  \setcounter{page}{\value{HSCPeripheralNumbering}}
}

% List of Figures
\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}
{
    \iftotalfigures
        \phantomsection
        \addcontentsline{toc}{section}{\listfigurename}
        \oldlistoffigures
    \fi
}

% List of Tables
\let\oldlistoftables\listoftables
\renewcommand{\listoftables}
{
    \iftotaltables
        \phantomsection
        \addcontentsline{toc}{section}{\listtablename}
        \oldlistoftables
    \fi
}

% List of Listings
\let\oldlstlistoflistings\listoflistings
\renewcommand{\lstlistoflistings}
{  
    \iftotallstlistings
      \clearpage
      \phantomsection
      \addcontentsline{toc}{section}{\lstlistlistingname}
      \oldlstlistoflistings
    \fi
}

% List of Symbols
\newcommand{\listofsymbols}
{    
  \iftoggle{anySymbols}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{section}{\nomname}
    \printnomenclature[2.5cm]
  }
  {}
}

% List of Acronyms
\newcommand{\listofacronyms}
{
    % List of Acronyms
    \clearpage
    \setglossarystyle{super}
    \printglossary[type=\acronymtype]
}

% Glossary
\newcommand{\printfeifglossary}
{
    \clearpage
    \setglossarystyle{altlist}
    \printglossary
}

% Appendix
\let\oldappendix\appendix
\renewcommand{\appendix}
{
    \clearpage
    \oldappendix
    \renewcommand{\thesection}{A\arabic{section}}
}

% Bibliography
\newcommand{\printfeifbibliography}
{
  \iftoggle{anyCitations}{
        \phantomsection
        \renewcommand*{\refname}{\hscrefname}
        \addcontentsline{toc}{section}{\refname}
        \bibliographystyle{alphadin}
  }{
    \renewcommand*{\refname}{}
  }            
  
}

\endinput