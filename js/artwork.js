(function($) {
  'use strict';

  var $body = $('body');

  function applyLayoutClasses(e, $image) {
    var threshold = 1,
        w = $image.data('width'),
        h = $image.data('height');

    if (w / h > threshold) {
      $('.artwork-image-container-left')
        .addClass('artwork-image-container-top')
        .removeClass('artwork-image-container-left');
      $('.artwork-content-container-right')
        .addClass('artwork-content-container-bottom')
        .removeClass('artwork-content-container-right');
      $('.header-container-right')
        .addClass('header-container')
        .removeClass('header-container-right');
    }
  }

  $body.on('image.loaded', applyLayoutClasses);

  $('.artwork-image img').load(function() {
    $(this).data('width', $(this).width());
    $(this).data('height', $(this).height());

    $body.trigger('image.loaded', [$(this)]);
  });

})(jQuery);
