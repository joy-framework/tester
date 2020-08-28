(declare-project
  :name "tester"
  :description "A testing library for janet"
  :dependencies []
  :author "Sean Walker"
  :license "MIT"
  :url "https://github.com/joy-framework/tester"
  :repo "git+https://github.com/joy-framework/tester")

(declare-source
  :source @["src/tester.janet"])

(phony "watch" []
  (os/shell "find . -name '*.janet' | entr -r -d jpm test"))
