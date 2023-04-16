(import (scheme base)
        (chicken port)
        (chicken process)
        (edward util)
        (edward ed editor))

;; Returns amount of rows of the terminal associated with the given
;; port (or the default output port if not specified). If the port
;; does not refer to a terminal, then a suitable default value is
;; returned.
(define (terminal-rows . o)
    (let*-values (((port) (if (pair? o) (car o) (current-output-port)))
                  ((rows _) (if (terminal-port? port)
                              (terminal-size port)
                              (values 22 72))))
      rows))

;; Select a single item from a list of strings interactively using FZF.
(define (menu-select show-proc lst)
  (let-values (((in out pid) (process "fzf"))
               ((mapping) (map (lambda (x) (cons (show-proc x) x)) lst)))
    (write-string (lines->string (map car mapping)) out)
    (close-output-port out)
    (let-values (((_ succ? exit-code) (process-wait pid)))
      (if succ?
        (let ((recv (port->lines in)))
          (close-input-port in)
          (cdr (assoc (car (car recv)) mapping)))
        (editor-raise "failed to spawn fzf")))))
