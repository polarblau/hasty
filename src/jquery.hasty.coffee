$ = jQuery

$.fn.hasty = (options) ->

  defaults =
    renderer  : Mustache
    template  : """
      <ul>
        {{#commits}}
          <li data-commit-id="{{id}}">
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
              {{^comments}}
                <li class="empty">Sorry, no comments for this commit.</li>
              {{/comments}}
            </ul>
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

  # TODO: Remove what we don't use
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
    collection for name in haystack when collection.id == id

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
      # TODO: "make" proper data collection with user provided methods etc.
      collection.comments = collection.comments.concat(comments.data)
      console.log comments, collection, comments.data

    # TODO: error handling for 404/500
    error           = (request, status, error) ->

    commentRequests = []

    # add loading class
    for id in commitIDs
      commentRequests.push loadCommentsForCommit(id, success, error)

    $.when.apply($, commentRequests).done ->
      # remove loading class
      html = settings.renderer.render settings.template,
        commits: commits
      $this.html html
