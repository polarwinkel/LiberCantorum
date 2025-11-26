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
  \repeat volta 2 { d'8. d16 g8 fis8 e8 fis8 g8 d8 a'8. a16 a8 g8 fis8 e8 d4 } \break
\repeat volta 2 { b'8. b16 b8 b8 b8 d,8 d8 r8 b'8. a16 g8 a8 b4 g4 } \break
g4. g8 fis4 e4 fis2 b,2 e2 d4 c4 b4 e4 d4 r4 \break
b'4. b8 c4 b4 e,4 b'4 a4 d,8 e8 fis8 g4 d8 e8 fis8 g4 \break
d8 e8 fis8 g4 fis16 fis8. fis4 g4 \bar "|."
}
verseOne = \lyricmode {
  <<
  {Als die Rö -- mer frech ge -- wor -- den, sim -- se -- rim -- sim -- sim -- sim -- sim.}
  \new Lyrics {
    \set associatedVoice = "melody"
    zo -- gen sie nach Deutsch -- lands Nor -- den, sim -- se -- rim -- sim -- sim -- sim -- sim.
  }
>>
<<
  {Vor -- ne mit Trom -- pe -- ten -- schall, tä -- te -- rä -- tä -- tä -- tä,}
  \new Lyrics {
    \set associatedVoice = "melody"
    ritt' Herr Gene -- ral Feld -- mar -- schall, tä -- te -- rä -- tä -- tä -- tä,
  }
>>
Herr Quin -- ti -- lius Va -- rus, wau, wau wau wau wau wau,
Herr Quin -- ti -- lius Va _ -- rus schned -- de -- räng -- täng, schned -- de -- räng -- täng,
schned -- de -- räng -- täng te -- täng täng -- täng
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
    \tempo 2 = 68
  }
}