$(document).ready(function() {
  $('#about_team-button').click(function() {
    $('html,body').animate({scrollTop:
    $('#about_team').offset().top}); return false;
  });
});
