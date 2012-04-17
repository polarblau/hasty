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

  template = ->
    # resolve, load, cache template

  loadTemplate = (url) ->
    # load template if settings.template is path

  validateSettings = ->
    # check settings and throw errors if invalid
    # does the renderer implement #render?
    # return true if valid
    true

  render = (comments, $container) ->
    output = settings.renderer.render(defaultTemplate, comments: comments)
    $container.html(output)


  this.each ->

    $this      = $(this)
    commitIDs  = settings.commitIDs  || $this.data('commit-ids')
    #githubUser = settings.githubUser || $this.data('github-user')
    #githubRepo = settings.githubRepo || $this.data('github-repo')
    comments   = []

    # PATH helpers
    github =
      user: settings.githubUser || $this.data('github-user')
      repo: settings.githubRepo || $this.data('github-repo')

      API:
        repo: ->
          "https://api.github.com/repos/#{@user}/#{@repo}"

        commit: (commitID) ->
          "#{githubAPI.repo()}/#{commitID}"

        commitComments: (commitID) ->
          "#{github.commit(commitID)}/comments"

      web:
        repo: ->
          "https://github.com/#{@user}/#{@repo}"

        commitComments: (commitID) ->
          "#{github.repo()}/commit/#{commitID}#comments"

        commitComment: (commitID, commentID) ->
          "#{github.repo()}/commit/#{commitID}#commitcomment-#{commentID}"


    loadCommits = ->
      # loop through commit IDs
      # load commit information from github

    loadComments = ->
      # loop through commits and load comments
      # until page is full

      # load first commit —> load 0 – 10 comments for commit

    loadAndRender = ->
      unless commitIDs.length <= 0
        commitID = commitIDs.shift()
        # TODO: First load commits, then comments
        $.ajax
          url     : commitCommentsURL(commitID)
          success : (response) ->
            comments = comments.concat(response.data)
            if comments.length < settings.perPage
              loadAndRender()
            render(comments, $this)
            # TODO: if still more loading happening, indicate
          dataType: 'jsonp'

    loadAndRender()
