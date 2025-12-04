# Used by "mix format"
[
  import_deps: [:mneme],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],

  locals_without_parens: [auto_assert: :*]
]
