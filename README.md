# sel4-example

## Run example itself

Due to some setting problems in [qemu](https://wiki.qemu.org/Documentation/Platforms), we use arm to simulate.

```
# create build dir
$ mkdir build && cd build
# ../init-build.sh -DPLATFORM=qemu-arm-virt -DSIMULATION=TRUE
```

All the available platforms are as follows:
```
 Valid platforms are:
  "allwinnerA20;am335x;apq8064;ariane;bcm2711;bcm2837;exynos4;exynos5;fvp;hifive;hikey;imx6;imx7;imx8mq-evk;imx8mm-evk;maaxboard;odroidc2;odroidc4;omap3;pc99;polarfire;qemu-arm-virt;qemu-riscv-virt;quartz64;rocketchip;rockpro64;spike;tk1;tqma8xqp1gb;tx1;tx2;zynq7000;zynqmp;rocketchip-base;rocketchip-zcu102;sabre;wandq;nitrogen6sx;rpi3;rpi4;exynos5250;exynos5410;exynos5422;am335x-boneblack;am335x-boneblue;am335x-bone;zcu102;ultra96;ultra96v2;x86_64;ia32"
```


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

## Notes

* cpio

  Fix this [damn linker error](https://github.com/seL4/rumprun/blob/0be59c66494209d1d379fea5dbdd09aa23f54934/platform/sel4/entry.c#L54)

```
usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: seL4_libs/libsel4utils/libsel4utils.a(process.c.obj): in function `sel4utils_configure_process_custom':
/host/projects/sel4_libs/libsel4utils/src/process.c:557: undefined reference to `_cpio_archive_end'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /host/projects/sel4_libs/libsel4utils/src/process.c:557: undefined reference to `_cpio_archive_end'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /host/projects/sel4_libs/libsel4utils/src/process.c:557: undefined reference to `_cpio_archive'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /host/projects/sel4_libs/libsel4utils/src/process.c:557: undefined reference to `_cpio_archive'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /host/projects/sel4_libs/libsel4utils/src/process.c:558: undefined reference to `_cpio_archive'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /host/projects/sel4_libs/libsel4utils/src/process.c:558: undefined reference to `_cpio_archive'
collect2: error: ld returned 1 exit status
[3/67] Generating kernel_all_pp_prune.c
ninja: build stopped: subcommand failed.

```
