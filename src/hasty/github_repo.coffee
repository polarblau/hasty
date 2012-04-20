class GithubRepo

  constructor: (user, repo) ->
    [@user, @repo] = [user, repo]

  # Path helpers

  repoAPIURL: ->
    "https://api.github.com/repos/#{@user}/#{@repo}"

  commitAPIURL: (commitID) ->
    "#{@repoAPIURL()}/#{commitID}"

  commitCommentsAPIURL: (commitID) ->
    "#{@commitAPIURL(commitID)}/comments"

  repoWebURL: ->
    "https://github.com/#{@user}/#{@repo}"

  commitCommentsWebURL: (commitID) ->
    "#{@repoWebURL()}/commit/#{commitID}#comments"

  commitCommentWebURL: (commitID, commentID) ->
    "#{@repoWebURL()}/commit/#{commitID}#commitcomment-#{commentID}"


window['Hasty'] ||= {}
window['Hasty']['GithubRepo'] = GithubRepo
