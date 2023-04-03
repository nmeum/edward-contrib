(import (scheme base)
        (chicken port))

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
