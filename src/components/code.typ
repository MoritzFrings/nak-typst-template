// Importing code blocks
#let code(content: path, lang: str) = {
  set text(size: 10pt)
  raw(content, block: true, lang: lang)
}