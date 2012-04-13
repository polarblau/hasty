$ = jQuery

$.fn.hastie = (options) ->

  settings = $.extend
    commentsTemplate: 'foo'
    commentTemplate:  'bar'

  defaultTemplate =
  """
    <ul>
      {{#comments}}
        <li>{{body}}</li>
      {{/comments}}
    </ul>
  """

  render = (comments, $container) ->
    console.log $container
    output = Mustache.render(defaultTemplate, comments: comments)
    $container.html(output)

  this.each ->
    $this = $(this)
    url   = $this.data('comments-url')

    $.ajax
      url     : url
      success : (comments) ->
        console.log $this, $(this)
        render(comments.data, $this)
      dataType: 'jsonp'

