<?php echo $header;  $config = $this->registry->get('config');  ?>
<?php
require( DIR_TEMPLATE.$config->get('config_template')."/template/common/config.tpl" );
$themeConfig = (array)$config->get('themecontrol');
$productConfig = array(
	'product_enablezoom'        => 1,
	'product_zoommode'          => 'basic',
	'product_zoomeasing'        => 1,
	'product_zoomlensshape'     => "round",
	'product_zoomlenssize'      => "150",
	'product_zoomgallery'       => 0,
	'enable_product_customtab'  => 0,
	'product_customtab_name'    => '',
	'product_customtab_content' => '',
	'product_related_column'    => 0,
);
$listingConfig = array(
	'category_pzoom'  => 1,
	'quickview' 	  => 0,
	'show_swap_image' => 0,
	'catalog_mode'    => 1
);
$listingConfig	= array_merge($listingConfig, $themeConfig );
$categoryPzoom	= $listingConfig['category_pzoom'];
$quickview		= $listingConfig['quickview'];
$swapimg		= ($listingConfig['show_swap_image'])?'swap':'';
$productConfig	= array_merge( $productConfig, $themeConfig );
$languageID		= $config->get('config_language_id');
?>
<div id="columns">
	<div class="container">
	    <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
	  	<div class="row">
		  	<?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>
			<?php endif; ?>
	   		<section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="contents" class="wrappers clearfix">
	   			<?php echo $content_top; ?>
		        <?php require( PAVO_THEME_DIR."/template/product/product_detail_hitech.tpl" );  ?>
		     	<?php if ($products) { ?>
		     	<?php $heading_title = $text_related; ?>
		    	<div class="box products-related"> 
		    		<?php require( PAVO_THEME_DIR."/template/product/product_related.tpl" );  ?>
				</div>
		      	<?php } ?>
	      		<?php if ($tags) { ?>
	      		<p><?php echo $text_tags; ?>
	            <?php for ($i = 0; $i < count($tags); $i++) { ?>
	            	<?php if ($i < (count($tags) - 1)) { ?>
	            	<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
	            	<?php } else { ?>
	            	<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
	            	<?php } ?>
	            <?php } ?>
	          	</p>
	          <?php } ?>
	      	<?php echo $content_bottom; ?></div>
	   	</section>
		<?php if( $SPAN[2] ) { ?>
		<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">
			<?php echo $column_right; ?>
		</aside>
		<?php } ?>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});

$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
          		$('#notification').html('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
          		notificationCountdown();
				
				$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				$('#cart > button').html('<i class="fa fa-shopping-cart"></i> ' + json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');

				$('#cart').load('index.php?route=common/cart/info');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});

$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
    $('#review').fadeOut('slow');
    $('#review').load(this.href);
    $('#review').fadeIn('slow');
});

$('.imagezoom').click(function(e) {
	e.preventDefault();
	
	var img = $(this).children('img');
	if (!$(img).hasClass('active-img')) {
		$('.imagezoom').children('img').removeClass('active-img');
		$(img).addClass('active-img');
		$('#image').attr('src', $(img).attr('data-layer-image'));
		$('#image').parent('a').attr('href', $(img).attr('data-zoom-image'));
	}
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
});

$(document).ready(function() {
    $('#image-additional-carousel .item:first').addClass('active');
    $('#image-additional-carousel .item:first img:first').addClass('active-img');
    $('#image-additional-carousel').carousel({interval:false});
})
</script>
<?php echo $footer; ?>