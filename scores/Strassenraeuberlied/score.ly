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
  \key g \major
  
  \time 4/4
  \repeat volta 2 { d4 g4 g4 b4 b4 a8 g8 a4 a4 b4. c'8 d'8 e'8 d'8 c'8 b4 a4 g4 r4 } \break
\repeat volta 2 { g8 b8 d'4 b4 a8 b8 c'8 b8 a4 } \break
d4 g4 g4 b4 b4 a8 g8 a4 r4 b4. c'8 d'8 e'8 d'8 c'8 b4 a4 g4 r4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  <<
  {Es gibt doch kein schö -- ner _ Le -- ben in der _ gan _ -- zen wei -- ten Welt}
  \new Lyrics {
    \set associatedVoice = "melody"
    als das Stra -- ßen -- räu -- ber _ -- le -- ben, mor -- den _ um _ das schö -- ne Geld!
  }
>>
<<
  {In den Wäl -- dern rum zu strei _ -- fen,}
  \new Lyrics {
    \set associatedVoice = "melody"
    rei -- che Leu -- te zu er -- grei _ -- fen.
  }
>>
Fehlt es uns an Geld o -- der Kleid bring -- gen's uns _ die _ Wan -- ders -- leut.
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