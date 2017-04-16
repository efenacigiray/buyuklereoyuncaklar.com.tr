<?php if (count($currencies) > 1) { ?>
<div class="quick-access">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="currency">
  <div class="btn-groups">
    <div class="dropdown-toggle" data-toggle="dropdown">
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
    <span><?php echo $currency['symbol_left']; ?></span>
    <?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
    <span><?php echo $currency['symbol_right']; ?></span>
    <?php } ?>
    <?php } ?>
        <span><?php echo $text_currency; ?></span>
        <i class="fa fa-angle-down"></i>
    </div>
    <div class="dropdown-menu ">
        <div class="box-currency inner">
              <?php foreach ($currencies as $currency) { ?>
              <?php if ($currency['symbol_left']) { ?>
                  <a href="javascript:void(0);" class="currency-select" data-name="<?php echo $currency['code']; ?>">
                      <?php echo $currency['symbol_left']; ?>
                      <span><?php echo $currency['code']; ?></span>
                  </a>
              <?php } else { ?>
                  <a href="javascript:void(0);" class="currency-select" data-name="<?php echo $currency['code']; ?>">
                      <?php echo $currency['symbol_right']; ?>
                      <span><?php echo $currency['code']; ?></span>
                  </a>
              <?php } ?>
              <?php } ?>
        </div>
    </div>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
