## About cl-monitors
This is a small wrapper library around [libmonitors](https://github.com/Shirakumo/libmonitors), providing independent monitor resolution detection and change support.

## How To
Precompiled versions of the underlying library are included in this. If you want to build it manually however, refer to the [libmonitors](https://github.com/Shirakumo/libmonitors) README.

Load the system through ASDF or Quicklisp and initialise it:

    (ql:quickload :cl-monitors)
    (cl-monitors:init)

Now you can retrieve a list of the monitors on your system:

    (cl-monitors:detect)

You can inspect the available video modes for each of them too:

    (mapcar #'cl-monitors:modes *)

And even switch the mode:

    (cl-monitors:make-current (second (first *)))

Though you probably want to switch back again to your preferred resolution:

    (cl-monitors:make-current (first (first **)))

Once you're all done, don't forget to clean up again after yourself:

    (cl-monitors:deinit)

And that's all there is to it. Well-- almost all. You can query information from the `monitor` and `mode` objects as well of course. For this, see `width`, `height`, `refresh`, `current-p`, `mode`, `name`, and `primary-p`.
