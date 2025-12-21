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
  g8. g16 g8. a16 g4 e4 f8. g16 f8. e16 d2 f8. f16 .8. g16 f4 d4 e8. f16 e8. d16 c4 r4 \break
g8. g16 g8. a16 g4 e4 f8. e16 f8. g16 a2 \repeat volta 2 {a8. a16 b8. a16 g4 e4 f8. f16 e8. \alternative{{f16 g2}{d16 c4 r4}}} \break
e8 d4 g4 g4. f8 e4 g4 g4 e4 d4 e4 f4 a4 a4 g4 g4. \break
e8 d4 g4 g4. f8 e4 g4 g4 r8 \break
g8 c'8 c'8 b8 a8 g8 f8 e8 d8 c4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Heu -- te kann es reg -- nen, stür -- men o -- der schnei'n, denn du strahlst ja sel -- ber wie der Sonn -- nen -- schein
Heut' ist dein Ge -- burts -- tag, da -- rum fei -- ern wir, Al -- le dei -- ne Freun -- de freu -- en sich mit dir. mit dir.
Wie schön dass du ge -- bo -- ren bist, wir hät -- ten dich sonst sehr ver -- misst.
Wie schön dass wir bei -- sam -- men sind.
Wir gra -- tu -- lie -- ren dir Ge -- burts -- tags -- kind!
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
    \tempo 2=60
  }
}