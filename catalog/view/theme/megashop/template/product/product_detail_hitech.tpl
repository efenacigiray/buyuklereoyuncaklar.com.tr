<?php
$mode = 'default';
$cols = array('default' => array(5,7), 'horizontal' => array(4,6));
$cols = $cols[$mode];
?>
<div class="product-info" itemscope itemtype="http://schema.org/Product">
    <div class="row">
        <?php require( ThemeControlHelper::getLayoutPath( 'common/detail/'.$mode.'.tpl' ) );  ?>
        <div class="col-xs-12 col-sm-<?php echo $cols[1]; ?> col-md-<?php echo $cols[1]; ?> col-lg-<?php echo $cols[1]; ?> product-view">
            <h1 itemprop="name" class="name" ><?php echo $heading_title; ?></h1>
            <?php if ($review_status) { ?>
            <div class="rating">
                <p>
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($rating < $i) { ?>
                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                    <?php } else { ?>
                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
                    <?php } ?>
                    <?php } ?>
                    <a href="#review-form" class="popup-with-form" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $reviews; ?></a> / <a href="#review-form"  class="popup-with-form" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a>
                </p>
                <hr>
            </div>
            <?php } ?>
            <div class="product-extra">
                <ul class="list-unstyled description no-padding float-left">
                    <?php if ($manufacturer) { ?>
                    <li><i class="fa fa-chevron-down"></i><b><?php echo $text_manufacturer; ?></b> <a itemprop="brand" itemscope itemtype="http://schema.org/Brand" href="<?php echo $manufacturers; ?>"><span itemprop="name"><?php echo $manufacturer; ?></span></a></li>
                    <?php } ?>
                    <li><i class="fa fa-chevron-down"></i><b><?php echo $text_model; ?></b> <?php echo $model; ?></li>
                    <?php if ($reward) { ?>
                    <li><i class="fa fa-chevron-down"></i><b><?php echo $text_reward; ?></b> <?php echo $reward; ?></li>
                    <?php } ?>
                    <?php if ($points) { ?>
                    <li><i class="fa fa-chevron-down"></i><b><?php echo $text_points; ?></b> <?php echo $points; ?></li>
                    <?php } ?>
                    <li><i class="fa fa-chevron-down"></i><b><?php echo $text_stock; ?></b> <?php echo $stock; ?></li>
                </ul>
    			<a itemprop="brand" href="<?php echo $manufacturers; ?>" target="_blank"><img itemprop="logo" class="float-right" src="<?php echo $manufacturer_image ?>" alt='<?php echo $manufacturer; ?>' title='<?php echo $manufacturer; ?>'></a>
            </div>
            <?php if ($price) { ?>
            <div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
                <meta content="TRY" itemprop="priceCurrency">
                <meta content="<?php echo $price_raw; ?>" itemprop="price">
                <ul class="list-unstyled">
                    <?php if (!$special) { ?>
                    <li class="price-gruop">
                        <span class="price-new"><?php echo $price; ?></span>
                    </li>
                    <?php } else { ?>
                    <li>
                        <span class="price-new">
                        <?php echo $special; ?>
                        </span>
                        <span style="text-decoration: line-through;">
                        <?php echo $price; ?>
                        </span>
                    </li>
                    <?php } ?>
                    <?php if ($tax) { ?>
                    <li class="other-price price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                    <?php } ?>
                    <?php if ($discounts) { ?>
                    <li>
                        <hr>
                    </li>
                    <?php foreach ($discounts as $discount) { ?>
                    <li class="discount"><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                    <?php } ?>
                    <?php } ?>
                </ul>
            </div>
            <?php } ?>
            <div id="product">
                <div class="product-extra">
                    <div class="quantity-adder pull-left">
                        <span class="control-label pull-left text-qty" for="input-quantity"><?php echo $entry_qty; ?></span>
                        <div class="quantity-number input-group pull-left">
                            <span class="add-down add-action input-group-addon"><i class="fa fa-minus"></i></span>
                            <input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
                            <span class="add-up add-action input-group-addon"><i class="fa fa-plus"></i></span>
                        </div>
                    </div>
                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                    <div class="action pull-left">
                        <div class="cart">
                            <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-variant">
                            <span><?php echo $button_cart; ?></span>
                            </button>
                        </div>
                        <div class="wishlist">
                            <button type="button" data-toggle="tooltip" class="wishlist btn btn-outline-inverse btn-variant" title="<?php echo $button_wishlist; ?>" onclick="wishlist.addwishlist('<?php echo $product_id; ?>');">
                            <i class="fa fa-heart"></i>
                            <span><?php echo $button_wishlist; ?></span>
                            </button>
                        </div>
                        <div class="compare">
                            <button type="button" data-toggle="tooltip" class="compare btn btn-outline-inverse btn-variant" title="<?php echo $button_compare; ?>" onclick="compare.addcompare('<?php echo $product_id; ?>');">
                            <i class="fa fa-refresh"></i>
                            <span><?php echo $button_compare; ?></span>
                            </button>
                        </div>
                    </div>
                </div>
                <?php if ($options) { ?>
                <hr>
                <h3><?php echo $text_option; ?></h3>
                <?php foreach ($options as $option) { ?>
                <?php if ($option['type'] == 'select') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                        </option>
                        <?php } ?>
                    </select>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'radio') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                            <label>
                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'checkbox') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="checkbox">
                            <label>
                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'image') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                            <label>
                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                            <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'text') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'file') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                    <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group date">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                        </span>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group datetime">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group time">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span>
                    </div>
                </div>
                <?php } ?>
                <?php } ?>
                <?php } ?>
            </div>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
            <hr>
            <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
            <!-- AddThis Button END -->
        </div>
    </div>
