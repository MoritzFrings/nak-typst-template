#let bold_upper(content) = text(weight: 700, upper(content))

#let needsCite = strong(text(red, "needsCite"))

#let todo(content) = {
  if content == "empty" {
    content += "todo"
  }
  block(strong(text(purple, content)))
}

#let clickable_link(url, display: none) = if display == none {
  link(url, underline(text(blue, url)))
} else {
  link(url, underline(text(blue, display)))
}

#let flex-caption(short: "", long: "") = context if state("in-outline", true).get() {
  short
} else { long }
