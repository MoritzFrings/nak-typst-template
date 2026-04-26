// This function is needed as typst does not provide a generic function
// to revoke already applied styling.
// The feature is listed on typst roadmap as 
// "Support for revoking style rules" (see http://typst.app/docs/roadmap/, 26.04.2026)
#let get-plain-text(it) = {
  if it == none {
    return ""
  }

  if type(it) == str {
    it
  } else if it == [ ] {
    " "
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(get-plain-text).join("")
  } else if it.has("body") {
    get-plain-text(it.body)
  } else {
    ""
  }
}

// This is a helper function used in the default implementation of glossarium
#let __has_attribute(entry, attrname) = {
  let attr = entry.at(attrname)
  return attr != none and attr != "" and attr != []
}

// These are helper functions used in the default implementation of glossarium
#let has-long(entry) = __has_attribute(entry, "long")
#let has-short(entry) = __has_attribute(entry, "short")

// This is a user-print-title implementation for glossarium 
// as glossarium does currently not revoke user-applied styling
// in the glossary.
// For more information see https://github.com/typst-community/glossarium/pull/190
// Once this is merged, this file here can be deleted as it will be a native feature of glossarium
#let custom-print-title(entry) = {
  let caption = []
  let txt = strong.with(delta: 200)
  let short-val = get-plain-text(entry.at("short", default: ""))
  let long-val = get-plain-text(entry.at("long", default: ""))
  if has-long(entry) and has-short(entry) {
    caption += txt(emph(short-val) + [ -- ] + long-val)
  } else if has-long(entry) {
    caption += txt(long-val)
  } else {
    caption += txt(emph(short-val))
  }
  return caption
}