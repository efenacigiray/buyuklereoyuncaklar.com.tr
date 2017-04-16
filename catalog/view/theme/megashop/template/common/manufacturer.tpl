<div id="carousel-man" class="owl-carousel manufacturers">
  <?php foreach ($manufacturers as $manufacturer) { ?>
  <div class="item text-center">
    <li><a href="<?php echo $manufacturer['href']; ?>"><img src="<?php echo $manufacturer['thumb']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" class="img-responsive" /></a></li>
  </div>
  <?php } ?>
</div>
<script type="text/javascript"><!--
$('#carousel-man').owlCarousel({
  items: 6,
  autoPlay: 5000,
  navigation: true,
  navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
  pagination: true
});
--></script>