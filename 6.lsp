(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

(defmacro do-primes ((var startv endv) &body body)
  `(do ((,var (next-prime ,startv) (next-prime (1+ ,var))))
       ((> ,var ,endv))
     ,@body))

(defparameter s (read))
(print (with-output-to-string (*standard-output*) (do-primes (i (elt s 0) (elt s 1)) (princ i)) (do-primes (i (elt s 2) (elt s 3)) (princ i))))
