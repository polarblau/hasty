$ = jQuery

$.fn.hasty = (options) ->

  defaults =
    renderer  : Mustache
    template  : '/hasty/themes/default/template.mustache'
    githubUser: null
    githubRepo: null
    commitIDs : null
    commitsURL: null
    perPage   : 10

  settings = $.extend defaults, options
  console.log settings

  # PATH helpers

  repoAPIURL = ->
    "https://api.github.com/repos/#{settings.githubUser}/#{settings.githubRepo}"

  commitAPIURL = (commitID) ->
    "#{repoAPIURL()}/commits/#{commitID}"

  commitCommentsAPIURL = (commitID) ->
    "#{commitAPIURL(commitID)}/comments"

  repoWebURL = ->
    "https://github.com/#{settings.githubUser}/#{settings.githubRepo}"

  commitCommentsWebURL = (commitID) ->
    "#{settings.githubRepoWebURL()}/commit/#{commitID}#comments"

  commitCommentWebURL = (commitID, commentID) ->
    "#{settings.githubRepoWebURL()}/commit/#{commitID}#commitcomment-#{commentID}"

  # REQUEST helpers

  loadCommit = (commitID, success, error) ->
    $.ajax
      url     : commitAPIURL(commitID)
      success : success if success?
      error   : error if error?
      dataType: 'jsonp'

  # --

  this.each ->

    $this = $(@)

    commitIDs      = settings.commitIDs || $this.data('commit-ids')
    commits        = []
    success        = (commit) -> commits.push commit
    # TODO: error handling for 404/500
    error          = (request, status, error) ->
    commitRequests = []

    for id in commitIDs
      commitRequests.push loadCommit(id, success, error)

    $.when.apply($, commitRequests).done ->
      console.log commits.length
      console.log('all done')


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
