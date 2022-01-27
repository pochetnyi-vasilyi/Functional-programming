(defun task (a)
 (let ((la (array-dimensions a)) (v nil) (p nil) (al nil))
   (dotimes (i (car la) t)
     (dotimes (j (cadr la) t)
	   (dotimes (k (caddr la) t)
	     (setf v (aref a i j k))
		 (setf p (assoc v al))
		 (if (null p) (push (cons v 1) al) (push (cons v (+ 1 (cdr p))) al)))))
		 
 (print (apply 'max (mapcar 'cdr al)))))
 
(defparameter a (read))
(task a)
