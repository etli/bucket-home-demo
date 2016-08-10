HomeDemo =

  init: ->
    $homeDemo = $('.home-demo')
    currentPage = '.facebook'

    $('.url-bar .dropdown-menu a', $homeDemo).on('click', ->
      $this = $(this)
      targetPage = $this.attr('data-targetpage')
      if !targetPage
        targetPage = currentPage
        return

      HomeDemo.changeDemoPage(targetPage)

      currentPage = targetPage
      $('.current-url').text($this.text())
    )

    $('.scan-button, .extension-button', $homeDemo).on('click', ->
      currentUrl = $('.current-url').text()

      $('.demo-center-action').removeClass('scan').addClass('scanning')
      $('.dropdown-toggle').prop('disabled', true)
      $('.extension-button').prop('disabled', true)

      setTimeout( ->
        $('.demo-center-action').removeClass('scanning').addClass('try-another')
        $('.dropdown-toggle').prop('disabled', false)
        $('.website .page' + currentPage + ' .place-name').addClass('highlight')
        $('.results .result').hide()
        $('.results .result' + currentPage).show()
      , 1500)
    )

    $('.try-another-button', $homeDemo).on('click', ->
      $nextPage = $('.website .page' + currentPage).next()
      if $nextPage.length == 0
        $nextPage = $('.website .page').first()

      nextPageSelector = '.' + $nextPage.attr('class').split(' ')[1]

      HomeDemo.changeDemoPage(nextPageSelector)

      currentPage = nextPageSelector
      $('.current-url').text($('.url-bar .dropdown-menu a' + nextPageSelector).text())
    )

  changeDemoPage: (selector) ->
    $('.website .content').scrollTop(0)
    $('.website .page .place-name').removeClass('highlight')
    $('.website .page').hide()
    $('.website .page' + selector).show()

    $('.demo-center-action').removeClass('try-another').addClass('scan')
    $('.extension-button').prop('disabled', false)
    $('.results .result').hide()
    $('.results .empty').show()

$ ->
  HomeDemo.init();
