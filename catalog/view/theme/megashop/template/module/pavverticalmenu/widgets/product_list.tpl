<?php
$objlang = $this->registry->get('language');
$themeConfig = (array)$this->config->get('themecontrol');
$listingConfig = array(
'category_pzoom'                     => 1,
'quickview'                          => 0,
'show_swap_image'                    => 0,
'product_layout'		=> 'default',
'enable_paneltool'	=> 0
);
$listingConfig     = array_merge($listingConfig, $themeConfig );
$categoryPzoom 	    = $listingConfig['category_pzoom'];
$quickview          = $listingConfig['quickview'];
$swapimg            = $listingConfig['show_swap_image'];
$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;

$theme = $this->config->get('config_template');
if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
}
$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
if( !is_file($productLayout) ){
$listingConfig['product_layout'] = 'default';
}
$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

$button_cart = $objlang->get('button_cart');
?>
<?php if( $show_title ) { ?>
<div class="widget-heading"><?php echo $heading_title?></div>
<?php } ?>
<div class="widget-product-list <?php echo $addition_cls; ?>">
    <div class="widget-inner">
        <?php foreach ($products as $product) { ?>
            <?php require( $productLayout );  ?>
        <?php } ?>
    </div>
</div>

