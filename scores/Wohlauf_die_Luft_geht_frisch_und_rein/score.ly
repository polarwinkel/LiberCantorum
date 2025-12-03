\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \fixed c' {
  \key d \minor
  
  \time 4/4
  \repeat volta 2 {c4 f4. c8 a,4 f4 g4. a8 f4 f4 e4 d4 c4 b,4 d4 c4 r4 \break}
c4 g4. e8 f4. d8 c4. bes,8 a,4 c4 g4. e8 f4 d4 c4. bes8 a4 \break
c4 a4 a4 a4 a4 bes4 d4 d4 d4 c4. a8 c4. bes8 bes2 a4 \break
f8. d16 c4 c'8. c'16 c'4 e8. d16 c4 c'8. c'16 c'4 a4 a4 f4 a4. g8 g2 f4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Wohl -- auf, die Luft geht frisch und rein, wer lan -- ge sitzt, muss ro -- sten!
Drum reich mir Stab und Or -- dens -- kleid der fah -- ren -- den Scho -- la _ -- ren,
ich will zur schö -- nen Som -- mer -- zeit ins Land der Fran -- ken fah -- ren.
Val -- le -- ri, val -- le -- ra, val -- le -- ri, val -- le -- ra,
ins Land der Fran -- ken fah -- ren.
}

\score {
  <<
    \new ChordNames {
      \chordsOne
    }
    \new Staff {
      \new Voice = "melody" {
        \musicOne
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \layout {
    indent = 0.0
  }
}
\score {
  \unfoldRepeats
  <<
    \new Staff {
      \new Voice = "melody" {
        \musicOne
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \midi {
    \tempo 2=68
  }
}