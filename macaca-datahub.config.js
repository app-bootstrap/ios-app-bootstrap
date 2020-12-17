'use strict';

const path = require('path');

module.exports = {
  mode: 'local',
  port: 7001,
  store: path.resolve(__dirname, 'data')
};
