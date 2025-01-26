\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{feif}[2025/01/26 FEIF Document Class]

\RequirePackage{geometry}                       % Change text bounds on a per-page basis
\RequirePackage{fancyhdr}                       % Allow easy customization of headers and footers

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}
\geometry{a4paper, margin=1in}

% -------------------------------------------------------------------
%                     Usability & visual changes
% -------------------------------------------------------------------
% Page margins
\geometry{
  left=2.5cm,
  right=2.5cm,
  top=2.5cm,
  bottom=3cm
}

% Create a better looking header and footer
\pagestyle{fancy}
\fancyhf{}
\lhead{\nouppercase{\leftmark}}
\rfoot{\thepage}

\frenchspacing                                                 % Insert one space after a sentence, not 2

\endinput