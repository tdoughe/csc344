(setf *random-state* (make-random-state t))
(setq probDenom 7)
(setq livecount 0)
(setq deadcount 0)



(defun buildarray (N)
  (setf valuearray (make-array (+ 1 N) :initial-element 0))
)

(defun updateprob ()

  (if (>= probDenom 4)
    (progN
      (setq probDenom (- probDenom 1))
	  (setq prob (/ 3.0 probDenom)))
	  (setq prob 1))
    
)

(defun goleft ()
  
  (setq livecount (+ 1 livecount))
)

(defun goright ()
  (setq prob (- 1 prob))
  (setq deadcount (+ 1 deadcount))
)

    
(defun run (N)
  (buildarray N)
  (loadcombo N)
  (setq mylist combo)
  (runlist mylist N) 
  (display N)
)  
  
(setq prob (/ 3.0 probDenom))

(defun runlist (alist N)
  (setq totalprob 1)
  (setq livecount 0)
  (setq deadcount 0)
  (setq currentlist (car alist))
  
  
  (dotimes (z N)
	
	(if (= 1 (nth z currentlist))
	  (progN
	    (goleft)
	    (setq totalprob (* prob totalprob))
		(updateprob))
	  (progN
	    (goright)
        (setq totalprob (* prob totalprob))))	  
	
	
    (setq prob (/ 3.0 probDenom)))
  
  
  
  (setf (aref valuearray livecount) (+ totalprob (aref valuearray livecount)))
  (resets)
  (if (not (null (cdr alist)))
  (runlist (cdr alist) N))
)

(defun display (N)
  (dotimes (z (+ N 1))
     (format t "Chance of ~S gladiators living: ~S (or ~S)~%" z (aref valuearray z) (rationalize (aref valuearray z))))
)
	  
(defun resets ()
 (setq livecount 0)
 (setq deadcount 0)
 (setq probDenom 7.0)
 (setq prob (/ 3.0 probDenom))
)
  
(setf *random-state* (make-random-state t))
(setq alivecounter 0)
(setq numerator 3)
(setq denominator 7)
(setq probability (/ numerator denominator))


(defun arraymaker (N)
  (setq livearray (make-array (+ N 1) :initial-element 0))
)
(defun listmaker (N)
  (setq livelist (make-list (+ N 1) 0))

)
(defun resetsomevals ()
  (setq numerator 3)
  (setq denominator 7)
  (setq probability (/ numerator denominator))
  (setq alivecounter 0)
  
  
)

(defun simulate (N)
  (if (<= (random 1.0) prob)
    (progN
	  (setq alivecounter (+ 1 alivecounter))
	  (if (>= denominator 4)
	    (setq denominator (- denominator 1)))))

  (if (zerop N)
    (setf (aref livearray alivecounter) (+ 1 (aref livearray alivecounter)))
    (simulate (- N 1))
	
  )  
)
  
(defun sim1000 (N)
  (arraymaker N)
  (dotimes (z 1000)
    (simulate (- N 1))
	(resetsomevals)
  )
  (dotimes (z (+ N 1))
    (format t "Number of time ~S gladiators live: ~S~%" z (aref livearray z))
  )
)


  
  
  
  
  
  
  
  
  

  
;;this is a little embarassing but it worked  
  
(defun combinations ( &rest lists)

  (if (car lists)
      (mapcan (lambda (inner-val)
                (mapcar (lambda (outer-val)
                          (cons outer-val
                                inner-val))
                        (car lists)))
              (apply #'combinations (cdr lists)))
    (list nil)))
  
(defun loadcombo (n)
(if (= n 1)	
  (setq combo (combinations '(0 1))))
(if (= n 2)	
  (setq combo (combinations '(0 1) '(0 1))))
(if (= n 3)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1))))
(if (= n 4)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 5)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 6)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 7)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 8)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 9)
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 10)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 11)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 12)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 13)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 14)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 15)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 16)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 17)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 18)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 19)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
(if (= n 20)	
  (setq combo (combinations '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1) '(0 1))))
  )
  
  
