'use strict';

const helper = require('reliable-cli/lib/helper');

const {
  iosUtils,
  getDepsPkgVersion,
} = require('reliable-cli/lib/helper');

const pkg = require('./package');

module.exports = {
  files: [
    `build/Release-iphonesimulator/${pkg.name}.app`,
    'html'
  ],
  packages: [
    {
      version: iosUtils
        .getFieldFromPlist(`${pkg.name}/${pkg.name}-Info.plist`, 'CFBundleVersion'),
      path: `build/Release-iphonesimulator/${pkg.name}.app/`,
      type: 'Release'
    }
  ],
  testInfo: {
    tests: 1,
    passes: 1,
    passPercent: 1,
    linePercent: 1,
    testHtmlReporterPath: 'html/index.html',
    coverageHtmlReporterPath: 'html/index.html'
  },
  extraInfo: {
    'reliable-cli': getDepsPkgVersion('reliable-cli')
  }
};
