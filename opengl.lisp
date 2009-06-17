(in-package "CL-USER")

(require "COCOA")

(eval-when (:compile-toplevel :load-toplevel :execute)
  (objc:load-framework "OpenGL" :gl))

(defclass simple-gl-view (ns:ns-opengl-view)
  ()
  (:metaclass ns:+ns-object))

(objc:defmethod (#/drawRect: :void) ((self simple-gl-view) (rect :<NSR>ect))
  (#_glClearColor 0.0 0.0 0.0 0.0)
  (#_glClear #$GL_COLOR_BUFFER_BIT)
  (draw-all-stuff)
  (#_glFlush))

(defun draw-stuff (x y)
  (#_glColor3f (- 1.0 (* y 0.1 x)) (* y 0.1 x) 0.35)
  (#_glBegin #$GL_TRIANGLES)
   (#_glVertex3f 0.0 (- 0.5 (* 0.1 x)) 0.0)
   (#_glColor3f 0.1 (* y 0.01 x) (* y 0.3 x))
   (#_glVertex3f -0.5 -0.5 0.0)
   (#_glColor3f (* y 0.1 x) (* y 0.1 x) 0.35)
   (#_glVertex3f 0.5 -0.5 0.0)
  (#_glEnd))

(defun draw-all-stuff ()
  (dolist (x '(1 2 3 4 5 6 7 8 9))
    (draw-stuff x 1)
    (draw-stuff (+ 0.5 x) -1)))

(defun show-simple-gl ()
  (ns:with-ns-rect (frame 0 0 300 300)
    (let* ((w (make-instance 'ns:ns-window
			     :with-content-rect frame
			     :style-mask (logior #$NSTitledWindowMask
						 #$NSClosableWindowMask
						 #$NSMiniaturizableWindowMask)
			     :backing #$NSBackingStoreBuffered
			     :defer t))
	   (v (make-instance 'simple-gl-view)))
      (#/setContentView: w v)
      (#/release v)
      (#/center w)
      (#/orderFront: w nil))))