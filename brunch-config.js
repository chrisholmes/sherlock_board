exports.config = {
  sourceMaps: false,
  production: true,

  modules: {
    wrapper: false,
    definition: false
  },
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/sherlock.js"
    },
    stylesheets: {
      joinTo: "css/sherlock.css"
    }
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: [
      "web/static",
      "test/static"
    ],

    // Where to compile files to
    public: "priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/web\/static\/vendor/]
    },
  },
  npm: {
    enabled: false
  }
};
