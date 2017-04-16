<?php
$span = 12/$cols; 
$id = rand(1,9)+substr(md5($heading_title),0,3);
$themeConfig = (array)$objconfig->get('themecontrol');
$listingConfig = array(
	'category_pzoom'                     => 1,
	'quickview'                          => 0,
	'show_swap_image'                    => 0,
	'product_layout'		             => 'default',
	'enable_paneltool'	                 => 0
);
$listingConfig      = array_merge($listingConfig, $themeConfig );
$categoryPzoom 	    = $listingConfig['category_pzoom'];
$quickview          = $listingConfig['quickview'];
$swapimg            = $listingConfig['show_swap_image'];
$categoryPzoom      = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
$theme              = $objconfig->get('config_template');
if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
	$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
} 
$productLayout = DIR_TEMPLATE.$objconfig->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
if( !is_file($productLayout) ){
	$listingConfig['product_layout'] = 'default';
}
$productLayout = DIR_TEMPLATE.$objconfig->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
?>
<div class="box nopadding pav-categorytabs clearfix <?php echo $prefix_class; ?>">
	<?php if( !empty($module_description) ) { ?>
	<div class="module-desc">
		<?php echo $module_description;?>
	</div>
	<?php } ?>
	<div class="box-wapper <?php echo $prefix_class ?>">
		<div class="box-heading">
			<span><?php echo $category_name; ?></span>
		</div><!-- end div.box-heading -->	

		<div class="tab-nav">
			<?php if(count($tabs) > 1) { $hidden = "hidden-lg hidden-md hidden-xs hidden-sm"; } ?>
			<ul class="nav nav-tabs <?php echo isset($hidden)?$hidden:''; ?>" id="pav-categorytabs<?php echo $id;?>">
				<?php foreach ($tabs as $key=>$tab): ?>
					<li><a href="#tab<?php echo $id."-cat".$key;?>" role="tab" data-toggle="tab"><?php echo $tab['name']; ?></a></li>
				<?php endforeach; ?>
			</ul>
			<a class="img-banner" href="<?php echo $category_link; ?>" data-toggle="tab">
				<?php if (!empty($image) ) { ?><img class="img-responsive" src="<?php echo $image;?>" alt="<?php echo $category_name; ?>"/><?php } ?>							
			</a>
		</div><!-- end div.tab-nav -->

		<div class="tab-content">
			<?php foreach ($tabs as $key=>$tab) { ?>
				<?php
					if(empty($tab['products'])) {continue;} 
					$products = $tab['products'];
				?>
				<div class="tab-pane clearfix" id="tab<?php echo $id."-cat".$key;?>">
					<?php if( count($products) > $itemsperpage ) { ?>
					<div class="carousel-controls">
						<a class="carousel-control left" href="#list<?php echo $id."-cat".$key;?>" data-slide="prev"><i class="fa fa-angle-left"></i></a>
						<a class="carousel-control right" href="#list<?php echo $id."-cat".$key;?>" data-slide="next"><i class="fa fa-angle-right"></i></a>
					</div><!-- end div.carousel-controls-->
					<?php } ?>

					<div class="carousel-inner carousel<?php echo $id;?> slide" id="list<?php echo $id."-cat".$key;?>">
						<?php $pages = array_chunk( $products, $itemsperpage);?>	
						<?php foreach ($pages as  $k => $tproducts ) {   ?>
						<div class="item <?php if($k==0) {?>active<?php } ?>">
							<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
								<?php if( $i%$cols == 1 || $cols == 1) { ?>
								<div class="row products-row <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
								<?php } ?>
									<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
										<?php require( $productLayout );  ?>  
									</div>
								<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
								</div><?php //end box-product?>
								<?php } ?>
							<?php } //endforeach; ?>
						</div>
					  <?php } ?>
					</div><!-- end div.carousel-content-->
					
				</div><!-- end div.tab-panel-->
			<?php } ?>
		</div><!-- end div.tab-content -->

	</div><!-- end div.box-wapper -->	
</div><!-- end div.box -->

<div class="box box-normal border products-bestseller <?php echo $prefix_p; ?>">
	<div class="box-heading"><span><?php echo $title; ?></span></div>
	<div class="box-content">	
		<div class="products-block">
			<?php if( count($products_p) > $itemsperpage_p ) { ?>
			<div class="carousel-controls">
				<a class="carousel-control left" href="#cols<?php echo $id."-cat".$key;?>" data-slide="prev"><i class="fa fa-angle-left"></i></a>
				<a class="carousel-control right" href="#cols<?php echo $id."-cat".$key;?>" data-slide="next"><i class="fa fa-angle-right"></i></a>
			</div><!-- end div.carousel-controls-->
			<?php } ?>

			<div class="carousel-inner carousel<?php echo $id;?> slide" id="cols<?php echo $id."-cat".$key;?>">
				<?php $pages = array_chunk( $products_p, $itemsperpage_p); ?>	
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
						<?php if( $i%$cols_p == 1 || $cols_p == 1) { ?>
						<div class="row products-row <?php ;if($i == count($tproducts) - $cols_p +1) { echo "last";} ?>">
						<?php } ?>
							<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
								<?php require( $productLayout );  ?>  
							</div>
						<?php if( $i%$cols_p == 0 || $i==count($tproducts) ) { ?>
						</div>
						<?php } ?>
					<?php }?>
				</div>
			  <?php } ?>
			</div><!-- end div.carousel-content-->


		</div>	
	</div>
</div><!-- end div.box-columns -->  

<script>
$(function() {
	$('.carousel<?php echo $id;?>').carousel({interval:99999999999999,auto:false,pause:'hover'});
	$('#pav-categorytabs<?php echo $id;?> a:first').tab('show');
});
</script>
