// TODO change this when releasing to #import "@preview/nordakademie-templates"
#import "../../src/components/code.typ": codeblock

== Code snippet
  #figure(
    codeblock("../res/rust_example.rs", "rust"),
    caption: [Dummy Rust code to show the code blocks]
  ) <code-snippet>

  == Text
  #lorem(50)