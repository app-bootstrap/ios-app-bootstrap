'use strict';

const helper = require('marmot-cli/lib/helper');

const {
  iosUtils,
  getDepsPkgVersion,
} = require('marmot-cli/lib/helper');

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
    'marmot-cli': getDepsPkgVersion('marmot-cli')
  }
};
