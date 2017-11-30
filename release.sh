#!/usr/bin/env bash
# Based on @twolfson's `foundry` and `suplemon/release.sh`
# Exit on first error, unset variable, or pipe failure
set -euo pipefail

# Require our version parameter
set +u
version="$1"
set -u
if test "$version" = ""; then
  echo "Expected a version to be provided to \`release.sh\` but none was provided." 1>&2
  echo "Usage: $0 [version] # (e.g. $0 1.0.0)" 1>&2
  exit 1
fi

# Add a "v" to our version tag
version_tag="v$version"

# Update our versions
node --eval "
  var fs = require('fs');
  var pkg = JSON.parse(fs.readFileSync('./package.json', 'utf8'));
  pkg.version = process.argv[1];
  fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2));
" "$version"
rake version

# Perform our bundling
grunt all

# Commit our release
git add \
  Chrome/LiveReload/manifest.json \
  Firefox/LiveReload/manifest.json \
  LiveReload.safariextension/Info.plist \
  package.json \
  src/common/version.coffee
git commit -m "Release $version_tag"

# Tag the release
git tag "$version_tag"

# Publish the release to GitHub
git push
git push --tags

# Notify user about publishing to AMO
echo "Packaging/tagging complete. Please upload the latest version to AMO at:" 1>&2
echo "  https://addons.mozilla.org/en-US/developers/addon/livereload-web-extension/edit" 1>&2
