<?php 
  require_once(DIR_SYSTEM . 'pavothemes/loader.php');
  $config = $this->registry->get('config'); 
  $helper = ThemeControlHelper::getInstance( $this->registry, $config->get('config_template') );
  $layoutID = 1 ;
  $objlang = $this->registry->get('language'); 
  $ourl = $this->registry->get('url');   

  if ( !($helper->getConfig('enable_pagebuilder') && $helper->isHomepage())) {
    $blockid = 'mass_top';
    $blockcls = '';
    $ospans = array(1=>12);
    require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
  
    $blockid = 'mass_center';
    $blockcls = '';
    $ospans = array(1=>12);
    require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
  
    $blockid = 'mass_bottom';
    $blockcls = '';
    $ospans = array(1=>12);
    require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
  } 
?>
<footer id="footer">
  <section class="mass-bottom" id="pavo-mass-bottom">
    <div class="container">
      <div class="inner">
        <div class="row informations">
          <div class="col-md-3 col-sm-3">
            <h4 class="box-heading"><span><?php echo $text_service; ?></span></h4>
            <ul class="list-unstyled">
              <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
              <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
              <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
            </ul>
          </div>
          <div class="col-md-3 col-sm-3">
            <h4 class="box-heading"><span><?php echo $text_extra; ?></span></h4>
            <ul class="list-unstyled">
              <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
              <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
            </ul>
          </div>
          <div class="col-md-3 col-sm-3">
            <h4 class="box-heading"><span><?php echo $text_account; ?></span></h4>
            <ul class="list-unstyled">
              <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
              <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
              <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
              <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
            </ul>
          </div>
          <div class="col-md-3 col-sm-3">
            <?php if ($informations) { ?>
              <h4 class="box-heading"><span><?php echo $text_information; ?></span></h4>
              <ul class="list-unstyled">
                <?php foreach ($informations as $information) { ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
              </ul>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
  </section>
</footer>
<div id="map" class="container">
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3008.092507684418!2d29.00069896682696!3d41.06697050128551!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0000000000000000%3A0xc69df307df196826!2sB%C3%BCy%C3%BCklere+Oyuncaklar!5e0!3m2!1sen!2str!4v1455113881563&hl=iw" width="100%" height="500" frameborder="0" style="border:0" allowfullscreen></iframe>
</div>
<div id="powered">
  <div class="container">
    <div class="inner">
      <div id="top">
        <a class="scrollup" href="#"><i class="fa fa-angle-up"></i>Top</a>
      </div>
      <div class="copyright">
        <?php echo $helper->getConfig('copyright'); ?><br>
      </div>
    </div>
  </div>
</div>
<!--Start of Zopim Live Chat Script-->
<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute("charset","utf-8");
$.src="//v2.zopim.com/?49suxwa9kgzXOV61w0nZZeD3Anop4cWu";z.t=+new Date;$.
type="text/javascript";e.parentNode.insertBefore($,e)})(document,"script");
</script>
<!--End of Zopim Live Chat Script-->
</body>
</html>