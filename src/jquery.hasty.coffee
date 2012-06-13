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

  # PATH helpers

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
      console.log commitComments
      #if commits.length
        #for id in commitIDs

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
