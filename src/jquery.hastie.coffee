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

  render: (comments) ->
    output = Mustache.render(defaultTemplate, comments)

  this.each ->
    $this = $(this)
    url   = $this.data('comments-url')

    $.ajax
      url     : url
      success : (data) -> render(data.data)
      dataType: 'jsonp'

