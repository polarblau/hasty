$ = jQuery

$.fn.hasty = (options) ->

  settings = $.extend
    perPage: 10

  defaultTemplate =
  """
    <ul>
      {{#comments}}
        <li>
          <span class='author'>
            <img src='{{user.avatar_url}}' alt='Gravatar' />
            <strong>{{user.login}}</strong>
            said:
          </span>
          <span class='date'>{{created_at}}</span>
          <span class='body'>{{body}}</span>
        </li>
      {{/comments}}
    </ul>
  """

  render = (comments, $container) ->
    console.log(comments)
    output = Mustache.render(defaultTemplate, comments: comments)
    $container.html(output)

  this.each ->
    $this         = $(this)
    commitsURL    = $this.data('commits-url')
    commitIDs     = $this.data('commit-ids')
    comments      = []

    commitCommentsURL = (commitID) ->
      "#{commitsURL}/#{commitID}/comments"

    loadAndRender = ->
      unless commitIDs.length <= 0
        commitID = commitIDs.shift()
        $.ajax
          url     : commitCommentsURL(commitID)
          success : (response) ->
            comments = comments.concat(response.data)
            if comments.length < settings.perPage
              loadAndRender()
            render(comments, $this)
          dataType: 'jsonp'

    loadAndRender()
