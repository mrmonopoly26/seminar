\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{feif}[2025/01/26 FEIF Document Class]


\LoadClass[a4paper, 12pt]{article}
\RequirePackage{geometry}                       % Change text bounds on a per-page basis
\RequirePackage{fancyhdr}                       % Allow easy customization of headers and footers
\RequirePackage{caption}

% -------------------------------------------------------------------
% Document Structure Settings
% -------------------------------------------------------------------
% Only allow nesting 3 layers (down to subsubsections)
\setcounter{secnumdepth}{3}                             

% -------------------------------------------------------------------
% Visual Settings
% -------------------------------------------------------------------
% Align captions to the left (cut-off or "rag" right part of the caption line.)
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
% Lines are separated by 6pt
\setlength{\parskip}{6pt}                               

\setlength{\headheight}{1.25cm}
\setlength{\footskip}{1cm}
\setlength{\headsep}{1cm}


% -------------------------------------------------------------------
% Usability Settting
% -------------------------------------------------------------------


\endinput