window.addEventListener('message', function( event ) {
  if (event.data.UMHackerPhoneNui == 'open') {
  $('body').css('display','block');
  }
if (event.data.UMHackerPhoneTargetNui == 'open') {
  $('.notify').css('display','block');
  $('.uyuyorumterminal').css('display','none');
  $('.notify').html('~$ root@qbcore hacking started');
  setTimeout(function(){
    $('.hackbg').css('display','block');
    $('#lastname').html(event.data.targetinformation.targetlastname);
    $('#name').html(event.data.targetinformation.targetname);
    $('#dob').html(event.data.targetinformation.targetdob);
    $('#bankmoney').html(event.data.targetinformation.targetbank);
    $('#phonenumber').html(event.data.targetinformation.targetphone);
    return;
  }, 5000);
}
if (event.data.UMHackerPhoneNotifyNui == 'open') {
  $('.notify').css('display','block');
  $('.notify').html('~$ root@qbcore error 503');
  $('.uyuyorumterminal').css('display','block');
  $('.hackbg').css('display','none');
}
});

$( "#blackout" ).click(function() {
  notify();
  $('.notify').html('~$ root@qbcore blackout!');
  $.post(`https://um-hackerphone/um-hackerphone:nuicallback:blackout`)
});

$( "#target" ).click(function() {
  $.post(`https://um-hackerphone/um-hackerphone:nuicallback:targetinformation`)
});

$( "#vehicle" ).click(function() {
  notify();
  $('.notify').html('~$ root@qbcore explosion!!!!!!!');
  $.post(`https://um-hackerphone/um-hackerphone:nuicallback:vehiclehealth`)
});

$( ".button-menu1" ).click(function() {
  $( ".phone-screen" ).toggleClass( "active" );
  $('.image').toggle();
});

function notify(){
  $('.notify').css('display','block');
  $('.uyuyorumterminal').css('display','none');
  $('.hackbg').css('display','none');
}

document.onkeyup = function (event) {
  event = event || window.event;
  var charCode = event.keyCode || event.which;
  if (charCode == 8) { // Nui hide key backspace
    $.post(`https://um-hackerphone/um-hackerphone:nuicallback:escape`)
    $('body').css('display','none');
    location.reload();
  }};