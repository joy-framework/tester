# Stolen from https://github.com/janet-lang/janet/blob/master/test/helper.janet
# Helper code for running tests

(var num-tests-passed 0)
(var num-tests-run 0)
(var numchecks 0)
(var start-time 0)

(defn assert
  "Override's the default assert with some nice error handling."
  [x e]
  (++ num-tests-run)
  (when x (++ num-tests-passed))
  (if x
    (do
      (++ numchecks)
      (file/write stdout "\e[32m.\e[0m"))
    (do
      (set numchecks 0)
      (print "\n" e)))
  x)

(defn test [e x]
  (assert x e))

(defmacro assert-error
  [msg & forms]
  (def errsym (keyword (gensym)))
  ~(assert (= ,errsym (try (do ,;forms) ([_] ,errsym))) ,msg))

(defmacro assert-no-error
  [msg & forms]
  (def errsym (keyword (gensym)))
  ~(assert (not= ,errsym (try (do ,;forms) ([_] ,errsym))) ,msg))

(defn start-suite []
  (set start-time (os/clock)))

(defn end-suite []
  (def delta (- (os/clock) start-time))
  (printf "\n\n%d/%d tests passed in %.3f seconds\n" num-tests-passed num-tests-run delta)
  (if (not= num-tests-passed num-tests-run) (os/exit 1)))

(defmacro deftest [& forms]
  ~(do
     (start-suite)
     ,(splice forms)
     (end-suite)))
