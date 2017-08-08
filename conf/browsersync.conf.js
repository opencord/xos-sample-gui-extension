
/*
 * Copyright 2017-present Open Networking Foundation

 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at

 * http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


const conf = require('./gulp.conf');
const proxy = require('./proxy');

module.exports = function () {
  return {
    server: {
      baseDir: [
        conf.paths.tmp,
        conf.paths.src
      ],
      middleware: function (req, res, next) {
        if (req.url.indexOf('xosapi') !== -1 || req.url.indexOf('xos') !== -1 || req.url.indexOf('socket') !== -1) {
          proxy.api.web(req, res);
        }
        else {
          next();
        }
      }
    },
    open: false
  };
};
