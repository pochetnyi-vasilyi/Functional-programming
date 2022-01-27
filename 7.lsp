(defun check-dig (s)
  (dotimes (i (length s) t)
     (when (null (search (subseq s i (+ i 1)) "0123456789")) (return nil))))
 
(defun check-sum (n)
  (let ((c 1)
        (s 0))
    (dotimes (i 9 (mod (mod s 101) 100))
       (setf s (+ s (* c (mod n 10))))
       (setf n (truncate (/ n 10)))
       (setf c (+ c 1)))))
 
(defun fsnils (snils)
  (let ((sn 0)
        (ds "")
        (cs 0))
    (cond ((not (or (integerp snils) (stringp snils))) "[bad SNILS]")
          ((and (integerp snils) (> snils 99999999999)) "[bad SNILS]")
          ((and (stringp snils) (not (check-dig snils))) "[bad SNILS]")           
          (t (when (stringp snils) (setf sn (parse-integer snils))
                                   (setf ds (format nil "~11,'0d" sn)))
             (when (integerp snils)(setf ds (format nil "~11,'0d" snils)))                      
             (setf cs (check-sum (truncate (/ (parse-integer ds) 100))))
             (if (/= cs  (mod (parse-integer ds) 100)) "[bad SNILS]"
                 (concatenate 'string (subseq ds 0 3) "-" 
                                      (subseq ds 3 6) "-"
                                      (subseq ds 6 9) "-"
                                      (format nil "~2d" cs)))))))
 
(defun prepro (fstr arglist)
  (let ((fstro "")
        (argo nil)
        (pz 0))        
    (loop 
          (setf pz (search "~z" fstr))
          (when (null pz) (return (list (concatenate 'string fstro fstr) (append argo arglist))))
          (setf pz (search "~" fstr))
          (when (null pz) (return (list (concatenate 'string fstro fstr) (append argo arglist))))
          (when (plusp pz) (setf fstro (concatenate 'string fstro (subseq fstr 0 pz)))
                           (setf fstr (subseq fstr pz)))
          (cond ((string= "z" (subseq fstr 1 2))
                 (setf fstro (concatenate 'string fstro (fsnils (car arglist))))
                 (setf fstr (subseq fstr 2))
                 (setf arglist (cdr arglist)))
                (t (setf fstro (concatenate 'string fstro (subseq fstr 0 2)))
                   (setf fstr (subseq fstr 2))
                   (setf argo (append argo (list (car arglist))))
                   (setf arglist (cdr arglist)))))))
                   
(defun format+ (to fstr &rest arglist)
  (let ((p (prepro fstr arglist)))
    (apply #'format (append  (list to (car p)) (cadr p)))))

(eval(read))
