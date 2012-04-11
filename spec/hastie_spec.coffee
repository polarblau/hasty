describe 'hastie', ->

  $comments    = null

  COMMENTS_URL = 'https://api.github.com/repos/rails/rails/commits/b1e55041ebb33a27121eff4424eeeaee4e4b5028/comments'

  # SPECS
  #
  # validate URL

  describe 'basic jQuery plugin functionality', ->

    beforeEach ->
      setFixtures "<div id='comments' data-comments-url='#{COMMENTS_URL}'></div>"
      $comments = $('#comments').hastie()

    it 'should be chainable', ->
      $comments.addClass 'foo'
      expect($comments).toHaveClass('foo')


  describe 'API requests', ->

    beforeEach ->
      setFixtures "<div id='comments' data-comments-url='#{COMMENTS_URL}'></div>"

    it 'should make an AJAX request to COMMENTS_URL', ->
      spyOn $, 'ajax'
      $comments = $('#comments').hastie()
      expect($.ajax).toHaveBeenCalled()
