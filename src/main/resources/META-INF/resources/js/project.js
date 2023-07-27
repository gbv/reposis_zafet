var imageListe = [
  "210318_BIB_HdBA_005.jpg",
  "210318_BIB_HdBA_007.jpg",
  "210318_BIB_HdBA_010.jpg",
  "210318_BIB_HdBA_011.jpg",
  "210318_BIB_HdBA_012.jpg",
  "210318_BIB_HdBA_013.jpg",
  "210318_BIB_HdBA_015.jpg",
  "210318_BIB_HdBA_016.jpg",
  "210318_BIB_HdBA_017.jpg",
  "210318_BIB_HdBA_019.jpg",
  "210318_BIB_HdBA_021.jpg"
];

$(document).ready(function() {

  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

  // activate empty search on start page
  $("#project-searchMainPage").submit(function (evt) {
    $(this).find(":input").filter(function () {
          return !this.value;
      }).attr("disabled", true);
    return true;
  });

  // replace placeholder USERNAME with username
  var userID = $("#currentUser strong").html();
  var newHref = 'https://reposis-test.gbv.de/zafet/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://reposis-test.gbv.de/zafet/servlets/solr/select?q=createdby:USERNAME']").attr('href', newHref);

  //window.setInterval(changeBackground, 10000);
});

function changeBackground()
{
  console.log("change image now");
  var randomImage = Math.floor(Math.random() * imageListe.length-1);
  $("body> section").css("background-image","url('../images/figures/" + imageListe[randomImage] + "')");
}


$( document ).ajaxComplete(function() {
  // remove series and journal as option from publish/index.xml
  $("select#genre option[value='series']").remove();
  $("select#genre option[value='journal']").remove();
});
