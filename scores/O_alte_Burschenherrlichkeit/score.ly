\version "2.24.4"
% automatically converted by musicxml2ly from /tmp/O alte Burschenherrlichkeit.musicxml
\pointAndClickOff

\include "articulate.ly"

\header {
    encodingsoftware =  "MuseScore 2.3.2"
    encodingdate =  "2025-10-07"
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
     c8 [  e8 ] s2. | % 2
     g4  g4  g8 [  a8  f8  d8
    ] | % 3
     c4  e4  e4 r8  e8 \break | % 4
    \clef "treble"  d4.  e8  f4  g4 | % 5
     f4  e4 r4  g4 | % 6
     g4.  e8  c'4.  b8 \break | % 7
    \clef "treble"  b4.  a8  a4  a4 | % 8
     g4.  a8  g8 [  e8  f8  d8
    ] | % 9
     d4  c4 r4  e4 \break | \barNumberCheck #10
    \clef "treble"  d4  g4  g4  b4 | % 11
     b8 [  a8  c8  b8 ]  a4
     d,4 | % 12
     d4  a'4  a4  c4 \break | % 13
    \clef "treble"  c8 [  b8  d8  c8
    ]  b8 [  a8  g8  f8 ] | % 14
     g4.  e8  c'4.  b8 \break | % 15
    \clef "treble"  b8 [  a8 ]  a4 r4  a4 | % 16
     g4.  a8  g8 [  e8  f8  d8
    ] | % 17
     d4  c4 \bar "|."
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

