<?php if ($modules) { ?>
<column id="column-left" class="hidden-xs sidebar hidden-sm">
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
</column>
<?php } ?>