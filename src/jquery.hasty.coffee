$ = jQuery

$.fn.hasty = (options) ->

  defaults =
    renderer  : Mustache
    template  : """
      <ul>
        <li>{{comments.length}}</li>
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
        {{^comments}}
          <li class="empty">Sorry, no comments found.</li>
        {{/comments}}
      </ul>
    """
    githubUser: null
    githubRepo: null
    commitIDs : null
    commitsURL: null
    perPage   : 10

  settings = $.extend defaults, options

  # PATH helpers
  # TODO: parse data-commits-url if existing, regexp
  # move api roots into vars

  repoAPIURL = ->
    "https://api.github.com/repos/#{settings.githubUser}/#{settings.githubRepo}"

  commitAPIURL = (commitID) ->
    "#{repoAPIURL()}/commits/#{commitID}"

  commitCommentsAPIURL = (commitID) ->
    "#{commitAPIURL(commitID)}/comments"

  repoWebURL = ->
    "https://github.com/#{settings.githubUser}/#{settings.githubRepo}"

  # REQUEST helpers

  loadCommentsForCommit = (commitID, success, error) ->
    $.ajax
      url     : commitCommentsAPIURL(commitID)
      success : (comments) ->
        success(commitID, comments) if success?
      error   : error if error?
      dataType: 'jsonp'


  # --

  this.each ->

    $this = $(@)

    commitIDs       = settings.commitIDs || $this.data('commit-ids')
    commitComments  = {}
    success         = (commitID, comments) ->
      commitComments[commitID] ?= []
      commitComments[commitID].concat(comments)

    # TODO: error handling for 404/500
    error           = (request, status, error) ->
    commentRequests = []

    for id in commitIDs
      commentRequests.push loadCommentsForCommit(id, success, error)

    $.when.apply($, commentRequests).done ->
      html = settings.renderer.render settings.template,
        comments: commitComments
      console.log html
      console.log commitComments
      $this.html html
