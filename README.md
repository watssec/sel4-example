# sel4-example

## single_generation

In order for the password manager to be processed by c-parser, I manually removed all the included library.

`seL4_Word` -> long int
`Boolean representation` -> char 0/1

## Isabelle Jedit

Increase the number of allowed trace to get ride of the prompt:

`Trace paused, 100, 1000, 10000 more?`
Adjust the default limit in `<ISABELLE_HOME>/etc/options`, value `editor_tracing_messages`

[Reference](https://andriusvelykis.github.io/isabelle-eclipse/features/prover-output.html)

## Abstract Spec

There is not so much reference to look up, I mainly used this [course material](https://www.cse.unsw.edu.au/~cs4161/) as a reference.

Several things to pay attention to when writing the abstract specifications:

* \leftarrow assignment is only used with non-monad functions.
* If a functional specification requires to be in monad type, it cannot directly use other monads.
