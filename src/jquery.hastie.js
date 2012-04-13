// Generated by CoffeeScript 1.3.1
(function() {
  var $;

  $ = jQuery;

  $.fn.hastie = function(options) {
    var defaultTemplate, settings;
    settings = $.extend({
      commentsTemplate: 'foo',
      commentTemplate: 'bar'
    });
    defaultTemplate = "{{#comments}}\n  * {{body}}\n{{/comments}}";
    ({
      render: function(comments) {
        var output;
        return output = Mustache.render(defaultTemplate, comments);
      }
    });
    return this.each(function() {
      var $this, url;
      $this = $(this);
      url = $this.data('comments-url');
      return $.ajax({
        url: url,
        success: function(data) {
          return render(data.data);
        },
        dataType: 'jsonp'
      });
    });
  };

}).call(this);
