# tester
A testing library for janet

## Installation

Add the dependency [https://github.com/jets-framework/tester](https://github.com/jets-framework/tester) to your `project.janet` file:

```clojure
(declare-project
  :dependencies ["https://github.com/jets-framework/tester"])
```

## Usage

Create a `.janet` file for testing and use this library like so:


```clojure
(import tester :prefix "")

(deftest
  (test "1 and 1 equals 2"
    (= 2 (+ 1 1))))
```

Run your tests from the terminal with `jpm test` in your project directory

```sh
jpm test
```

For a better workflow, use [fswatch](https://github.com/emcrisostomo/fswatch) to restart `jpm test` from a `Makefile` automatically on a file change like this:

```sh
# Create a Makefile in your project dir that looks like this
.PHONY: test

test:
	jpm test

watch:
	fswatch -o src test | xargs -n1 -I{} make
```

Then run this from the terminal and you're all set to get a *fast* running test suite on any file change in `src` or in `test`

```sh
make watch
```

## Contribute

Any issues or pull requests are welcome!

## License

MIT
