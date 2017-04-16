<?php
$config = $this->registry->get('config');
$themeName =  $config->get('config_template');
$themeConfig = (array)$config->get('themecontrol');

require_once(DIR_SYSTEM . 'pavothemes/loader.php');
$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );

$helper->setDirection( $direction );
$helper->triggerUserParams( array('headerlayout','productlayout') );
$logoType = $helper->getConfig('logo_type','logo-theme');
$headerlayout = $helper->getConfig('header_layout');
$template_layout = $helper->getConfig('layout');
$skin = $helper->getConfig('skin');

$ctheme=$helper->getConfig('customize_theme');

if( file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$ctheme.'.css') ) {
    $helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$ctheme.'.css'  );
}
$helper->addCssList( $styles );

$stickymenu = isset($themeConfig['stickymenu'])?$themeConfig['stickymenu']:'main-menu-fixed';
?>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="google-site-verification" content="4JfSbtjYueArcAOwn8OaEmLgqk45kHxA9WZd8AIpAPk" />
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content= "<?php echo $keywords; ?>" />
    <?php } ?>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <?php foreach ($helper->getCssLinks() as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <script type="text/javascript" src="catalog/view/javascript/main.js"></script>
    <script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
    <?php foreach( $helper->getScriptFiles() as $script )  { ?>
    <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>
</head>
<body class="<?php echo $stickymenu;?> <?php echo $class; ?> <?php echo $helper->getPageClass();?> layout-<?php echo $template_layout; ?>">
<script>
function statusChangeCallback(t){auth=t.status,"connected"===t.status?testAPI():"not_authorized"===t.status}function login(){FB.login(function(t){statusChangeCallback(t)},{scope:"email,user_likes"})}function testAPI(){FB.api("/me",function(t){user=JSON.stringify(t),$.ajax({url:"index.php?route=account/facebook",type:"post",data:{auth:auth,user:user},dataType:"json",success:function(t){"true"==t.email&&(window.location="index.php?route=account/account"),"true"==t.status&&location.reload()}})})}var auth="",user="";window.fbAsyncInit=function(){FB.init({appId:"529923810501593",cookie:!0,xfbml:!0,version:"v2.5"})},function(t,e,n){var a,o=t.getElementsByTagName(e)[0];t.getElementById(n)||(a=t.createElement(e),a.id=n,a.src="//connect.facebook.net/en_US/sdk.js",o.parentNode.insertBefore(a,o))}(document,"script","facebook-jssdk");
</script>
<div  class="row-offcanvas row-offcanvas-left">
    <div id="page">
        <section id="header-top" >
            <div id="topbar">
                <div class="container">
                    <div class="show-desktop">
                        <div class="quick-access pull-left">
                            <div class="login links link-active">
                                <?php if ($logged) { ?>
                                <a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
                                <?php } else { ?>
                                <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a> veya
                                <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a>
                                <?php } ?>
                            </div>
                        </div>
                        <!--Button -->
                        <div class="quick-top-link  links pull-right">
                            <?php if (!$logged) { ?>
                            <a class="btn btn-outline btn-fb" href="javascript:;" onclick="login();"><i class="fa fa-facebook"></i>Facebook ile Giriş Yap</a>
                            <?php } ?>
                            <div class="btn-group box-user">
                                <div data-toggle="dropdown">
                                    <span><?php echo $text_account; ?></span>
                                    <i class="fa fa-angle-down "></i>
                                </div>
                                <ul class="dropdown-menu setting-menu">
                                    <li id="wishlist">
                                        <a href="<?php echo $wishlist; ?>" id="wishlist-total"><i class="fa fa-list-alt"></i>&nbsp;&nbsp;<?php echo $text_wishlist; ?></a>
                                    </li>
                                    <li class="acount">
                                        <a href="<?php echo $account; ?>"><i class="fa fa-user"></i>&nbsp;&nbsp;<?php echo $text_account; ?></a>
                                    </li>
                                    <li class="shopping-cart">
                                        <a href="<?php echo $shopping_cart; ?>"><i class="fa fa-bookmark"></i>&nbsp;&nbsp;<?php echo $text_shopping_cart; ?></a>
                                    </li>
                                    <li class="checkout">
                                        <a class="last" href="<?php echo $checkout; ?>"><i class="fa fa-share"></i>&nbsp;&nbsp;<?php echo $text_checkout; ?></a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- header -->
            <?php require( $helper->getLayoutPath('common/header/hasverticalmenu.tpl') ); ?>
            <!-- /header -->
        </section>
        <!-- sys-notification -->
        <div id="sys-notification">
            <div id="notification"></div>
        </div>
        <!-- /sys-notification -->
        <?php
        $blockid = 'slideshow';
        $blockcls = '';
        $ospans = array();
        $sconfig = $this->registry->get('config');
        $config = $sconfig->get('themecontrol');

        if (isset($layoutID) && $layoutID ){
            $modules = $helper->getCloneModulesInLayout( $blockid, $layoutID );
        } else {
            $modules = $helper->getModulesByPosition( $blockid );
        }

        if (count($modules)) {
        $cols = isset($config['block_'.$blockid])&& $config['block_'.$blockid]?(int)$config['block_'.$blockid]:count($modules);
        $class = $helper->calculateSpans( $ospans, $cols );
        ?>
        <div class="slideshow" id="pavo-slideshow">
            <div class="container">
                <div class="inner">
                    <div class="row">
                        <!-- Categories -->
                        <div class="col-lg-3 col-md-3 hidden-sm hidden-xs" id="category-dropdown-list">
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
                        <!-- Categories -->
                        <div class="col-md-9 col-sm-12 col-xs-12">
                            <?php foreach ($modules as $module) { ?>
                            <?php echo $module; ?>
                            <?php } ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php } ?>

        <?php
        $blockid = 'promotion';
        $blockcls = '';
        $ospans = array();
        require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
        ?>
        <?php

        $blockid = 'showcase';
        $blockcls = '';
        $ospans = array(1=>12);
        require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
        ?>

<!-- Categories Hover -->
<div class="col-lg-12 col-md-12 hidden" id="category-dropdown-list-backup">
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