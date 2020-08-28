(import "src/tester" :prefix "" :exit true)

(deftest
  (test "without is"
    (= 2 (+ 1 1)))

  (test "1 + 1 = 2"
    (is (= 2 (+ 1 1))))

  (test "1 + 2 = 3"
    (is (= 3 (+ 1 2))))

  (test "errors can be tested"
    (is (= "hello" (catch (error "hello"))))))
