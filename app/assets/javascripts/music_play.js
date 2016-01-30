$(function() {

  soundManager.setup({
    onready: function() {
      var music = []

      console.log("length" + gon.sounds.length);

      // create sound variables
      for (var i = 0; i < gon.sounds.length; i++) {
        music[i] = soundManager.createSound({
          url: gon.sounds[0],
        });
      };

      console.log(music)
      // play songs
      console.log(music)
      $('div #play').on('click', function() {
        for(var i = 0; i < gon.sounds[0].length; i++){
          music[i].play();
        }
      });

      // stop playback
      $('div #stop').on('click', function() {
        for(var i = 0; i < gon.sounds[0].length; i++){
          music[i].stop();
        }
      });
    }
  });

});
