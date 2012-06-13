// Generated by CoffeeScript 1.3.1
(function() {
  var $;

  $ = jQuery;

  $.fn.hasty = function(options) {
    var commitAPIURL, commitCommentsAPIURL, defaults, loadCommentsForCommit, repoAPIURL, repoWebURL, settings;
    defaults = {
      renderer: Mustache,
      template: '/hasty/themes/default/template.mustache',
      githubUser: null,
      githubRepo: null,
      commitIDs: null,
      commitsURL: null,
      perPage: 10
    };
    settings = $.extend(defaults, options);
    repoAPIURL = function() {
      return "https://api.github.com/repos/" + settings.githubUser + "/" + settings.githubRepo;
    };
    commitAPIURL = function(commitID) {
      return "" + (repoAPIURL()) + "/commits/" + commitID;
    };
    commitCommentsAPIURL = function(commitID) {
      return "" + (commitAPIURL(commitID)) + "/comments";
    };
    repoWebURL = function() {
      return "https://github.com/" + settings.githubUser + "/" + settings.githubRepo;
    };
    loadCommentsForCommit = function(commitID, success, error) {
      return $.ajax({
        url: commitCommentsAPIURL(commitID),
        success: function(comments) {
          if (success != null) {
            return success(commitID, comments);
          }
        },
        error: error != null ? error : void 0,
        dataType: 'jsonp'
      });
    };
    return this.each(function() {
      var $this, commentRequests, commitComments, commitIDs, error, id, success, _i, _len;
      $this = $(this);
      commitIDs = settings.commitIDs || $this.data('commit-ids');
      commitComments = {};
      success = function(commitID, comments) {
        if (commitComments[commitID] == null) {
          commitComments[commitID] = [];
        }
        return commitComments[commitID].concat(comments);
      };
      error = function(request, status, error) {};
      commentRequests = [];
      for (_i = 0, _len = commitIDs.length; _i < _len; _i++) {
        id = commitIDs[_i];
        commentRequests.push(loadCommentsForCommit(id, success, error));
      }
      return $.when.apply($, commentRequests).done(function() {
        return console.log(commitComments);
      });
    });
  };

}).call(this);
