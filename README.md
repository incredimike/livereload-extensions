LiveReload Browser Extensions
=============================

This is a fork from [livereload/livereload-extensions][] caused by the release of Firefox Quantum which dropped support for the previous Firefox extension. This is an interim fork until the LiveReload maintainers pick up our changes

[livereload/livereload-extensions]: https://github.com/livereload/livereload-extensions

Below is the original README contents. Before that is some additional notes

Firefox release process
-----------------------
We've consolidated the release process into a `release.sh` for ease of use

```bash
# Be sure to update CHANGELOG.md and run `git add -p`
# Runs a `git tag` and runs bundler
./release.sh {{version}}
# Example: ./release 2.1.0

# Navigate to addons.mozilla.org (AMO) and upload distribution and its source zip
xdg-open https://addons.mozilla.org/en-US/developers/addon/livereload-web-extension/edit
# Upload dist: `dist/{{version}}/LiveReload-{{version}}-Firefox.zip`
# Upload dist-src: `dist/{{version}}/LiveReload-{{version}}-Firefox.src.zip`
```

-----------

Prerequsities:

* Node.js (0.10.x or later) with npm

Install dependencies:

* `npm install`

Build and package extensions:

    grunt chrome
    grunt firefox
    grunt all

(Safari extension must be built manually, using Safari's GUI packager tool.)

Build CoffeeScript modules, but don't pack:

    grunt build


Release checklist
-----------------

1. Bump version number in `package.json`, run `rake version`, commit.

1. `grunt all`

1. Package Safari extension.

1. Test, test, test.

1. `rake tag`

1. `rake upload:safari`, `rake upload:firefox` or `rake upload:all`

1. Download and verify that uploads worked.

1. `rake upload:manifest`

1. Publish Chrome extension on the Chrome Web Store.
