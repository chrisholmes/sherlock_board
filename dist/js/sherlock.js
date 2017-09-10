'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Widget = exports.SherlockInit = exports.Grid = undefined;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _vue = require('vue');

var _vue2 = _interopRequireDefault(_vue);

var _phoenix = require('phoenix');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Grid = {
  template: '<div class="grid" v-bind:style="gridStyle"><slot></slot></div>',
  props: ["columns", "width", "height", "rows"],
  computed: {
    gridTemplateColumns: function gridTemplateColumns() {
      return "repeat(" + (this.columns || this.defaultColumns) + ", " + (this.width || this.defaultWidth) + ")";
    },
    gridTemplateRows: function gridTemplateRows() {
      return "repeat(" + (this.rows || this.defaultRows) + ", " + (this.height || this.defaultHeight) + ")";
    },
    gridStyle: function gridStyle() {
      return {
        gridTemplateColumns: this.gridTemplateColumns,
        gridTemplateRows: this.gridTemplateRows
      };
    }
  },
  data: function data() {
    return {
      defaultHeight: "200px",
      defaultWidth: "200px",
      defaultRows: 4,
      defaultColumns: 5
    };
  }
};

var SherlockInit = function SherlockInit() {
  return new _vue2.default({
    el: "#grid",
    components: {
      'grid': Grid
    }
  });
};

var JobEvents = function () {
  function JobEvents() {
    _classCallCheck(this, JobEvents);

    this.eventListeners = [];
    this.keepaliveTimer = null;
    this.connect();
  }

  _createClass(JobEvents, [{
    key: 'gotActivity',
    value: function gotActivity() {
      var _this = this;

      if (this.keepaliveTimer != null) clearTimeout(this.keepaliveTimer);
      this.keepaliveTimer = setTimeout(function () {
        _this.connect();
      }, 30 * 1000);
    }
  }, {
    key: 'wrapWithTimer',
    value: function wrapWithTimer(listener) {
      var _this2 = this;

      return function (e) {
        _this2.gotActivity();
        listener(e);
      };
    }
  }, {
    key: 'connect',
    value: function connect() {
      var _this3 = this;

      this.gotActivity();
      var es = new EventSource("/events");
      es.addEventListener('message', function (e) {
        _this3.gotActivity();
      });
      this.eventListeners.forEach(function (eventListener) {
        var wrappedListener = _this3.wrapWithTimer(eventListener.listener);
        es.addEventListener(eventListener.job, wrappedListener);
      });
      this.eventSource = es;
    }
  }, {
    key: 'addEventListener',
    value: function addEventListener(job, listener) {
      this.eventListeners.push({ job: job, listener: listener });
      var wrappedListener = this.wrapWithTimer(listener);
      this.eventSource.addEventListener(job, wrappedListener);
    }
  }]);

  return JobEvents;
}();

var jobEvents = new JobEvents();

var WidgetManager = function () {
  function WidgetManager() {
    _classCallCheck(this, WidgetManager);

    this.base = {
      props: ["job"],
      mounted: function mounted() {
        var _this4 = this;

        jobEvents.addEventListener(this.job, function (e) {
          _this4.payload = JSON.parse(e.data);
        });
      },
      data: function data() {
        return {
          payload: {}
        };
      }
    };
    this.widgets = [];
  }

  _createClass(WidgetManager, [{
    key: 'register',
    value: function register(name, component) {
      component.extends = this.base;
      var box = {
        template: '<div class="box"><widget v-bind:job="job"></widget></div>',
        props: ["job", "widget"],
        components: {
          'widget': component
        }
      };
      _vue2.default.component(name, box);
      return component;
    }
  }]);

  return WidgetManager;
}();

var Widget = new WidgetManager();
exports.Grid = Grid;
exports.SherlockInit = SherlockInit;
exports.Widget = Widget;
