(import "src/tester" :prefix "" :exit true)

(var doubled 1)

# deftests is optional
(deftests
  (test "dont eval actual twice*"
    (is (= 2 (do (set doubled (inc doubled))
                 doubled))))

  (test "without is"
    (= 2 (+ 1 1)))

  (test "1 + 1 = 2"
    (is (= 2 (+ 1 1))))

  (test "1 + 2 = 3"
    (is (= 3 (+ 1 2))))

  (test "errors can be tested"
    (is (= "hello" (catch (error "hello")))))

  (test "is works with let"
    (let [expected "expected"
          actual "expected"]
      (is (= expected actual))))

  (test "dont eval actual twice"
    (is (= 3 (do (set doubled (inc doubled))
                 doubled))))

  (test "tuples shouldn't error"
    (is (= ["hello"] (freeze @["hello"]))))

  (test "empty?"
    (is (empty? []))))

# use defsuite to give a suite a name (name is required)
(defsuite "predicates"
  (test "any?"
    (is (any? [true]))))
