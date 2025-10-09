\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative {
  \key c \major
  a'8 a8 a8 e4 g8 fis4 d8 e4 \break
  e8 g4 g8 a8 g8 a8 b8 b8 r8 r4 r8 \break
  a8 a8 a8 e4 g8 fis4 d8 e4 \break
  a,16 b16 c4 c8 d4 c8 b8 a4 r4 \break
  e'8 a4 a8 b4 b8 c4 c8 f,4 r8 \break
  a8 a8 a8 g4 a8 g8 f4 f4 \bar "|."
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
    \new Staff {
      \new Voice = "melody" {
        \relative {
          \musicOne
        }
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
        \relative {
          \musicOne
        }
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \midi {
    \tempo 2 = 60
  }
}
