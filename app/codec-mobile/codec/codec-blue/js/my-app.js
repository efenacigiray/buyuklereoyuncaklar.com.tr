// Initialize your app
var myApp = new Framework7({
    animateNavBackIcon: true,
    precompileTemplates: true,
	swipeBackPage: false,
	swipeBackPageThreshold: 1,
	pushState: false,
    template7Pages: true
});


// Export selectors engine
var $$ = Dom7;

// Add main View
var mainView = myApp.addView('.view-main', {
    // Enable dynamic Navbar
    dynamicNavbar: false
});


jQuery(document).ready(function() {
"use strict"; 

	$(".logo").animate({'top': '20px'},'slow',"easeInOutCirc");
	$(".cartitems").delay(1000).animate({'width': '30px', 'height': '30px', 'top':'10px', 'right':'10px', 'opacity':1},1000,"easeOutBounce");
	$(".main-nav ul > li")
		.css('opacity', '0')
		.each(function(index, item) {
			setTimeout(function() {
				$(item).fadeTo('slow',1,"easeInOutCirc");
			}, index*175);
	});
		
	$(".main-nav ul > li span")
	    .css('opacity', '0')
		.each(function(index, item) {
			setTimeout(function() {
				$(item).animate({'left': '0px', 'opacity':1},500,"easeInOutCirc");
			}, index*175);
	});
		
    $('.item_delete').click(function(e){
        e.preventDefault();
        var currentVal = $(this).attr('id');
        $('div#'+currentVal).fadeOut('slow');
    });
	
    $('.qntyplus').click(function(e){
								  
        e.preventDefault();
        var fieldName = $(this).attr('field');
        var currentVal = parseInt($('input[name='+fieldName+']').val());
        if (!isNaN(currentVal)) {
            $('input[name='+fieldName+']').val(currentVal + 1);
        } else {
            $('input[name='+fieldName+']').val(0);
        }
		
    });
    $(".qntyminus").click(function(e) {
        e.preventDefault();
        var fieldName = $(this).attr('field');
        var currentVal = parseInt($('input[name='+fieldName+']').val());
        if (!isNaN(currentVal) && currentVal > 0) {
            $('input[name='+fieldName+']').val(currentVal - 1);
        } else {
            $('input[name='+fieldName+']').val(0);
        }
    });
							
});

$$(document).on('ajaxStart',function(e){myApp.showIndicator();});
$$(document).on('ajaxComplete',function(){myApp.hideIndicator();});	

$$('.popup').on('opened', function () {
  $(".close_loginpopup_button a").animate({'right':'10px', 'opacity':1},'slow',"easeInOutCirc");
});
$$('.popup').on('closed', function () {
  $(".close_loginpopup_button a").animate({'right':'0px', 'opacity':0},'slow',"easeInOutCirc");
});

myApp.onPageInit('index', function (page) {

	$(".logo").animate({'top': '20px'},'slow',"easeInOutCirc");
	$(".cartitems").delay(1000).animate({'width': '30px', 'height': '30px', 'top':'10px', 'right':'10px', 'opacity':1},1000,"easeOutBounce");
	$(".main-nav ul > li")
		.css('opacity', '0')
		.each(function(index, item) {
			setTimeout(function() {
				$(item).fadeTo('slow',1,"easeInOutCirc");
			}, index*175);
	});	
	$(".main-nav ul > li span")
	    .css('opacity', '0')
		.each(function(index, item) {
			setTimeout(function() {
				$(item).animate({'left': '0px', 'opacity':1},500,"easeInOutCirc");
			}, index*175);
	});	
  
})

myApp.onPageInit('blog', function (page) {
								   
		$(".posts li").hide();	
		size_li = $(".posts li").size();
		x=4;
		$('.posts li:lt('+x+')').show();
		$('#loadMore').click(function () {
			x= (x+1 <= size_li) ? x+1 : size_li;
			$('.posts li:lt('+x+')').show();
			if(x == size_li){
				$('#loadMore').hide();
				$('#showLess').show();
			}
		});						   
									   
		$("ul.posts > li div.post_date")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'left':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});	
		$("ul.posts > li div.post_title")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'right':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});		
})

myApp.onPageInit('blogsingle', function (page) {
										 
			$(".backto").animate({'left': '0px'},'slow',"easeInOutCirc");
			$(".nextto").delay(500).animate({'opacity':1, 'width': '10%',},500,"easeOutBounce");
			$(".post_title_single").animate({'right': '0px'},'slow',"easeInOutCirc");
								   
	
})

myApp.onPageInit('shop', function (page) {

		$("ul.shop_items > li")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).fadeTo('slow',1,"easeInOutCirc");
				}, index*175);
		});	
			
		$("ul.shop_items > li .shopfav")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'width':'8%', 'opacity':1},2000,"easeOutBounce");
				}, index*175);
		});	
			
		$("ul.shop_items > li h4")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'right':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});	
			
		$("ul.shop_items > li div.shop_thumb")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'left':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});	
			
		$('.qntyplusshop').click(function(e){
									  
			e.preventDefault();
			var fieldName = $(this).attr('field');
			var currentVal = parseInt($('input[name='+fieldName+']').val());
			if (!isNaN(currentVal)) {
				$('input[name='+fieldName+']').val(currentVal + 1);
			} else {
				$('input[name='+fieldName+']').val(0);
			}
			
		});
		$(".qntyminusshop").click(function(e) {
			e.preventDefault();
			var fieldName = $(this).attr('field');
			var currentVal = parseInt($('input[name='+fieldName+']').val());
			if (!isNaN(currentVal) && currentVal > 0) {
				$('input[name='+fieldName+']').val(currentVal - 1);
			} else {
				$('input[name='+fieldName+']').val(0);
			}
		});	
  
})

