(defun left (tree) (cadr tree))
(defun right (tree) (caddr tree))

(defun task (tree)
    (let ((sum 0))
    (labels ((preorder (tree n)
              (if (numberp (car tree))
                             (if (= (mod (car tree) 7) 0)
                                 (if (= (mod n 2) 1)
                                     (setf sum (+ sum (car tree))))))         
                         (unless (null (left tree))
                             (preorder (left tree) (+ n 1)))
                         (unless (null (right tree))
                             (preorder (right tree) (+ n 1)))))
         (preorder tree 1))
         (return-from task sum)))

(defparameter tree (read))
(print(task tree))
