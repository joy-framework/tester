# Stolen from https://github.com/janet-lang/janet/blob/master/test/helper.janet
# Helper code for running tests

(var num-tests-passed 0)
(var num-tests-run 0)
(var start-time 0)
(var suite-name "")


(defn assert
  "Override's the default assert with some nice error handling."
  [x e]
  (++ num-tests-run)
  (if x
    (++ num-tests-passed)
    (if (empty? suite-name)
      (print "Test: " e)
      (print "Suite: " suite-name "\nTest: " e)))
  x)


(defn test [e x]
  (try
    (assert x e)
    ([err fib]
     (file/write stdout "\n\e[31mx\e[0m ")
     (print e)
     (debug/stacktrace fib err)
     (os/exit 1))))


(defmacro is [form]
  (let [[op expected actual] form]
    ~(let [_op ,op
           len ,(length form)
           _expected ,expected
           _actual (if (= len 2)
                     false
                     ,actual)
           result (if (= len 2)
                    ~,(_op _expected)
                    ~,(_op _expected _actual))]
        (if result
          true
          (do
            (printf "\nFailed: %q" ',form)
            (printf "Expected: %q" (or (= len 2) _expected))
            (printf "Actual: %q" _actual))))))


(defmacro catch [& forms]
  ~(try
     (do ,;forms)
     ([err]
      err)))


(defmacro assert-error
  [msg & forms]
  (def errsym (keyword (gensym)))
  ~(assert (= ,errsym (try (do ,;forms) ([_] ,errsym))) ,msg))


(defmacro assert-no-error
  [msg & forms]
  (def errsym (keyword (gensym)))
  ~(assert (not= ,errsym (try (do ,;forms) ([_] ,errsym))) ,msg))


(defn start-suite [&opt name]
  (when (string? name)
    (set suite-name name))

  (set num-tests-passed 0)
  (set num-tests-run 0)
  (set start-time (os/clock)))


(defn end-suite []
  (let [delta (- (os/clock) start-time)
        failures? (not= num-tests-passed num-tests-run)]

    (printf "%s" (if failures? "\n" ""))

    (unless (empty? suite-name)
      (print "Suite: " suite-name))

    (printf "Tests: %d/%d passed" num-tests-passed num-tests-run)
    (printf "Duration: %.3f seconds" delta)

    (if failures?
      (os/exit 1)
      (print))))


(defmacro deftest [& forms]
  ~(do
     (start-suite)
     ,(splice forms)
     (end-suite)))


(defmacro deftests [& forms]
  ~(deftest ,;forms))


(defmacro defsuite [name & forms]
  ~(do
     (start-suite ,name)
     ,(splice forms)
     (end-suite)))
