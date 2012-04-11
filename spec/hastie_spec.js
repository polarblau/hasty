// Generated by CoffeeScript 1.3.1
(function() {

  describe('hastie', function() {
    var $comments, COMMENTS_URL;
    $comments = null;
    COMMENTS_URL = 'https://api.github.com/repos/rails/rails/commits/b1e55041ebb33a27121eff4424eeeaee4e4b5028/comments';
    beforeEach(function() {
      setFixtures("<div id='comments' data-comments-url='" + COMMENTS_URL + "'></div>");
      return $comments = $('#comments').hastie();
    });
    return describe('basic jQuery plugin functionality', function() {
      return it('should be chainable', function() {
        $comments.addClass('foo');
        return expect($comments).toHaveClass('foo');
      });
    });
  });

}).call(this);
