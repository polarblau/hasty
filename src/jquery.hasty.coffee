$ = jQuery

$.fn.hasty = (options) ->

  defaults =
    renderer  : Mustache
    template  : """
      <ul>
        {{#commits}}
          <li>
            <span>{{id}}</span>

            {{#comments}}
              <span class='author'>
                <img src='{{user.avatar_url}}' alt='Gravatar' />
                <strong>{{user.login}}</strong>
                said:
              </span>
              <span class='date'>{{created_at}}</span>
              <span class='body'>{{body}}</span>
            {{/comments}}

            {{^comments}}
              <strong class="empty">Sorry, no comments for this commit.</strong>
            {{/comments}}

          </li>
        {{/commits}}
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

  findCommitByID = (haystack, id) ->
    (collection for name in haystack when collection.id == id)

  # --

  this.each ->

    $this = $(@)
    #[{id:1, comments: []}]
    commitIDs = settings.commitIDs || $this.data('commit-ids')
    commits   = []

    success   = (commitID, comments) ->
      collection = findCommitByID(commits, commitID)
      unless collection.length
        commits.push { id: commitID, comments: [] }
        collection = commits[commits.length - 1]

      collection.comments.concat(comments.data)
      console.log comments, collection

    # TODO: error handling for 404/500
    error           = (request, status, error) ->

    commentRequests = []

    for id in commitIDs
      commentRequests.push loadCommentsForCommit(id, success, error)

    $.when.apply($, commentRequests).done ->
      html = settings.renderer.render settings.template,
        commits: commits
      console.log html
      console.log commits
      $this.html html
