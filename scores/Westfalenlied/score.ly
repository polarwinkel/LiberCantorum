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
  \time 3/4
  b,8 c8. cis16 d4. e8 fis8. g16 fis4 e8 e8 fis8. g16 a4. fis8 e8. d16 d4 r8 \break
d8 e8. fis16 g4. fis8 e8. d16 d4 cis8 e8 fis8. e16 a4. d8 e8. fis16 d4 r8 \break
d8 d8 e8 fis4. fis8 a8. g16 fis4 r8 d8 e8 fis8 g8. a16 bes4. cis8 d4 r8 \break
b,8 c8 cis8 d4. e8 fis8. g16 e4. c8 d8. dis16 e4. fis8 g8. a16 fis4 r8 \break
d8 g8. a16 b4. b8 c'8 b8 e4 r8 e8 fis8. g16 g4. fis8 e8. d16 b4 r8 \break
d8 g8. a16 b4. b8 d'8 c'8 e4 r8 e8 fis8. g16 g4. fis8 d'8. fis16 g4 r8 \bar "|."
}
verseOne = \lyricmode {
  Ihr mögt den Rhein, den stol -- zen prei -- sen, der in dem Schoß der Re -- ben liegt;
wo in den Ber -- gen ruht das Ei -- sen, da hat die Mut -- ter mich ge -- wiegt.
Hoch auf dem Fels die Tan -- nen stehn, im grü -- nen Tal die Her -- den gehn.
Als Wäch -- ter an des Ho -- fes Saum reckt sich em -- por der Ei -- chen -- baum.
Da ist's, wo mei -- ne Wie -- ge stand, o grüß dich Gott, West -- fa -- len -- land!
Da ist's, wo mei -- ne Wie -- ge stand, o grüß dich Gott, West -- fa -- len -- land!
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
    \tempo 2 = 50
  }
}