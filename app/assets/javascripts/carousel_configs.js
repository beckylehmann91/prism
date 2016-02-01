$(document).ready(function(){
  var owl = $("#img-carousel");

  owl.owlCarousel({
    autoPlay: true,
    stopOnHover: true,
    items: 5,                   // 7 imgs over 1000px browser
    itemsDesktop: [1400, 5],    // 5 imgs between 1000px and 901px
    itemsDesktopSmall: [1399, 4],// 3 imgs 900px and below
    itemsTablet: [900, 3],      // 2 items between 600 and 0
    itemsTabletSmall: [899, 2],
    itemsMobile: [599, 1]          // inherit from tablet
  });

});
