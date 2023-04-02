(import (scheme base)
        (chicken port)

        (edward cli)
        (edward parse)
        (edward util)
        (edward ed cmd)
        (edward ed addr)
        (edward ed posix)
        (edward ed editor))

;; Executor for the 'z' command.
(define (exec-scroll editor amount)
  (println "amount: " amount)
  (let* ((start  (addr->line editor (make-addr '(current-line))))
         (end    (addr->line editor (make-addr
                                      (cons 'nth-line
                                            (min
                                              (editor-lines editor)
                                              (+ start amount)))))))
    (exec-print editor (cons start end))))

;; Parser for the 'z' command.
(define-edit-cmd (scroll exec-scroll)
  (parse-cmd-char #\z)
  (parse-default
    parse-digits
    (let*-values (((port) (current-output-port))
                  ((rows _) (if (terminal-port? port)
                              (terminal-size port)
                              (values 22 72))))
      rows)))

;; Start the editor
(edward-main)
