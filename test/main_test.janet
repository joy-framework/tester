(import "src/main" :prefix "")

(deftest
  (test "success"
    (= 2 (+ 1 1)))

  (test "failure"
    (= 1 (+ 1 1))))
