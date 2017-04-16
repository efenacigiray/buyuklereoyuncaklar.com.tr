<?php if (count($languages) > 1) { ?>
<div class="pull-left">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-groups">
    <div data-toggle="dropdown" class="dropdown-toggle">
        <?php foreach ($languages as $language) { ?>
        <?php if ($language['code'] == $code) { ?>
        <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
        <?php } ?>
        <?php } ?>
        <span><?php echo $text_language; ?></span> <i class="fa fa-angle-down"></i>
    </div>
    <ul class="dropdown-menu">
      <?php foreach ($languages as $language) { ?>
      <li><a href="<?php echo $language['code']; ?>"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>


  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
