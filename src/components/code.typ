// Importing code blocks
#let code(content, lang) = {
  set text(size: 10pt)
  raw(content, block: true, lang: lang)
}