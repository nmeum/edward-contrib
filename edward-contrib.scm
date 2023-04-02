(import (scheme base)

        (edward cli)
        (edward parse)
        (edward util)
        (edward ed cmd)
        (edward ed addr)
        (edward ed posix)
        (edward ed editor))

(include "util.scm")

;; Executor for the 'z' command.
(define (exec-scroll editor start %amount)
  (let* ((amount (if %amount
                   %amount
                   (max 0 (- (terminal-rows) 2)))) ;; -2 for cur/nxt prompt
         (end    (addr->line editor (make-addr
                                      (cons 'nth-line
                                            (min
                                              (editor-lines editor)
                                              (+ start amount)))))))
    (exec-print editor (cons start end))))

;; Parser for the 'z' command.
(define-file-cmd (scroll exec-scroll (make-addr '(current-line) '(+1)))
  (parse-cmd-char #\z)
  (parse-optional parse-digits))

;; Start the editor
(edward-main)
