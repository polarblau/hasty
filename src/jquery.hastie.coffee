$ = jQuery

$.fn.hastie = (options) ->

  settings = $.extend {}

  defaultTemplate =
  """
    <ul>
      {{#comments}}
        <li>{{body}}</li>
      {{/comments}}
    </ul>
  """

  render = (comments, $container) ->
    output = Mustache.render(defaultTemplate, comments: comments)
    $container.html(output)

  interpolate = (string, replacements) ->
    for key, value of replacements
      string.replace("{#{key}}", value)

  this.each ->
    $this     = $(this)
    commitIDs = $this.data('commit-ids')
    url       = interpolate $this.data('comments-url'), sha: commitIDs[0]

    $.ajax
      url     : url
      success : (comments) ->
        render(comments.data, $this)
      dataType: 'jsonp'

