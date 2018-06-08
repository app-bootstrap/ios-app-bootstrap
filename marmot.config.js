'use strict';

const path = require('path');
const helper = require('marmot-cli/lib/helper');

const pkg = require('./package');

module.exports = {
  files: [
    `build/Release-iphonesimulator/${pkg.name}.app`
  ],
  packages: [
    {
      version: helper
        .iosUtils
        .getFieldFromPlist(`${pkg.name}/Info.plist`, 'CFBundleVersion'),
      path: `${pkg.name}.app`,
    }
  ],
  testInfo: {
  },
  extraInfo: {
  }
};
