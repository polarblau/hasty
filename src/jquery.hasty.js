// Generated by CoffeeScript 1.3.1
(function() {
  var $;

  $ = jQuery;

  $.fn.hasty = function(options) {
    var commitAPIURL, commitCommentWebURL, commitCommentsAPIURL, commitCommentsWebURL, loadCommit, repoAPIURL, repoWebURL, settings;
    settings = $.extend({
      renderer: Mustache,
      template: '/hasty/themes/default/template.mustache',
      githubUser: null,
      githubRepo: null,
      commitIDs: null,
      commitsURL: null,
      perPage: 10
    });
    repoAPIURL = function() {
      return "https://api.github.com/repos/" + settings.user + "/" + settings.repo;
    };
    commitAPIURL = function(commitID) {
      return "" + (repoAPIURL()) + "/" + commitID;
    };
    commitCommentsAPIURL = function(commitID) {
      return "" + (commitAPIURL(commitID)) + "/comments";
    };
    repoWebURL = function() {
      return "https://github.com/" + settings.user + "/" + settings.repo;
    };
    commitCommentsWebURL = function(commitID) {
      return "" + (settings.repoWebURL()) + "/commit/" + commitID + "#comments";
    };
    commitCommentWebURL = function(commitID, commentID) {
      return "" + (settings.repoWebURL()) + "/commit/" + commitID + "#commitcomment-" + commentID;
    };
    loadCommit = function(commitID, success, error) {
      return $.ajax({
        url: commitAPIURL(commitID),
        success: success != null ? success() : void 0,
        error: error != null ? error() : void 0,
        dataType: 'jsonp'
      });
    };
    return this.each(function() {
      var $this, commitIDs, error, id, success, _i, _len, _results;
      $this = $(this);
      commitIDs = settings.commitIDs || $this.data('commit-ids');
      success = function(data) {
        return console.log(data);
      };
      error = function() {
        return console.log(arguments);
      };
      _results = [];
      for (_i = 0, _len = commitIDs.length; _i < _len; _i++) {
        id = commitIDs[_i];
        _results.push(loadCommit(id, success, error));
      }
      return _results;
    });
  };

}).call(this);
