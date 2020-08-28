# tester

__A testing library for janet__

## Installation

Add the dependency [https://github.com/joy-framework/tester](https://github.com/joy-framework/tester) to your `project.janet` file:

```clojure
(declare-project
  :dependencies ["https://github.com/joy-framework/tester"])
```

## Usage

Create a `.janet` file for testing and use this library like so:


```clojure
(import tester :prefix "" :exit true)

(deftest
  (test "1 + 1 = 2"
    (is (= 2 (+ 1 1))))

  (test "expected = actual"
    (let [expected "expected"
          actual "expected"]
      (is (= expected actual)))))
```

Run your tests from the terminal with `jpm test` in your project directory

```sh
jpm test
```

For a better workflow, use [entr](https://github.com/eradman/entr) to restart `jpm test` automatically on a file change like this:

```clojure
; # ... rest of project.janet above

(phony "watch" []
  (os/shell "find . -name '*.janet' | entr -r -d jpm test"))
```

Then run this from the terminal and you're all set to get a fast running test suite on any file change in `src` or in `test`

```sh
jpm run watch
```

## Contribute

Any issues or pull requests are welcome!

## License

MIT
