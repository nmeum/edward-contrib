;; This file implements a very silly "parser" for the output of
;; the readtags(1) command which is passed as a list of lines.

(import (scheme base)
        (chicken string)
        (edward util))

(define-record-type Tag
  (make-tag name file regex)
  tag?
  (name tag-name)
  (file tag-file)
  (regex tag-regex))

(define (parse-tags lines)
  (let ((fields (map (lambda (line) (string-split line "\t" #t)) lines)))
    (map (lambda (lst) (apply make-tag lst)) fields)))

(define (get-tag tags nth)
  (list-ref tags (max 0 (dec nth))))
