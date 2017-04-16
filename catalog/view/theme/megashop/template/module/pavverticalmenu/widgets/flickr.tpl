<?php if( isset($flickr_id) ) { ?>
<div class="widget-blogs box <?php $addition_cls?> <?php if ( isset($stylecls)&&$stylecls) { ?>box-<?php echo $stylecls; ?><?php } ?>">
	<?php if ( isset($widget_heading)&&!empty($widget_heading) ) { ?>
	<div class="widget_heading box-heading">
		<?php echo $widget_heading?>
	</div>
	<?php  }  ?>
	<div class="widget-inner block_content">

		<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?count=<?php echo $flickr_photos;?>&amp;display=<?php echo $flickr_display;?>&amp;size=s&amp;layout=x&amp;source=<?php echo $flickr_type;?>&amp;<?php echo $flickr_type;?>=<?php echo $flickr_id;?>"></script>
		</br>

		<p class="flickr_stream_wrap">
			<a class="btn btn-success btn-sm" href="http://www.flickr.com/photos/<?php echo $flickr_id;?>">View details</a>
		</p>

	</div>
</div>
<?php  }  ?>