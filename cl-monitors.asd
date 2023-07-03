(asdf:defsystem cl-monitors
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
  :description "Bindings to libmonitors, allowing the handling of monitors querying and resolution changing."
  :homepage "https://Shirakumo.github.io/cl-monitors/"
  :bug-tracker "https://github.com/Shirakumo/cl-monitors/issues"
  :source-control (:git "https://github.com/Shirakumo/cl-monitors.git")
  :serial T
  :components ((:file "package")
               (:file "low-level")
               (:file "wrapper")
               (:file "documentation"))
  :depends-on (:cffi
               :trivial-features
               :trivial-garbage
               :documentation-utils))
