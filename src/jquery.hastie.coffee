$ = jQuery

$.fn.hastie = (options) ->

  settings = $.extend
    commentsTemplate: 'foo'
    commentTemplate:  'bar'

  this.each ->
    $this = $(this)
    url   = $this.data('comments-url')

    $.ajax
      url     : url
      success : (data) -> console.log data
      dataType: 'jsonp'

