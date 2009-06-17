
(defun try2 (x y)
  (let ((z (sqrt (- 1000 (* x x) (* y y)))))
    (if (= z (floor z)) z nil)))


(defparam *squares* ())

;; Lets calculate squares
(defun build-squares ()
  (do ((squares '()) (x 1 (+ 1 x))) 
      ((> x 1000) squares)
    (setq squares (nconc squares (list (*  x x))))))

(defun find-trip-sum ()
  (do ((x 1 (+ 1 x)) (res '()))
      ((> x 500) res)
    (do ((y x (+ 1 y)))
	((> (+ y (* 2 x)) 1000) y)
      (let ((z2 (+ (* x x) (* y y))))
        (let ((z (sqrt z2)))
	;(format t "Try ~s ^2 + ~s ^2 = ~s~%" x y z2)
	  (if (= (sqrt z2) (floor (sqrt z2)))
	      (progn 
		(format t " ~s ^2 + ~s ^2   = ~s ^2  ~%" x y z)
		(format t " Sum = ~s ~%" ( + x y z  ))
                (if (= (+ x y z) 1000)
		    (setq res (list x y z (* x y z)))))
	      '()))))))