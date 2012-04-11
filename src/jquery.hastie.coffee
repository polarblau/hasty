$ = jQuery

$.fn.hastie = (options) ->

  settings = $.extend
    commentsTemplate: 'foo'
    commentTemplate:  'bar'

  this.each ->
    $this = $(this)
