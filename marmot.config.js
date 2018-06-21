'use strict';

const helper = require('marmot-cli/lib/helper');

const {
  iosUtils,
  getDepsPkgVersion,
} = require('marmot-cli/lib/helper');

const pkg = require('./package');

module.exports = {
  files: [
    `build/Release-iphonesimulator/${pkg.name}.app`
  ],
  packages: [
    {
      version: iosUtils
        .getFieldFromPlist(`${pkg.name}/Info.plist`, 'CFBundleVersion'),
      path: `build/Release-iphonesimulator/${pkg.name}.app/`,
      type: 'Release'
    }
  ],
  testInfo: {
  },
  extraInfo: {
    'marmot-cli': getDepsPkgVersion('marmot-cli')
  }
};
