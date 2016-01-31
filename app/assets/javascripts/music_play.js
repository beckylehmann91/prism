$(function() {

  soundManager.setup({
    onready: function() {
      var FIRST_ELEMENT = 0
      var music = []
      var length = gon.sounds[FIRST_ELEMENT]

      // create sound variables
      for (var i = 0; i < length; i++) {
        music[i] = soundManager.createSound({
          url: gon.sounds[FIRST_ELEMENT][i],
        });
      };

      // play songs
      $('div #play').on('click', function() {
        for(var i = 0; i < length; i++){
          music[i].play();
        }
      });

      // stop playback
      $('div #stop').on('click', function() {
        for(var i = 0; i < length; i++){
          music[i].stop();
        }
      });
    }
  });

});
