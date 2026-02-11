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
  \key c \major
  
  \time 4/4
  a8 a8 a8 e4 g8 fis4 d8 e4 \break
e8 g4 g8 a8 g8 a8 b8 b8 r8 r4 r8 \break
a8 a8 a8 e4 g8 fis4 d8 e4 \break
a,16 b,16 c4 c8 d4 c8 b,8 a,4 r4 \break
\repeat volta 2 {e8 a4 a8 b4 b8 c'4 c'8 f4 r8 \break
a8 a8 a8 g4 a8 g8 f4 r4} \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Wild heult der Wolf des Nachts im Wald
vor Hun -- ger kann er nicht schla -- fen
Und sei -- ne Höhl' ist bit -- ter kalt
er _ giert nach fet -- ten Scha -- fen.
Du Wolf, du Wolf, komm nicht hier -- her,
Mein Kind be -- kommst du nie mehr. _
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
    \tempo 2=54
  }
}