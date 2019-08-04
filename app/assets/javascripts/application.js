// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require_tree .
// require turbolinks

$(document).ready(function(){

  $('.div__heroe--series').slick({
    slidesToShow: 4,
    slidesToScroll: 4,
    autoplay: true,
    autoplaySpeed: 4000
  });

  var check_parameter = ''

  check_parameter = window.location.search.substring(1).split('=');

  if (check_parameter[0] != "") {
    if (parseInt(check_parameter[1]) == 1) {


    }else {
      $('.pagination').prepend('<li> <a class="li__pagination" href="/heroes?page=' + (parseInt(check_parameter[1] - 1)) +'"><<</a></li>');
      $('.pagination').prepend('<li><a class="li__pagination" href="/heroes?page=1">first</a></li>');

      if (parseInt(check_parameter[1]) == 63) {
        number_index_total = 62 * 24 + 4;
        number_index = (number_index_total - 3) ;
        $('.pagination li:nth-child(3)').html('' + number_index + ' - ' + number_index_total + ' / 1492');
      }else {
        number_index_total = parseInt(check_parameter[1]) * 24;
        number_index = (number_index_total - 24) + 1;
        $('.pagination li:nth-child(3)').html('' + number_index + ' - ' + number_index_total + ' / 1492');
      }

    }
  }


  $('.btn-load-more').click(function (e) {
    e.preventDefault();

    $('.btn-load-more').hide();

    // show loading gif
    $('.div__load--more').append('<img src="/assets/load-more.gif" alt="Load more" width="50px" height="50px" class="loading-gif">');

    $.ajax({
      // make a get request to the server
      type: "GET",
      // get the url from the href attribute of our link
      url: $(this).attr('href'),
      // send the last id to our rails app
      data: {
        id: $(this).data("id"),
        limit: 8,
        offset: $('.div__comic--item').length
      },
      // the response will be a script
      dataType: "json",

      // upon success
      success: function (data) {
        // hide the loading gif
        $('.loading-gif').remove();

        //   show our load more link

        // put news comics
        $.each(data.data.results, function (key, object) {
          item = ''

          item += '<div class="div__comic--item">'
          item += '<figure class="figure__heroes">'
          item += '<img class="img__figure img__comic" src="'+ object.thumbnail.path + '.' + object.thumbnail.extension + '" alt="4bc46b87d49c7">'
          item += '<figcaption class="figcaption__heroe--featured heroe__comic">'+ object.title +'</figcaption>'
          item += '</figure>'
          item += '</div>'
          $('.div__heroe--comic').append(item);
        });

        // show btn load-more
        if (data.data.total == $('.div__comic--item').length ) {
          $('.btn-load-more').remove();
        }else {
          $('.btn-load-more').show();
        }
      }
    });

  });

});
