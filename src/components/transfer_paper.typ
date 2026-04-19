#import "header.typ": header
#import "translations.typ": english_heading_texts, german_heading_texts
#import "../pages/outline.typ": list_of, toc
#import "../pages/cover.typ": cover
#import "../dependencies.typ": make-glossary, print-glossary, register-glossary, zebraw, zebraw-themes
#import "../pages/confidentiality_clause.typ": confidentiality_clause
#import "formatting.typ": todo

#let transfer_paper(
  language: "en",
  font_size: 12pt,
  margin_y: 3cm,
  margin_x: 2cm,
  par_spacing: 1.75em,
  list_spacing: 1em,
  list_indent: 1.5em,
  citation_style: "ieee",
  headings: (
    margin_top: 30pt,
    margin_bottom: 25pt,
    font_size: 21pt,
  ),
  number: todo("1"),
  matnr: todo("12345"),
  topic: todo("topic"),
  course: todo("course"),
  company: todo("company"),
  signing_location: todo("location"),
  abbreviation_list: (key: "cpu"),
  bibliography_content: none,
  appendix_content: none,
  body,
) = {
  let zebra-theme = zebraw-themes.zebra

  // Hanging indent can slow down preview performance.
  // On performance issues it is recommended to disable this
  zebra-theme.insert("hanging-indent", true)

  // initialize extensions
  show: make-glossary // Glossary
  show: zebraw.with(..zebraw-themes.zebra) // Code listings

  // adds functionality to display flex-caption (see code.typ)
  // short attribute in outline but long version in figure caption
  // (see https://github.com/typst/typst/issues/1295#issuecomment-2749005636)
  let in-outline = state("in-outline", false)
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  // Allow pagebreak in figures (https://github.com/typst/typst/issues/977#issuecomment-1758628037)
  show figure.where(kind: raw): set block(breakable: true)

  // Document config
  set text(
    size: font_size,
    lang: language,
  )
  set page(
    header: header(language),
    margin: (y: margin_y, x: margin_x),
  )
  set par(spacing: par_spacing)
  show heading.where(level: 1): set block(above: headings.margin_top, below: headings.margin_bottom)
  show heading.where(level: 1): set text(size: headings.font_size, weight: 600)
  show heading.where(level: 2): set block(above: headings.margin_top, below: headings.margin_bottom)
  set list(spacing: list_spacing, indent: list_indent)
  set enum(spacing: list_spacing, indent: list_indent)

  let heading_texts = if language == "en" {
    english_heading_texts
  } else if language == "de" {
    german_heading_texts
  }

  // Cover
  cover(
    language,
    number,
    matnr,
    topic,
    course,
  )

  confidentiality_clause(language, number, company, signing_location)

  // Start page numbering from here
  set page(numbering: "I")
  counter(page).update(1)

  context {
    // List of Figures (if existing)
    if query(figure.where(kind: image)).len() > 0 {
      list_of(heading_texts.figures, image)
    }
    // List of Tables (if existing)
    if query(figure.where(kind: table)).len() > 0 {
      list_of(heading_texts.tables, table)
    }
    if query(figure.where(kind: raw)).len() > 0 {
      // List of Listings (if existing)
      list_of(heading_texts.listings, raw)
    }
  }

  // List of Acronyms
  register-glossary(abbreviation_list)
  heading(heading_texts.abbreviations)
  print-glossary(
    abbreviation_list,
    disable-back-references: true,
  )
  [#[] <end-of-roman-numbering>]

  // Main Section
  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: "1.1")
  set par(justify: true)
  body

  // References
  set page(numbering: "I")
  context {
    let old_page_number = counter(page).at(<end-of-roman-numbering>).first()
    counter(page).update(old_page_number + 1)
  }
  set heading(numbering: none)
  pagebreak(weak: true)
  if bibliography_content != none {
    show link: it => text(blue, it)
    set par(spacing: 1em)
    set text(size: 11pt)
    bibliography(
      bibliography_content,
      title: heading_texts.references,
      style: citation_style,
    )
    pagebreak(weak: true)
  }

  // Appendix
  if (appendix_content != none) {
    set heading(numbering: "A.1 ")
    counter(heading).update(0)
    heading(heading_texts.appendix)
    appendix_content
  }
}
