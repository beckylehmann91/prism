$(function () {

  $("#new_post").on("submit", function(event){
    if ($("#post_title").val().length == 0) {
      event.preventDefault();
      alert("Post needs a title");
    }

    // if($("#post_images_attributes_0_filename").val().toLowerCase().endsWith(".png") == false) {
    //   event.preventDefault();
    //   alert("Please include a file in png format.");
    // }
  });


  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#new_post").dropzone({
    // restrict image size to a maximum 1MB
    maxFilesize: 1,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "images[filename][]",
    // show remove links on each image upload
    addRemoveLinks: true
  });


});
