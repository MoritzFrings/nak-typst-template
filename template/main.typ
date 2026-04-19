#import "@preview/nordakademie-templates:0.1.0": transfer_paper
#import "./abbreviations.typ": abbreviation_list

#let bibliography_path = "./literature.bib"
#show: transfer_paper.with(
	language: "en",
  "1",
  "12345",
  "Ein wundervoller und deskriptiver, aber nicht zu langer Titel, aber immerhin füllt er zwei Zeilen",
  "Angewandte Informatik, A22b",
  // abbreviation_list, // TODO fix this with typst 0.15 (new path type)
	"Unternehmen GmbH",
	"Elmshorn",
  appendix_content: include "chapters/99_appendix.typ",
)

// --- Include content here ---
#include "chapters/01_chapter.typ"
#include "chapters/02_chapter.typ"
#include "chapters/03_chapter.typ"

// TODO remove this with typst 0.15
#{
  show link: it => text(blue, it)
  set par(spacing: 1em)
  set text(size: 11pt)
  bibliography(
    bibliography_path,
    title: "heading_texts.references",
    style: "ieee",
  )
  pagebreak(weak: true)
}