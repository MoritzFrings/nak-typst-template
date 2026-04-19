#import "@preview/nordakademie-templates:0.1.0": transfer_paper
#import "./abbreviations.typ": abbreviation_list

#show: transfer_paper.with(
	language: "en",
  number: "1",
  matnr: "12345",
  topic: "Ein wundervoller und deskriptiver, aber nicht zu langer Titel, aber immerhin füllt er zwei Zeilen",
  course: "Angewandte Informatik, A22b",
  abbreviation_list: abbreviation_list,
	company: "Unternehmen GmbH",
	signing_location: "Elmshorn",
	bibliography_content: read("./literature.bib", encoding: none),
  appendix_content: include "chapters/99_appendix.typ",
)

// --- Include content here ---
#include "chapters/01_chapter.typ"
#include "chapters/02_chapter.typ"
#include "chapters/03_chapter.typ"
