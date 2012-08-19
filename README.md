# bhundven’s dotfiles
Note, this is a partial fork of [Mathias Bynens](http://mathiasbynens.be/) dotfiles, because mine is different (Linux, not Mac).

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/bhundven/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
./bootstrap.sh -f
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/bhundven/dotfiles/issues)!

## Thanks to…
* [Mathias Bynens](http://mathiasbynens.be/)
* And everyone he thanks in his [dotfiles README](https://github.com/mathiasbynens/dotfiles/blob/master/README.md#thanks-to%E2%80%A6)
