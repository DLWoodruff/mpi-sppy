.. _extensions:

Extensions
==========

This is an advanced topic.

Modifications to the base algorithm (particularly those in the
`phbase` hierarchy) are supported the `Extensions` class. Instead
of hacking in a function that has to be re-hacked in with every release,
function calls are embedded in the code already. That way extensions
or modifications of the algorithms will automatically still be in
place when the software is upgraded. Also, it is possible to write
general extensions that can be used by others.

There are examples of extensions intended to be used for a
variety of applications in the `mpisppy.extensions` directory.
The `mipgapper` example is a good introduction.

The call-out function names are listed in `mpisppy.extensions.extensions`
and their exact location in the code can be found in `phbase` for algorithms
in that hierarchy. Note that some algorithms (e.g.
`aph`) overload key functions so the call-out locations may vary for these algorithms.

It is also possible, of course, to write a "driver" extension that calls other
extensions. This is the way to use more than one extension.

See `mpisppy.examples.sizes.sizes.py` for an example of using an extension with
the `vanilla` PH hub.  If you are not using `vanilla` then pass the extension
class to the `ph_hub` constructor as the `PH_extensions` dictionary entry of the
`opt_kwargs` dictionary entry of the dictionary passed to the
hub constructor (see `vanilla` for an example). 

