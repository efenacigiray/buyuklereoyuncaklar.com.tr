<?php if ( isset($video_link) ) { ?>
<div class="widget box widget-video">
	<?php if ( isset($widget_heading)&&!empty($widget_heading) ) {?>
	<div class="widget-heading box-heading">
		<?php echo $widget_heading ?>
	</div>
	<?php } ?>
	<div class="widget-inner box-content">
		<iframe src="<?php echo $video_link ?>" style="width:<?php echo $width ?>;height:<?php echo $height ?>;" allowfullscreen="true"></iframe>
		<?php if ( $subinfo ) { ?>
		<div><?php $subinfo ?></div>
		<?php } ?>
	</div>
</div>
<?php } ?>