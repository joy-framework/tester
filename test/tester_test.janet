(import "src/tester" :prefix "" :exit true)

(defsuite # gives you timing information, optional
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
    (do
      (var x 1)
      (is (= 2 (do (set x (inc x))
                   x)))))

  (test "tuples shouldn't error"
    (is (= ["hello"] (freeze @["hello"]))))

  (test "empty?"
    (is (empty? []))))

(defsuite "predicates"
  (test "any?"
    (is (any? [true]))))