myApp.onPageInit('shopitem', function (page) {
									   
	$(".shop_item .shop_thumb").animate({'left': '0px', 'opacity':1},'slow',"easeInOutCirc");
	$(".shop_item .shop_item_price").delay(500).animate({'right':'10px', 'opacity':1},500,"easeInOutCirc");
	$(".shop_item a.shopfav").delay(500).animate({'opacity':1, 'width': '10%',},500,"easeOutBounce");
	$(".shop_item a.shopfriend").delay(800).animate({'opacity':1, 'width': '10%',},500,"easeOutBounce");

			
		$('.qntyplusshop').click(function(e){
									  
			e.preventDefault();
			var fieldName = $(this).attr('field');
			var currentVal = parseInt($('input[name='+fieldName+']').val());
			if (!isNaN(currentVal)) {
				$('input[name='+fieldName+']').val(currentVal + 1);
			} else {
				$('input[name='+fieldName+']').val(0);
			}
			
		});
		$(".qntyminusshop").click(function(e) {
			e.preventDefault();
			var fieldName = $(this).attr('field');
			var currentVal = parseInt($('input[name='+fieldName+']').val());
			if (!isNaN(currentVal) && currentVal > 0) {
				$('input[name='+fieldName+']').val(currentVal - 1);
			} else {
				$('input[name='+fieldName+']').val(0);
			}
		});	
  
})


$$(document).on('pageInit', function (e) {
									  
		$("ul.features_list_detailed > li")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).fadeTo('slow',1,"easeInOutCirc");
				}, index*175);
		});	
			
		$("ul.features_list_detailed > li span")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'bottom':'0px', 'right':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});	
			
		$("ul.features_list_detailed > li h4")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'right':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});	
			
		$("ul.features_list_detailed > li div.feat_small_icon")
			.css('opacity', '0')
			.each(function(index, item) {
				setTimeout(function() {
					$(item).animate({'left':'0px', 'opacity':1},800,"easeInOutCirc");
				}, index*175);
		});		
		
  		$(".swipebox").swipebox();
		$("#ContactForm").validate({
		submitHandler: function(form) {
		ajaxContact(form);
		return false;
		}
		});
		
		$("#RegisterForm").validate();
		$("#LoginForm").validate();
		$("#ForgotForm").validate();
		
		$('a.backbutton').click(function(){
			parent.history.back();
			return false;
		});
		
        

	$("a.switcher").bind("click", function(e){
		e.preventDefault();
		
		var theid = $(this).attr("id");
		var theproducts = $("ul#photoslist");
		var classNames = $(this).attr('class').split(' ');
		
		
		if($(this).hasClass("active")) {
			// if currently clicked button has the active class
			// then we do nothing!
			return false;
		} else {
			// otherwise we are clicking on the inactive button
			// and in the process of switching views!

  			if(theid == "view13") {
				$(this).addClass("active");
				$("#view11").removeClass("active");
				$("#view11").children("img").attr("src","images/switch_11.png");
				
				$("#view12").removeClass("active");
				$("#view12").children("img").attr("src","images/switch_12.png");
			
				var theimg = $(this).children("img");
				theimg.attr("src","images/switch_13_active.png");
			
				// remove the list class and change to grid
				theproducts.removeClass("photo_gallery_11");
				theproducts.removeClass("photo_gallery_12");
				theproducts.addClass("photo_gallery_13");

			}
			
			else if(theid == "view12") {
				$(this).addClass("active");
				$("#view11").removeClass("active");
				$("#view11").children("img").attr("src","images/switch_11.png");
				
				$("#view13").removeClass("active");
				$("#view13").children("img").attr("src","images/switch_13.png");
			
				var theimg = $(this).children("img");
				theimg.attr("src","images/switch_12_active.png");
			
				// remove the list class and change to grid
				theproducts.removeClass("photo_gallery_11");
				theproducts.removeClass("photo_gallery_13");
				theproducts.addClass("photo_gallery_12");

			} 
			else if(theid == "view11") {
				$("#view12").removeClass("active");
				$("#view12").children("img").attr("src","images/switch_12.png");
				
				$("#view13").removeClass("active");
				$("#view13").children("img").attr("src","images/switch_13.png");
			
				var theimg = $(this).children("img");
				theimg.attr("src","images/switch_11_active.png");
			
				// remove the list class and change to grid
				theproducts.removeClass("photo_gallery_12");
				theproducts.removeClass("photo_gallery_13");
				theproducts.addClass("photo_gallery_11");

			} 
			
		}

	});	
	
	document.addEventListener('touchmove', function(event) {
	   if(event.target.parentNode.className.indexOf('navbarpages') != -1 || event.target.className.indexOf('navbarpages') != -1 ) {
		event.preventDefault(); }
	}, false);
	
	// Add ScrollFix
	var scrollingContent = document.getElementById("pages_maincontent");
	new ScrollFix(scrollingContent);
	
	
	var ScrollFix = function(elem) {
		// Variables to track inputs
		var startY = startTopScroll = deltaY = undefined,
	
		elem = elem || elem.querySelector(elem);
	
		// If there is no element, then do nothing	
		if(!elem)
			return;
	
		// Handle the start of interactions
		elem.addEventListener('touchstart', function(event){
			startY = event.touches[0].pageY;
			startTopScroll = elem.scrollTop;
	
			if(startTopScroll <= 0)
				elem.scrollTop = 1;
	
			if(startTopScroll + elem.offsetHeight >= elem.scrollHeight)
				elem.scrollTop = elem.scrollHeight - elem.offsetHeight - 1;
		}, false);
	};
	
		
		
})
