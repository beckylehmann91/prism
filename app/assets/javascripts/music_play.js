$(function() {

  soundManager.setup({
    onready: function() {
      var music = []

      // create sound variables
      for (var i = 0; i < gon.sounds.length; i++) {
        music[i] = soundManager.createSound({
          url: gon.sounds[i],
          loops: 3,
        });
      };

      // play songs
      console.log(music)
      $('div #play').on('click', function() {
        for(var i = 0; i < gon.sounds.length; i++){
          music[i].play();
        }

      });

      // stop playback
      $('div #stop').on('click', function() {
        for(var i = 0; i < gon.sounds.length; i++){
          music[i].stop();
        }
      });
    }
  });

});
