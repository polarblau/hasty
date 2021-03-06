// Generated by CoffeeScript 1.3.1
(function() {
  var $;

  $ = jQuery;

  $.fn.hasty = function(options) {
    var commitAPIURL, commitCommentsAPIURL, defaults, findCommitByID, loadCommentsForCommit, repoAPIURL, repoWebURL, settings;
    defaults = {
      renderer: Mustache,
      template: "<ul>\n  {{#commits}}\n    <li data-commit-id=\"{{id}}\">\n      <ul>\n        {{#comments}}\n          <li>\n            <span class='author'>\n              <img src='{{user.avatar_url}}' alt='Gravatar' />\n              <strong>{{user.login}}</strong>\n              said:\n            </span>\n            <span class='date'>{{created_at}}</span>\n            <span class='body'>{{body}}</span>\n          </li>\n        {{/comments}}\n        {{^comments}}\n          <li class=\"empty\">Sorry, no comments for this commit.</li>\n        {{/comments}}\n      </ul>\n    </li>\n  {{/commits}}\n</ul>",
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
    findCommitByID = function(haystack, id) {
      var name, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = haystack.length; _i < _len; _i++) {
        name = haystack[_i];
        if (collection.id === id) {
          _results.push(collection);
        }
      }
      return _results;
    };
    return this.each(function() {
      var $this, commentRequests, commitIDs, commits, error, id, success, _i, _len;
      $this = $(this);
      commitIDs = settings.commitIDs || $this.data('commit-ids');
      commits = [];
      success = function(commitID, comments) {
        var collection;
        collection = findCommitByID(commits, commitID);
        if (!collection.length) {
          commits.push({
            id: commitID,
            comments: []
          });
          collection = commits[commits.length - 1];
        }
        collection.comments = collection.comments.concat(comments.data);
        return console.log(comments, collection, comments.data);
      };
      error = function(request, status, error) {};
      commentRequests = [];
      for (_i = 0, _len = commitIDs.length; _i < _len; _i++) {
        id = commitIDs[_i];
        commentRequests.push(loadCommentsForCommit(id, success, error));
      }
      return $.when.apply($, commentRequests).done(function() {
        var html;
        html = settings.renderer.render(settings.template, {
          commits: commits
        });
        return $this.html(html);
      });
    });
  };

}).call(this);
