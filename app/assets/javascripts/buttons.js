$(function () {

  $("#new_post").on("submit", function(event){
    if ($("#post_title").val().length == 0) {
      event.preventDefault();
      alert("Post needs a title");
    }

    if($("#post_images_attributes_0_filename").val().toLowerCase().endsWith(".png") == false) {
      event.preventDefault();
      alert("Please include a file in png format.");
    }
  })
});
