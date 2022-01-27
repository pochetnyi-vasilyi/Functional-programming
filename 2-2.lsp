(defvar x 0)
(setf x (read))


(defun change-byte (b)
	(setf b
		  (dpb (ldb (byte 4 4) b) (byte 4 0)
			   (dpb (ldb (byte 4 0) b) (byte 4 4) b))))

(dotimes (i (ceiling (integer-length x) 8))
		(setf x
			(dpb
				(change-byte (ldb (byte 8 (* i 8)) x))
				(byte 8 (* i 8)) x)))

(print x)
