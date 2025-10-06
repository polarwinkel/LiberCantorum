\version "2.24.4"
% automatically converted by musicxml2ly from /tmp/O alte Burschenherrlichkeit.musicxml
\pointAndClickOff

\include "articulate.ly"

\header {
    encodingsoftware =  "MuseScore 2.3.2"
    encodingdate =  "2025-10-06"
    }

#(set-global-staff-size 20.34285714285714)
\paper {
    
    paper-width = 21.0\cm
    paper-height = 29.7\cm
    top-margin = 1.0\cm
    bottom-margin = 2.0\cm
    left-margin = 1.0\cm
    right-margin = 1.0\cm
    indent = 1.6153846153846154\cm
    }
\layout {
    \context { \Score
        autoBeaming = ##f
        }
    }
PartPOneVoiceOne =  \relative c' {
    \clef "treble" \key c \major | % 1
    \stemUp c8 [ \stemUp e8 ] s2. | % 2
    \stemUp g4 \stemUp g4 \stemUp g8 [ \stemUp a8 \stemUp f8 \stemUp d8
    ] | % 3
    \stemUp c4 \stemUp e4 \stemUp e4 r8 \stemUp e8 \break | % 4
    \clef "treble" \stemUp d4. \stemUp e8 \stemUp f4 \stemUp g4 | % 5
    \stemUp f4 \stemUp e4 r4 \stemUp g4 | % 6
    \stemUp g4. \stemUp e8 \stemDown c'4. \stemDown b8 \break | % 7
    \clef "treble" \stemDown b4. \stemUp a8 \stemUp a4 \stemUp a4 | % 8
    \stemUp g4. \stemUp a8 \stemUp g8 [ \stemUp e8 \stemUp f8 \stemUp d8
    ] | % 9
    \stemUp d4 \stemUp c4 r4 \stemUp e4 \break | \barNumberCheck #10
    \clef "treble" \stemUp d4 \stemUp g4 \stemUp g4 \stemDown b4 | % 11
    \stemDown b8 [ \stemDown a8 \stemDown c8 \stemDown b8 ] \stemUp a4
    \stemUp d,4 | % 12
    \stemUp d4 \stemUp a'4 \stemUp a4 \stemDown c4 \break | % 13
    \clef "treble" \stemDown c8 [ \stemDown b8 \stemDown d8 \stemDown c8
    ] \stemUp b8 [ \stemUp a8 \stemUp g8 \stemUp f8 ] | % 14
    \stemUp g4. \stemUp e8 \stemDown c'4. \stemDown b8 \break | % 15
    \clef "treble" \stemUp b8 [ \stemUp a8 ] \stemUp a4 r4 \stemUp a4 | % 16
    \stemUp g4. \stemUp a8 \stemUp g8 [ \stemUp e8 \stemUp f8 \stemUp d8
    ] | % 17
    \stemUp d4 \stemUp c4 \bar "|."
    }

PartPOneVoiceOneLyricsOne =  \lyricmode {\set ignoreMelismata = ##t O
    " " al -- te Bur " " -- schen " " -- herr -- lich -- "keit," "wo-"
    hin bist du ent -- schwun -- "den?" Nie kehrst du wie -- "der," gold
    -- ne "Zeit," so froh und un -- " " \skip1 "ge- " bun -- "den!"
    "Ver-" ge -- bens spä -- he ich\skip1 \skip1 um -- "her," ich fin --
    de dei -- ne Spur " " nicht " " "mehr," " " " " o je -- "rum," je --
    "rum," je --\skip1 "rum," o quae mu -- ta\skip1 \skip1 tio re --
    "rum."
    }


% The score definition
\score {
    <<
        
        \new Staff
        <<
            \set Staff.instrumentName = "unbenannt"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
                \new Lyrics \lyricsto "PartPOneVoiceOne" { \set stanza = "1." \PartPOneVoiceOneLyricsOne }
                >>
            >>
        
        >>
    \layout {}
    }
\score {
    \unfoldRepeats \articulate {
        
        \new Staff
        <<
            \set Staff.instrumentName = "unbenannt"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
                \new Lyrics \lyricsto "PartPOneVoiceOne" { \set stanza = "1." \PartPOneVoiceOneLyricsOne }
                >>
            >>
        
        }
    \midi {\tempo 4 = 100 }
    }

