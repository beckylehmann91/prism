$(function() {
  $(".photoShow div img").width($(window).width());
  setInterval("nextImage()", 7000);
});

function nextImage() {
  var oCurPhoto = $('.photoShow div.current');  // current pic with z-index 2
  var oNxtPhoto = oCurPhoto.next();       // select next div element with pic
  if (oNxtPhoto.length == 0)
        oNxtPhoto = $('.photoShow div:first');  // cycle back to first image

  oCurPhoto.removeClass('current').addClass('previous');  //current photo remove class add previous
  oNxtPhoto.css('opacity', '0.0').addClass('current').animate( { 'opacity': '1.0' }, 1000,
    function() {
      oCurPhoto.removeClass('previous');
    });
}
