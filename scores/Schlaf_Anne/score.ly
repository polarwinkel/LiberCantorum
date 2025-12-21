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
  
  \time 3/4
  d4 a e | g4. f8 e4 | g e4. f8 | d2 r4 \break
d4 a e | g g4. g8 | g4 a bes | a2 r4 \break
d'4 bes d' | c'4. bes8 a4 e f4. g8 a2 r4 \break
a4 bes a g4. f8 e4 g e4. f8 d2  r4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Schlaf An -- ne | schlaf nur ein | bald kommt die | Nacht
hat sich aus Wol -- ken Pan -- tof -- feln ge -- | macht
kommt von den Bäu - men kommt von ganz weit
schlaf An -- ne schlaf nur ein, s'ist Schla -- fens -- zeit.
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
    \tempo 2=72
  }
}