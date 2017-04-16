<?php
$objlang = $this->registry->get('language');
$autosearch = $helper->renderModule( 'pavautosearch' );
$verticalmenu=$helper->renderModule('pavverticalmenu');
?>
<div class="has-verticalmenu">
    <header id="header">
        <div id="header-main" class="hasverticalmenu">
            <div class="container">
                <div class="row">
                    <div class="logo inner  col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <div id="logo" class="logo-store pull-left">
                            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                        </div>
                    </div>
                    <?php if (isset($autosearch) &&  !empty($autosearch)) { ?>
                    <div class="inner col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <div id="search-auto" class=" search-box search-wrapper clearfix clearfix">
                            <?php echo $autosearch ?>
                        </div>
                    </div>
                    <?php } else { ?>
                    <div id="search" class="inner col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <div class="quick-access">
                            <?php echo $search; ?>
                        </div>
                    </div>
                    <?php } ?>

                    <div id="cart-top" class=" inner col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <div class="show-mobile hidden-lg hidden-md">
                            <div class="quick-access pull-left">
                                <button id="offcanvas-btn" data-toggle="offcanvas" class="btn btn-outline visible-xs" type="button">Menu</span></button>
                            </div>
                        </div>
                        <div class="cart-top">
                            <?php echo $cart; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <section id="pav-masshead" class="pav-masshead aligned-right">
        <div class="container">
            <div class="row visible-sm">
                <!-- Categories Hover -->
                <div id="category-tablet">
                    <?php $id = rand(1,time()) . "accordion"; ?>
                    <?php $target = rand(1,time()) . "target"; ?>
                    <div class="category box box-highlights theme">
                        <div class="box-content tree-menu">
                            <ul id="<?php echo $id; ?>" class="box-category box-panel">
                                <?php foreach ($categories as $key => $category) { ?>
                                <li class="accordion-group clearfix">
                                    <?php if ($category['category_id'] == $category_id) { ?>
                                    <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                    <?php } ?>
                                    <?php if ($category['children']) { ?>
                                    <div class="accordion-heading pull-right">
                                        <span data-toggle="collapse" data-parent="#<?php echo $id; ?>" data-target="#<?php echo $target.$key ;?>" class="badge">+</span>
                                    </div>
                                    <ul id="<?php echo $target.$key ;?>" class="collapse accordion-body <?php if($category['category_id'] == $category_id) echo "in"; ?>">
                                    <?php foreach ($category['children'] as $child) { ?>
                                        <li class="sub-menu">
                                            <?php if ($child['category_id'] == $child_id) { ?>
                                            <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
                                            <?php } else { ?>
                                            <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                            <?php } ?>
                                        </li>
                                <?php } ?>
                            </ul>
                            <?php } ?>
                            </li>
                            <?php } ?>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Categories Hover -->
            </div>
            <div class="inner row clearfix color-bg">
                <div id="hideverticalmenu" class="col-lg-3 col-md-3 col-sm-4 hidden-xs">
                    <?php if(!empty($verticalmenu)) { ?>
                    <?php echo $verticalmenu; ?>
                    <?php } ?>
                </div>
                <div id="pav-mainnav" class="col-lg-9 col-md-9 col-sm-12">
                    <?php $modules = $helper->renderModule('pavmegamenu'); ?>
                    <?php echo $modules; ?>
                </div>
            </div>
        </div>
    </section>
</div>