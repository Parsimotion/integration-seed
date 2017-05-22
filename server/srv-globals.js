if (process.env.NEW_RELIC_APP_NAME !== undefined)
  require("newrelic");

require("coffee-script/register");

// --------
// include: (to `require`(...) with absolute paths)
// --------
base_dir = __dirname;

abs_path = function(path) {
  return base_dir + "/" + path;
};

global.include = function(file) {
  return require(abs_path(file));
};

global._ = require("lodash");

// ECONNRESET
process.on("uncaughtException", function (err) {
  console.error(err);
  if (err.toString().indexOf("ECONNRESET") == -1) {
    throw err
  }
});
