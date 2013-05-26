Imagine if you could do something like this:

    # Erlang                                # JavaScript
    ---------                               -------------
    > application:start(jserl).             | Go to: http://localhost:8911/
    > jserl:processes().                    |
    []                                      |
    |                                       > jserl.spawn();
    > jserl:processes().                    > jserl.processes();
    [<0.123.0>]                             [{pid : '0.123.0'}]
    > jserl:spawn().                        |
    <0.234.0>                               |
    > jserl:processes().                    > jserl.processes();
    [<0.123.0>,<0.234.0>]                   [{pid : '0.123.0'}, {pid : '0.234.0'}]

Now, imagine where you could take it. This proof of concept is real and it works. Just
clone the code and `make run`, and try it out for yourself.
