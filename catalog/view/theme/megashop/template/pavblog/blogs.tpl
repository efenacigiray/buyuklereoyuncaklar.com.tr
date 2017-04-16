<?php echo $header; ?>
<div class="container">
    <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
    <?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>

    <div class="row"><?php if( $SPAN[0] ): ?>
        <aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
            <?php echo $column_left; ?>
        </aside>
        <?php endif; ?>

        <section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">

            <div id="content">
                <?php echo $content_top; ?>
                <h1 class="title-blogs"><?php echo $heading_title; ?></h1>
                <a class="rss-wrapper clearfix pull-right" href="<?php echo $latest_rss;?>"><span class="fa fa-feed"></span></a>
                <section class="pav-filter-blogs wrapper clearfix clearfix blog-wrapper clearfix clearfix">
                    <div class="pav-blogs">
                        <?php
					$cols = $cat_columns_leading_blogs;
                        if( count($leading_blogs) ) { ?>
                        <div class="leading-blogs blog-list-item">
                            <div class="row">
                                <?php foreach( $leading_blogs as $key => $blog ) { $key = $key + 1;?>
                                <div class="col-lg-<?php echo floor(12/$cols);?> col-sm-<?php echo floor(12/$cols);?> col-xs-12">
                                    <?php require( '_item.tpl' ); ?>
                                </div>
                                <?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>

                                <?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                        <?php } ?>

                        <?php
					$cols = $cat_columns_secondary_blogs;
                        $cols = !empty($cols)?$cols:1;
                        if ( count($secondary_blogs) ) { ?>
                        <div class="secondary blog-list-item">
                            <div class="row">
                                <?php foreach( $secondary_blogs as $key => $blog ) {  $key = $key+1; ?>
                                <div class="col-lg-<?php echo floor(12/$cols);?> col-sm-<?php echo floor(12/$cols);?> col-xs-12">
                                    <?php require( '_item.tpl' ); ?>
                                </div>
                                <?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>

                                <?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                        <?php } ?>
                        <div class="pagination clearfix"><?php echo $pagination;?></div>
                    </div>
                </section>
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

