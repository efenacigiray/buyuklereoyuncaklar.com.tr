<?php if ( $width)  { ?>
	<div class="widget-blogs box <?php $addition_cls?> <?php if ( isset($stylecls)&&$stylecls) { ?>box-<?php echo $stylecls; ?><?php } ?>">
		<?php 
		  if ( isset($widget_heading)&&!empty($widget_heading) ) { ?>
			<div class="widget-heading title_block">
				<?php echo $widget_heading ; ?>
			</div>
		 <?php } ?>
		<div class="widget-inner block_content">
			<div class="g-plusone" data-size="<?php echo $size?>" data-annotation="<?php echo $annotation; ?>" data-width="<?php echo $width;?>"></div>
		</div>
	</div>
<?php } ?>
 
<script type="text/javascript">
  window.___gcfg = {lang: 'en-US'};

  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/platform.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
 