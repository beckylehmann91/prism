$(function() {

  soundManager.setup({
    onready: function() {
      var FIRST_ELEMENT = 0
      var music = []
      var length = gon.sounds[FIRST_ELEMENT].length

      console.log(gon.sounds[0])

      // create sound objects accessing first set of array and each element inside
      // load file paths into muisc array
      for (var i = 0; i < length; i++) {
        music[i] = soundManager.createSound({
          url: gon.sounds[FIRST_ELEMENT][i],
        });
      }

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

      // pause playback
      $('div #pause').on('click', function() {
        for(var i = 0; i < length; i++){
          music[i].pause();
        }
      });
    }
  });
});
