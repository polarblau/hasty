describe 'hastie', ->

  $comments    = null

  COMMENTS_URL = 'https://api.github.com/repos/rails/rails/commits/b1e55041ebb33a27121eff4424eeeaee4e4b5028/comments'

  # SETUP

  beforeEach ->
    setFixtures "<div id='comments' data-comments-url='#{COMMENTS_URL}'></div>"
    $comments = $('#comments').hastie()


  # SPECS

  describe 'basic jQuery plugin functionality', ->

    it 'should be chainable', ->
      $comments.addClass 'foo'
      expect($comments).toHaveClass('foo')