</div>
<div class="tabs-group box">
    <ul class="nav nav-tabs clearfix">
        <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
        <?php if ($attribute_groups) { ?>
        <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
        <?php } ?>
        <?php if ($review_status) { ?>
        <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
        <?php } ?>
        <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
        <li><a href="#tab-customtab" data-toggle="tab"><?php echo $productConfig['product_customtab_name'][$languageID]; ?><span class="triangle-bottomright"></span></a></li>
        <?php } ?>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab-description" itemprop="description"><?php echo $description; ?></div>
        <?php if ($attribute_groups) { ?>
        <div class="tab-pane" id="tab-specification">
            <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                    <tr>
                        <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                    <tr>
                        <td><?php echo $attribute['name']; ?></td>
                        <td><?php echo $attribute['text']; ?></td>
                    </tr>
                    <?php } ?>
                </tbody>
                <?php } ?>
            </table>
        </div>
        <?php } ?>
        <?php if ($review_status) { ?>
        <div class="tab-pane" id="tab-review">
            <div id="review"></div>
            <p> <a href="#review-form"  class="popup-with-form btn btn-sm btn-inverse" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a></p>
            <div class="hide">
                <div id="review-form" class="panel">
                    <div class="panel-body">
                        <form class="form-horizontal ">
                            <h2><?php echo $text_write; ?></h2>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                    <div class="help-block"><?php echo $text_note; ?></div>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label"><?php echo $entry_rating; ?></label>
                                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                                    <input type="radio" name="rating" value="1" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="2" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="3" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="4" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="5" />
                                    &nbsp;<?php echo $entry_good; ?>
                                </div>
                            </div>
                            <?php echo $captcha; ?>
                            <div class="buttons clearfix">
                                <div class="pull-right">
                                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <?php } ?>
        <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_content'][$languageID]) ) { ?>
        <div id="tab-customtab" class="tab-content tab-pane custom-tab">
            <div class="inner">
                <?php echo html_entity_decode( $productConfig['product_customtab_content'][$languageID], ENT_QUOTES, 'UTF-8'); ?>
            </div>
        </div>
        <?php } ?>
    </div>
</div>