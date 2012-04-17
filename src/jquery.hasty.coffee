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
    githubUser = settings.githubUser || $this.data('github-user')
    githubRepo = settings.githubRepo || $this.data('github-repo')
    comments   = []

    githubRepoURL = ->
      "https://api.github.com/repos/#{githubUser}/#{githubRepo}"

    commitURL = (commitID) ->
      "#{githubRepoURL()}/#{commitID}"

    commitCommentsURL = (commitID) ->
      "#{commitURL(commitID)}/comments"

    loadCommits = ->
      # loop through commit IDs
      # load commit information from github

    loadComments = ->
      # loop through commits and load comments
      # until page is full

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
