# buffer-change

Buffer-Change provides a hook run after buffer changed.

## Usage

``` emacs-lisp
(require 'buffer-change)
(add-hook 'buffer-change-hook #'some-func)
(buffer-change-setup)
```
