
(cl:in-package :asdf)

(defsystem "new_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "student" :depends-on ("_package_student"))
    (:file "_package_student" :depends-on ("_package"))
  ))