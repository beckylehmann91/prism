$(function() {

  soundManager.setup({
    onready: function() {
      var FIRST_ELEMENT = 0
      var music = []
      var length = gon.sounds[FIRST_ELEMENT].length
      var isPlaying = false;

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
      $('div #play').on('click', function(e) {
        e.preventDefault();
        if(!isPlaying){                         // check if player is playing. If not proceed and play.
          for(var i = 0; i < length; i++){
            loopSound(music[i]);
          }
          isPlaying = true;
        }
      });

      // stop playback
      $('div #stop').on('click', function(e) {
        e.preventDefault();
        for(var i = 0; i < length; i++) {
          music[i].stop();
        }
        isPlaying = false;
      });

      // pause playback
      $('div #pause').on('click', function(e) {
        e.preventDefault();
        for(var i = 0; i < length; i++){
          music[i].pause();
        }
        isPlaying = false;
      });
    }
  });
});
