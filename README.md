# Open in GitHub App

Opens the current project in GitHub app for [Mac](http://mac.github.com) or [Windows](https://windows.github.com/).

## Features

 * Supports Mac and Windows.
 * Supports multiple project folders.

## Keymaps

On both platforms the default keymap is <kbd>ctrl-alt-g</kbd>.

## Windows

The GitHub app behaves very differently on Windows. Most notably there doesn't seem to be a way to launch the app with a local directory (only a repository URL), which has a few implications:

 * If the repository URL is not known to the app then it will simply open with whichever repository you last had selected.
 * If the repository URL _is_ known to the app but isn't where it expects to find it, then the app will prompt you to clone the repository.

 Essentially you just need to ensure that the GitHub app is already aware of your repository before you try launching it via Atom. And if at any point you move your local repository, ensure the GitHub app is aware of this.

 We've asked GitHub to update the app to allow launching with a local directory, but so far our request seems to have fallen on deaf ears. If by some miracle our request is implemented, we'll update this package and unify the behaviour.

## Mac

 The app pretty much behaves as you would expect and if your project directory is not known to the GitHub app it will be added to its sidebar and remembered.

## Authors

 * Cliff Rowley ([cliffrowley](https://github.com/cliffrowley))
 * James Sconfitto ([jugglingnutcase](https://github.com/jugglingnutcase))

## Contributing

[Issues](https://github.com/cliffrowley/atom-open-in-github-app/issues) and [pull requests](https://github.com/cliffrowley/atom-open-in-github-app/pulls) are always welcome!
