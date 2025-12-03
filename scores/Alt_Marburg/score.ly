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
  \key a \major
  
  \time 4/4
  e8 cis'8. b16 a8 gis8 a8 fis8 e4. cis4 cis8 e8. b,16 b,8 b,8 cis8 d8 cis2 r8 
e8 cis'8. b16 a8 gis8 a8 fis8 e4. cis4 e8 gis8. fis16 e8 fis8 e8 dis8 e2 
e8 fis8. fis16 fis8 fis8 f8 fis8 gis4. gis4 gis8 a8. a16 a8 a8 gis8 a8 
b4. c'4. cis'8. b16 a8 gis8 a8 cis8 b,4 d8 fis8 r8 fis8 e8. b,16 b,8 b,8 cis8 d8 cis2 r8 
e8 cis'8. b16 a8 gis8 a8 cis8 b,4 d8 fis4 fis8 e8 d'8 cis'8 b8 fis8 gis8 a2 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Ich ha -- be in deut _ -- schen Gau -- en manch trau -- lich -- en Win -- kel ge -- sehn,
doch was ich auch drau -- ßen mocht schau -- en, mein Mar -- burg wie bist du so schön!
Ge -- denk' ich in mai -- en -- er Stun -- de, wie ward' mir so ei -- gen zu Mut,
bald sang' ich mit lach -- en -- dem Mun _ -- de: Mein Mar -- burg wie bin ich dir gut!
Bald sang' ich mit lach -- en -- dem Mun _ -- de: Mein Mar -- burg wie bin ich dir gut!
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