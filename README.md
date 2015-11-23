JSErl - Erlang/JavaScript Bridge
================================

Imagine if you could do something like this:

    # Erlang                                # JavaScript
    ---------                               -------------
    > jserl:start().                        | Go to: http://localhost:8911/
    > jserl:processes().                    |
    []                                      |
    |                                       > jserl.spawn();
    > jserl:processes().                    > jserl.processes();
    [<0.123.0>]                             [{pid : '0.123.0'}]
    > jserl:spawn().                        |
    <0.234.0>                               |
    > jserl:processes().                    > jserl.processes();
    [<0.123.0>,<0.234.0>]                   [{pid : '0.123.0'}, {pid : '0.234.0'}]

Now, just imagine what you could build with it!

This proof of concept is real and it works. Just clone out the repository and
`make run` to try it out for yourself.

The General Idea
----------------

TODO: Write about the idea and vision.