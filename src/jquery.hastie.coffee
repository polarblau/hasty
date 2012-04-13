$ = jQuery

$.fn.hastie = (options) ->

  settings = $.extend
    commentsTemplate: 'foo'
    commentTemplate:  'bar'

  defaultTemplate =
  """
    {{#comments}}
      * {{body}}
    {{/comments}}
  """

  render = (comments, container) ->
    output = Mustache.render(defaultTemplate, comments)
    container.html(comments)

  this.each =>
    $this = $(this)
    url   = $this.data('comments-url')

    $.ajax
      url     : url
      success : (comments) =>
        render(comments.data, $this)
      dataType: 'jsonp'

