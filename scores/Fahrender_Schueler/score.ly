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
  a,8 d4. e4 e8 d4. a,4 a,8 c4. bes,4 bes,8 a,4. r4 \break
a,8 d4. d4 e8 f4. f4 g8 a2. r8 \break
f4  g8 a4. g4 a8 d'4. c'4 a8 c'4. \break
bes4 bes8 a4. r8 a8 a4. a4 f8 f4. e4 f8 g2. \break
g8 a4. g4 a8 d'4. c'4 a8 c'4. bes4 bes8 a4. \break
r8  a8 a4. f4 e8 d4. cis4 cis8 d2. \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Der Sang ist ver -- schol -- len, der Wein ist ver -- raucht, 
stumm irr' ich und träu -- mend um -- her.
Es _ tau -- meln die Häu -- ser vom Stur -- me um -- haucht,
es tau -- meln die Wel -- len ins Meer, 
es tau -- meln die Häu -- ser vom Stur -- me um -- haucht,
es tau -- meln die Wel -- len ins Meer.
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