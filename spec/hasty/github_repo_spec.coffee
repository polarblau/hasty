describe 'Hasty.Github', ->

  beforeEach ->
    @github = new Hasty.Github('user', 'repo')

  #

  describe 'paths', ->
    describe 'API', ->

      it '#repoAPIURL', ->
        expect(@github.repoAPIURL())
          .toEqual('https://api.github.com/repos/user/repo')

      it '#commitAPIURL', ->
        expect(@github.commitAPIURL('123'))
          .toEqual('https://api.github.com/repos/user/repo/123')

      it '#commitCommentsAPIURL', ->
        expect(@github.commitCommentsAPIURL('123'))
          .toEqual('https://api.github.com/repos/user/repo/123/comments')

    describe 'Web', ->
      it '#repoWebURL', ->
        expect(@github.repoWebURL())
          .toEqual('https://github.com/user/repo')

      it '#commitCommentsWebURL', ->
        expect(@github.commitCommentsWebURL('123'))
          .toEqual('https://github.com/user/repo/commit/123#comments')

      it '#commitCommentWebURL', ->
        expect(@github.commitCommentWebURL('123', '456'))
          .toEqual('https://github.com/user/repo/commit/123#commitcomment-456')

