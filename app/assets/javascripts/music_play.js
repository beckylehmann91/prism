$(function() {
  soundManager.setup({
    // where to find flash audio SWFs, as needed
    url: '',
    onready: function() {
      // SM2 is ready to play audio!
        // create "mySound"...
      var mySound1 = soundManager.createSound({
        url: gon.sounds[0],
      });

      var mySound2 = soundManager.createSound({
        url: gon.sounds[1],
      });

      var mySound3 = soundManager.createSound({
        url: gon.sounds[2],
      });
        // ...and play it
      $('div #play').on('click', function() {
        mySound1.play();
        mySound2.play();
        mySound3.play();
      });

      // ...and play it
      $('div #stop').on('click', function() {
        mySound1.stop();
        mySound2.stop();
        mySound3.stop();
      });
    }
  });
});
