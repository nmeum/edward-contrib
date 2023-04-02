(import (scheme base)
        (chicken process)

        (edward cli)
        (edward parse)
        (edward util)
        (edward ed cmd)
        (edward ed addr)
        (edward ed posix)
        (edward ed editor))

(include "util.scm")

;;;;
;; The FZF command.
;;;;

(define (exec-fzf editor)
  (let* ((cmd (string-append "!" "fzf"))
         (out (caar (read-from cmd))))
    (%exec-edit editor out)))

(define-file-cmd (fzf exec-fzf)
  (parse-cmd-char #\F))

;;;;
;; The scroll command.
;;;;

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

(define-file-cmd (scroll exec-scroll (make-addr '(current-line) '(+1)))
  (parse-cmd-char #\z)
  (parse-optional parse-number))

;; Start the editor
(edward-main)
