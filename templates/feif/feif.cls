\def\fileversion{1.0}
\def\filedate{2025/01/26}
\def\docdate {2025/01/26}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{feif}[\filedate \space FEIF Document Class v\fileversion]

\LoadClass[a4paper, 12pt]{article}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{caption}
\RequirePackage{float}

% -------------------------------------------------------------------
% Document Structure Settings
% -------------------------------------------------------------------
% Only allow nesting 3 layers (down to subsubsections)
\setcounter{secnumdepth}{3}

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

% Insert one space after a sentence, not 2
\frenchspacing                                                 

% Page break after every section
\let\oldsection\section
\renewcommand\section{\clearpage\oldsection}

% Don't indent start of paragraph
\setlength{\parindent}{0cm}
% Lines are separated by 6pt (0.2116666666666667cm)
\setlength{\parskip}{6pt}                               

\setlength{\headheight}{1.25cm}
\setlength{\footskip}{1cm}
\setlength{\headsep}{1cm}

% Automatically generate a box around figure environments
\floatstyle{boxed}
\restylefloat{figure}

% -------------------------------------------------------------------
% Usability Settting
% -------------------------------------------------------------------
\endinput