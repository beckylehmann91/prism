$(function(){
  var owl = $("#img-carousel");

  owl.owlCarousel({
    autoPlay: true,
    stopOnHover: true,
    items: 10,                  // 10 imgs over 1000px browser
    itemsDesktop: [1000, 5]     // 5 imgs between 1000px and 901px
    itemsDesktopSmall: [900, 3] // 3 imgs 900px and below
  });

});