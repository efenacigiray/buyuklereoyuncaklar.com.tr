<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,9)+substr(md5($heading_title),0,3);

	$themeConfig = (array)$this->config->get('themecontrol');
	$theme  = $this->config->get('config_template');

	// echo "<pre>";
	// print_r($themeConfig); die;

	$listingConfig = array(
		'category_pzoom'                     => 1,
		'quickview'                          => 0,
		'show_swap_image'                    => 0,
		'product_layout'					 => 'default',
	);




	$listingConfig     = array_merge($listingConfig, $themeConfig );
	$categoryPzoom 	    = $listingConfig['category_pzoom'];
	$quickview          = $listingConfig['quickview'];
	$swapimg            = $listingConfig['show_swap_image'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
	
	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	} 


	$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	
	$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
?>
<div class="<?php echo $prefix;?> box productcarousel box-normal" id="module<?php echo $id; ?>">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content" >
 		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<?php if( count($products) > $itemsperpage ) { ?>
		<div class="carousel-controls">
			<a class="carousel-control left center" href="#productcarousel<?php echo $id;?>"   data-slide="prev">
				<i class="fa fa-angle-left"></i>
			</a>
			<a class="carousel-control right center" href="#productcarousel<?php echo $id;?>"  data-slide="next">
				<i class="fa fa-angle-right"></i>
			</a>
		</div>
		<?php } ?>
			<div class="carousel-inner product-grid">		
				<?php $pages = array_chunk( $products, $itemsperpage); ?>	
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?> products-block">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
						<?php if( $i%$cols == 1 || $cols == 1) { ?>
						<div class="row products-row <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
						<?php } ?>
							<div class="col-lg-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 <?php if($i%$cols == 0) { echo "last";} ?> product-col">
								<?php require( $productLayout );  ?>   
							</div>
							  
						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
						</div><?php //end box-product?>
						<?php } ?>
					<?php } //endforeach; ?>
				</div>
			  <?php } ?>
			</div>  
		</div>
	</div>
</div>
<script type="text/javascript"><!--
	$('#productcarousel<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
--></script>
