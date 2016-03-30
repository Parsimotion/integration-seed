// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

/*
This is a list of dependencies that are used to load the app.
The dependencies listed in client/app/app.coffee must be included here if you want working tests.
Otherwise, they will throw an error like this:
  remove me dummy FAILED
    Error: [$injector:modulerr] Failed to instantiate module...

You must set the environment variables at client/spec/specSetup.coffee too!
*/

module.exports = function(config) {
  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      'client/bower_components/lodash/lodash.js',
      'client/bower_components/jquery/dist/jquery.js',
      'client/bower_components/angular/angular.js',
      'client/bower_components/angular-resource-watcher/build/angular-resource-watcher.js',
      'client/bower_components/angular-mocks/angular-mocks.js',
      'client/bower_components/angular-resource/angular-resource.js',
      'client/bower_components/angular-cookies/angular-cookies.js',
      'client/bower_components/angular-sanitize/angular-sanitize.js',
      'client/bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
      'client/bower_components/angular-ui-router/release/angular-ui-router.js',
      'client/bower_components/angular-translate/angular-translate.js',
      'client/bower_components/angular-translate-loader-url/angular-translate-loader-url.js',
      'client/bower_components/ngSmoothScroll/build/ng-smoothscroll.js',
      'client/spec/specSetup.coffee',
      'client/spec/matchers/*.coffee',
      'client/app/app.js',
      'client/app/app.coffee',
      'client/app/**/*.js',
      'client/app/**/*.coffee',
      'client/components/**/*.js',
      'client/components/**/*.coffee',
      'client/app/**/*.html',
      'client/components/**/*.html'
    ],

    preprocessors: {
      '**/*.html': ['html2js'],
      '**/*.coffee': ['coffee']
    },

    ngHtml2JsPreprocessor: {
      stripPrefix: 'client/'
    },

    ngJade2JsPreprocessor: {
      stripPrefix: 'client/'
    },

    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js')
      }
    },

    // list of files / patterns to exclude
    exclude: [],

    // web server port
    port: 8080,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,

    plugins : ['karma-jasmine', 'karma-phantomjs-launcher', 'karma-coffee-preprocessor']
  });
};
