(set-macro-character #\} (get-macro-character #\)))

(set-dispatch-macro-character #\# #\{
    #'(lambda (stream c1 c2)
	    (declare (ignore c1 c2))
		(let ((lst (read-delimited-list #\} stream t)))
		    `(quote
			    ,(loop for x from (first lst) to (second lst) 
                    when (and (> x 9) (equal (write-to-string x) (reverse (write-to-string x)))) collect x)))))
					
