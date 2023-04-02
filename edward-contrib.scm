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
(define (exec-scroll editor %amount)
  (let* ((amount (if %amount %amount (terminal-rows)))
         (start  (addr->line editor (make-addr '(current-line))))
         (end    (addr->line editor (make-addr
                                      (cons 'nth-line
                                            (min
                                              (editor-lines editor)
                                              (+ start amount)))))))
    (exec-print editor (cons start end))))

;; Parser for the 'z' command.
(define-file-cmd (scroll exec-scroll)
  (parse-cmd-char #\z)
  (parse-optional parse-digits))

;; Start the editor
(edward-main)
