<?php 
    $helper =  ThemeControlHelper::getInstance( $this->registry );
    echo $header; ?>
<div id="columns">
    <div class="container" id="category-dropdown-list">
        <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
        <div class="row">
            <?php if( $SPAN[0] ): ?>
            <aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
                <?php echo $column_left; ?>
            </aside>
            <?php endif; ?>
            <section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
                <div id="content">
                    <?php echo $content_top; ?>
                    <div id="category-content">
                        <h1 class="heading-category"><?php echo $heading_title; ?></h1>
                        <?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>
                        <?php if ($thumb || $description) { ?>
                        <div class="box category-info ">
                            <?php if ($thumb) { ?>
                            <div class="image">
                                <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-responsive" />
                            </div>
                            <?php } ?>
                            <?php if ($description) { ?>
                            <div class="category-description">
                                <?php echo $description; ?>
                            </div>
                            <?php } ?>
                        </div>
                        <?php } ?>
                        <?php if ($categories) { ?>
                        <div class="row">
                            <?php foreach ($categories as $category) { ?>
                            <div class="col-sm-6 col-xs-12 text-center subcategory-holder <?php echo $subspan ?>">
                                <a href="<?php echo $category['href'] ?>">
                                    <img src="<?php echo $category['image'] ?>" class="img-responsive subcategory-image" alt="<?php echo $category['name'] ?>" title="<?php echo $category['name'] ?>"> 
                                    <h2><?php echo $category['name'] ?></h2>
                                </a>
                            </div>
                            <?php } ?>
                        </div>
                        <?php } ?>
                        <?php if ($products) { ?>
                        <?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?>
                        <?php } ?>
                        <?php if (!$categories && !$products) { ?>
                        <div class="content">
                            <div class="wrapper clearfix"><?php echo $text_empty; ?></div>
                        </div>
                        <div class="buttons">
                            <a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a>
                        </div>
                        <?php } ?>
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
            </section>
        </div>
        <?php if( $SPAN[2] ): ?>
        <aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">  
            <?php echo $column_right; ?>
        </aside>
        <?php endif; ?>
    </div>
</div>
<?php echo $footer; ?>