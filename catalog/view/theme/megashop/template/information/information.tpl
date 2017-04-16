<?php echo $header; ?>
<div class="container">
	<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
	<?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>
	<div class="row"><?php if( $SPAN[0] ): ?>
		<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
			<?php echo $column_left; ?>
		</aside>	
	<?php endif; ?> 

	<section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
		<div id="content" class="wrapper clearfix"><?php echo $content_top; ?>
			<div id="information">
				<h3><?php echo $heading_title; ?></h3>
				<?php echo $description; ?>
			</div>
			<?php echo $content_bottom; ?>
		</div>
	</section> 
	<?php if( $SPAN[2] ): ?>
		<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
			<?php echo $column_right; ?>
		</aside>
	<?php endif; ?></div>
</div>
<?php echo $footer; ?> 