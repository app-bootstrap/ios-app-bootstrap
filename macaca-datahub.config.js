'use strict';

const path = require('path');

module.exports = {
  mode: 'local',
  port: 7001,
  view: {
    assetsUrl: 'https://npmcdn.com/datahub-view@latest',
  },
  store: path.resolve(__dirname, 'data')
};
