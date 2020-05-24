# BaylandsFlight

## Creating builds

To create flashable hex files, run

```
$ make release
```

This creates builds for STM32F7X2 and STM32F405.

## Developing

### Adding a patch

* Create a patch from `<hash>`

```
$ git format-patch -1 <hash>
```

* Add it to the patches/<version> directory
