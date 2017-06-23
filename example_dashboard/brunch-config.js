var fs = require('fs');
var widgetsDir = "widgets/"
var widgets = fs.readdirSync(widgetsDir).filter(function(file) {
  return file.match(/.*vue$/)
}).map(function(file) { return widgetsDir + file});

exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/web/static/assets". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(web\/static\/assets)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: [
      widgetsDir
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
    vue: {
      globalizeComponents: true,
      extractCSS: true,
      out: 'priv/static/css/components.css'
    },
  },

  modules: {
    autoRequire: {
      "js/app.js": ["widgets/deps"].concat(widgets)
    }
  },

  npm: {
    enabled: true,
    // Whitelist the npm deps to be pulled in as front-end assets.
    // All other deps in package.json will be excluded from the bundle.
    styles: { sherlock: ["priv/static/css/sherlock.css"] },
    aliases: {
      vue: 'vue/dist/vue.common.js',
    }
  }
};
