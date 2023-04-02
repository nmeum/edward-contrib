(import (scheme base)
        (srfi 1)
        (srfi 14)
        (chicken process)

        (edward cli)
        (edward parse)
        (edward util)
        (edward ed cmd)
        (edward ed addr)
        (edward ed posix)
        (edward ed editor))

(include "util.scm")
(include "ctags.scm")

;;;;
;; The ctags command.
;;;;

(define (exec-tag editor name)
  (let* ((cmd (string-append "!" "readtags -n - " name))
         (out (car (read-from cmd))))
    (if (null? out)
      (editor-error editor (string-append "tag not found: " name))
      (let* ((tags (parse-tags out))
             (tag  (get-tag tags 1)))
        (unless (equal? (tag-file tag) (text-editor-filename editor))
          (%exec-edit editor (tag-file tag)))
        (let* ((addrlst (parse parse-addrs (tag-regex tag)))
               (lpair   (addrlst->lpair editor addrlst)))
          (exec-print editor lpair))))))

(define-file-cmd (tag exec-tag)
  (parse-cmd-char #\T)
  (parse-token char-set:graphic))

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
