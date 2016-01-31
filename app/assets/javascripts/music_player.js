$(function() {

  soundManager.setup({
    onready: function() {
      var FIRST_ELEMENT = 0
      var music = []
      var length = gon.sounds[FIRST_ELEMENT].length

      // create sound objects accessing first set of array and each element inside
      // load file paths into muisc array
      for (var i = 0; i < length; i++) {
        music[i] = soundManager.createSound({
          url: gon.sounds[FIRST_ELEMENT][i],
        });
      }

      // loops playback infinitely
      function loopSound(music) {
        music.play({
          onfinish: function() {
            loopSound(music);       // callback function to repeat play
          }
        });
      }

      // play songs
      $('div #play').on('click', function() {
        for(var i = 0; i < length; i++){
          loopSound(music[i]);
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

