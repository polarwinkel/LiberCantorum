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
  c8 e8 g8 c'4 r8 g8 a8 b8 c'8 b8 a8 d'4 a8 g4. \break
b8 a8 b8 c'4 g8 g4 f8 e4. b8 a8 b8 c'4 g8 g4 f8 e4. \break
c8 d8 e8 f4 c8 g4 c8 a4 r8 g8 a8 b8 c'4 g8 d'4 g8 e'4. r4 r8 \break
d'4. b4 b8 c'4. \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Bur -- schen, her -- aus! Las -- set es schal -- len von Haus zu Haus!
Wenn _ der Ler -- che Sil -- ber -- schlag grüßt _ des Mai -- en er -- sten Tag,
dann _ her -- aus und fragt nicht viel, frisch _ mit Lied und Lau -- ten -- spiel!
Bur -- schen, her -- aus!
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
    \tempo 2=64
  }
}