$ = jQuery

$.fn.hasty = (options) ->

  settings = $.extend
    perPage: 10

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

  this.each ->
    $this         = $(this)
    commitsURL    = $this.data('commits-urls')
    commitIDs     = $this.data('commit-ids')
    comments      = []

    commitCommentsURL = (commitID) ->
      "#{commitsURL}/#{commitID}/comments"

    loadAndRender = ->
      commitID = commitIDs.shift()
      $.ajax
        url     : commitCommentsURL(commitID)
        success : (comments) ->
          comments.push(comments.data)
          if comments.length < settings.perPage
            loadAndRender()
          else
            render(comments, $this)
        dataType: 'jsonp'
