// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){

  console.log("jQuery is working")

  $(".checkWrapper").on("click", ".markComplete",  function(){
    $(this).siblings().toggleClass("itemComplete");
    var id = this.id;
    // console.log("this = ", this)
    // console.log("id = ", id)
    var status;

    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: "/items/" + id
    }).done(function( response ) {
      // console.log("response", response)
      status = response.completed
      updateStatus(status, id)
    }).fail(function(){
      // console.log("failure")
    })

  });


  function updateStatus(status, id){
    newStatus = status ? false : true
    // console.log("oldStatus = ", status)
    // console.log("newStatus = ", newStatus)

    $.ajax({
      type: 'PUT',
      dataType: 'json',
      data: {item:{"completed":newStatus}},
      url: "/items/" + id
    }).done(function() {
      // console.log("success")
    }).fail(function(){
      // console.log("failure")
    })
  }

  // type: 'POST', // Use POST with X-HTTP-Method-Override or a straight PUT if appropriate.
  // dataType: 'json', // Set datatype - affects Accept header
  // url: "http://example.com/people/1", // A valid URL
  // headers: {"X-HTTP-Method-Override": "PUT"}, // X-HTTP-Method-Override set to PUT.
  // data: '{"name": "Dave"}'


  var list = $(".list")

  for(var i=0; i <list.length; i++){
    $(list[i]).on("mouseover", function (event){
      $(this).css("background","#ff5779")
      // $(this).css("text-shadow","1px 1px 2px white")
    })

    $(list[i]).on("mouseout", function (event){
      $(this).css("background","white")
      // $(this).css("text-shadow","0px 0px 0px")
    })
  }

  function checkJqueryUI() {
    if (typeof jQuery.ui != 'undefined') {
      do_jqueryui();
    }
    else {
      console.log("jQuery.ui has not loaded")
      window.setTimeout( checkJqueryUI, 50 );
    }
  }

  // Put all your jQuery UI stuff in this function
  function do_jqueryui() {

    console.log("jQuery.ui has loaded")

    $(function(){
      $(".list").draggable({
        // Capture the "stop drag" event
        stop:function (event, ui) {

          // Generate the img object with the new coordinates.
          var position = {
            "id":$(this).attr('id'),
            "position_y":$(this).position().top.toString(),
            "position_x":$(this).position().left.toString()
          };

          // Send the request to the server
          $.ajax({
            type:"PUT",
            dataType:'json',
            data:JSON.stringify(position),
            contentType:'application/json',
            // data: {list:{position_y:$(this).position().top.toString(), position_x:$(this).position().left.toString()}},
            url: "/lists/" + $(this).attr('id')
          }).done(function (data){
            // console.log("succes:", data )
            // console.log("position:", position)
          }).fail(function(data){
            console.log("ajax failure:", data)
          })
        } //end stop:function
      })//close draggable event
    })
  }

  checkJqueryUI();

})
