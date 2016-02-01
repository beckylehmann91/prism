$(document).ready(function(){
  var owl = $("#img-carousel");

  owl.owlCarousel({
    autoPlay: true,
    stopOnHover: true,
    items: 7,                   // 7 imgs over 1000px browser
    itemsDesktop: [1000, 5],    // 5 imgs between 1000px and 901px
    itemsDesktopSmall: [900, 3],// 3 imgs 900px and below
    itemsTablet: [600, 2],      // 2 items between 600 and 0
    itemsMobile: false          // inherit from tablet
  });

});