$ = jQuery

$.fn.hasty = (options) ->

  settings = $.extend
    renderer  : Mustache
    template  : '/hasty/themes/default/template.mustache'
    githubUser: null
    githubRepo: null
    commitIDs : null
    commitsURL: null
    perPage   : 10

  # PATH helpers

  repoAPIURL = ->
    "https://api.github.com/repos/#{settings.user}/#{settings.repo}"

  commitAPIURL = (commitID) ->
    "#{repoAPIURL()}/#{commitID}"

  commitCommentsAPIURL = (commitID) ->
    "#{commitAPIURL(commitID)}/comments"

  repoWebURL = ->
    "https://github.com/#{settings.user}/#{settings.repo}"

  commitCommentsWebURL = (commitID) ->
    "#{settings.repoWebURL()}/commit/#{commitID}#comments"

  commitCommentWebURL = (commitID, commentID) ->
    "#{settings.repoWebURL()}/commit/#{commitID}#commitcomment-#{commentID}"

  # REQUEST helpers

  loadCommit = (commitID, success = ->, error = ->) ->
    $.ajax
      url     : commitAPIURL(commitID)
      success : success()
      error   : error()
      dataType: 'jsonp'

  # --

  this.each ->

    $this = $(@)

    commitIDs = settings.commitIDs || $this.data('commit-ids')

    for id in commitIDs
      loadCommit id, (data) -> console.log(data)

    # create a view and save reference
    # View = new Hasty.View($this, settings.template)

    # create repository instance and safe reference
    # Repo = new Hasty.GithubRepo(settings.githubUser, settings.githubRepo)

    # Events
    # Repo.bind 'fetched', View.render()
    # View.bind 'load', Repo.fetch()

    # load the first comments
    # Repo.fetch()

# get commitIDs if not specified
# get commitsURL if not specified
# loop through commits, latest first
#   load commit info
#     load perPage commits
#     if more commits available (commits count in commit data?)
#       load more commits
#     else
#       load next commit
