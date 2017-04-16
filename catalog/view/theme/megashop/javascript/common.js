$(document).ready(function() {
    /*  Fix First Click Menu */
    $(document.body).on('click', '#pav-mainnav [data-toggle="dropdown"]', function() {
        if (!$(this).parent().hasClass('open') && this.href && this.href != '#') {
            window.location.href = this.href;
        }
    });
    $(document.body).on('click', '.pav-verticalmenu [data-toggle="dropdown"], .verticalmenu [data-toggle="dropdown"]', function() {
        if (!$(this).parent().hasClass('open') && this.href && this.href != '#') {
            window.location.href = this.href;
        }
    });
    jQuery(window).scroll(function() {
        if (jQuery(this).scrollTop() > 100) {
            jQuery('.scrollup').fadeIn();
        } else {
            jQuery('.scrollup').fadeOut();
        }
    });
    jQuery('.scrollup').click(function() {
        jQuery("html, body").animate({
            scrollTop: 0
        }, 600);
        return false;
    });

    $('#offcanvas-btn').click(function() {
        $('#category-dropdown-list-backup').detach().appendTo('#header');
        
        if ($('#category-dropdown-list-backup').hasClass('hidden')) {
            $('#category-dropdown-list-backup').css('display', 'none');
            $('#category-dropdown-list-backup').removeClass('hidden');
            $('#category-dropdown-list-backup').slideDown(300);
        }
        else {
            $('#category-dropdown-list-backup').slideUp(300);
            setTimeout(function() {
              $('#category-dropdown-list-backup').addClass('hidden');
            }, 300)
        }
    });

    cols1 = $('#column-right, #column-left').length;

    if (cols1 == 2) {
        $('#content .product-layout:nth-child(2n+2)').after('<div class="clearfix visible-md visible-sm"></div>');
    } else if (cols1 == 1) {
        $('#content .product-layout:nth-child(3n+3)').after('<div class="clearfix visible-lg"></div>');
    } else {
        $('#content .product-layout:nth-child(4n+4)').after('<div class="clearfix"></div>');
    }

    $('.product-zoom').magnificPopup({
        type: 'image',
        closeOnContentClick: true,
        image: {
            verticalFit: true
        }
    });

    $('.iframe-link').magnificPopup({
        type: 'iframe'
    });

    $('.dropdown-menu input').click(function(e) {
        e.stopPropagation();
    });

    $("button.btn-switch").bind("click", function(e) {
        e.preventDefault();
        var theid = $(this).attr("id");
        var row = $("#products");

        if ($(this).hasClass("active")) {
            return false;
        } else {
            if (theid == "list-view") {
                $('#list-view').addClass("active");
                $('#grid-view').removeClass("active");
                row.removeClass('product-grid');
                row.addClass('product-list');

            } else if (theid == "grid-view") {
                $('#grid-view').addClass("active");
                $('#list-view').removeClass("active");
                row.removeClass('product-list');
                row.addClass('product-grid');

            }
        }
    });

    $(".quantity-adder .add-action").click(function() {
        if ($(this).hasClass('add-up')) {
            $("[name=quantity]", '.quantity-adder').val(parseInt($("[name=quantity]", '.quantity-adder').val()) + 1);
        } else {
            if (parseInt($("[name=quantity]", '.quantity-adder').val()) > 1) {
                $("input", '.quantity-adder').val(parseInt($("[name=quantity]", '.quantity-adder').val()) - 1);
            }
        }
    });

    $('.popup-with-form').magnificPopup({
        type: 'inline',
        preloader: false,
        focus: '#input-name',
        callbacks: {
            beforeOpen: function() {
                if ($(window).width() < 700) {
                    this.st.focus = false;
                } else {
                    this.st.focus = '#input-name';
                }
            }
        }
    });

    $('.box-user').hover(function() {
        $(this).find('.dropdown-menu').stop(true, true).slideDown('fast');
    }, function() {
        $(this).find('.dropdown-menu').stop(true, true).slideUp('fast');
    });
});

function notificationCountdown() {
    setTimeout(function() {
        $('#notification').fadeOut(800)
    }, 6000);
}

// Cart add remove functions
var cart = {
    'addcart': function(product_id, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            success: function(json) {
                $('.alert, .text-danger').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#notification').html('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    if ($("#cart-total").hasClass("cart-mini-info")) {
                        json['total'] = json['total'].replace(/-(.*)+$/, "");
                    }

                    notificationCountdown();

                    $('#cart-total').html(json['total']);

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow');

                    $('#cart').load('index.php?route=common/cart/info');
                }
            }
        });
    },
    'update': function(key, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/edit',
            type: 'post',
            data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            success: function(json) {
                $('#cart > button').button('reset');

                $('#cart-total').html(json['total']);
                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart').load('index.php?route=common/cart/info');
                }
            }
        });
    },
    'remove': function(key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            success: function(json) {
                $('#cart > button').button('reset');

                $('#cart-total').html(json['total']);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart').load('index.php?route=common/cart/info');
                }
            }
        });
    }
}

var wishlist = {
    'addwishlist': function(product_id) {
        $.ajax({
            url: 'index.php?route=account/wishlist/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                $('.alert').remove();

                if (json['success']) {
                    $('#notification').html('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['info']) {
                    $('#notification').html('<div class="alert alert-info"><i class="fa fa-info-circle"></i> ' + json['info'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                notificationCountdown();


                $('#wishlist-total').html(json['total']);

                $('html, body').animate({
                    scrollTop: 0
                }, 'slow');
            }
        });
    },
    'remove': function() {

    }
}

var compare = {
    'addcompare': function(product_id) {
        $.ajax({
            url: 'index.php?route=product/compare/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                $('.alert').remove();

                if (json['success']) {
                    $('#notification').html('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    notificationCountdown();

                    $('#compare-total').html(json['total']);

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow');
                }
            }
        });
    },
    'remove': function() {

    }
}