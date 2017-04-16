<?php echo $header; ?>
<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
<div class="container">
  <div class="row"><?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
  
   <section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content" class="wrapper clearfix"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($categories) { ?>
      <p><strong><?php echo $text_index; ?></strong>
        <?php foreach ($categories as $category) { ?>
        &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
        <?php } ?>
      </p>
      <?php foreach ($categories as $category) { ?>
      <h3 class="manufacturer-letter" id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h3>
      <?php if ($category['manufacturer']) { ?>
      <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
      <div class="row manufacturer-info-row">
        <?php foreach ($manufacturers as $manufacturer) { ?>
        <div class="col-sm-3 manufacturer-image">
          <a href="<?php echo $manufacturer['href']; ?>">
            <img class="img-responsive" src="<?php echo $manufacturer['image'] ?>">
            <span><?php echo $manufacturer['name']; ?></span>
          </a>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-outline"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
   </section> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
<?php echo $footer; ?>