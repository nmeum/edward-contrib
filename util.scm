(import (scheme base)
        (chicken port))

(define (terminal-rows . o)
    (let*-values (((port) (if (pair? o) (car o) (current-output-port)))
                  ((rows _) (if (terminal-port? port)
                              (terminal-size port)
                              (values 22 72))))
      rows))
