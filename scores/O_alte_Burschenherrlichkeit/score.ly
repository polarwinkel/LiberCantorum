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
  c8 e8 g4 g4 g8 a8 f8 d8 c4 e4 e4 r8 e8 d4. e8 f4 g4 f4 e4 r4 \break
g4 g4. e8 c'4. b8 b4. a8 a4 a4 g4. a8 g8 [ e8 f8 d8 ] d4  c4 r4 \break
e4 d4 g4 g4 b4 b8 a8 c'8  b8 a4 d4 d4  a4 a4 c'4 c'8 b8 d'8 c'8 b8 a8 \break
g8 f8 g4. e8 c'4. b8 b8 a8 a4 r4 a4 g4. a8 g8 e8 f8 d8 d4 c4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  O _ al -- te Bur _ -- schen _ -- herr -- lich -- keit, wo -- hin bist du ent -- schwun -- den?
Nie kehrst du wie -- der, gold -- ne Zeit, so froh und un _ -- ge _ -- bun -- den!
Ver -- ge -- bens spä -- he ich _ um _ -- her, ich fin -- de dei -- ne Spur _ nicht _ mehr, _
o _ je -- rum, je -- rum, je -- rum, _ o quae mu -- ta _ tio _ re -- rum.
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