<div id="slideshow<?php echo $module; ?>" class="owl-carousel" style="opacity: 1;">
  <?php foreach ($banners as $key => $banner) { ?>
  <div class="item" thumb="<?php echo $key ?>">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
    <?php } ?>
  </div>
  <?php } ?>
</div>
<div id="slider-thumbs" class="row hidden-sm hidden-xs">
  <?php foreach ($banners as $key => $banner) { ?>
  <div class="slider-thumbs col-md-<?php echo $span ?>" thumb="<?php echo $key ?>">
    <a href="#"><img src="<?php echo $banner['thumb']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
  </div>
  <?php } ?>
</div>
<script type="text/javascript"><!--  
$('#slideshow<?php echo $module; ?>').owlCarousel({
  items: 6,
  autoPlay: 4000,
  singleItem: true,
  navigation: true,
  navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
  pagination: true,
  addClassActive: true,
  afterMove: function() {
    $('#slider-thumbs a').removeClass('active_thumb');

    var active_thumb = $('.owl-wrapper').children('.active').children('div.item').attr('thumb');

    $('#slider-thumbs [thumb=' + active_thumb + '] a').addClass('active_thumb');
  }
});

$('#slider-thumbs').find('a:first').addClass('active_thumb');

var slider = $("#slideshow<?php echo $module; ?>").data('owlCarousel');
$('.slider-thumbs a').on('click', function(e) {
  e.preventDefault();
  slider.goTo($(this).parent().index());  

  return false;
});
--></script>