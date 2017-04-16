<?php
$sconfig = $this->registry->get('config');
$config = $sconfig->get('themecontrol');

if( isset($layoutID) && $layoutID ){
    $modules = $helper->getCloneModulesInLayout( $blockid, $layoutID );
    }
else {
    $modules = $helper->getModulesByPosition( $blockid );
    }
if( count($modules) ){?>
    <?php $j=1;foreach ($modules as $i =>  $module) {  ?>
        <?php echo $module; ?>
    <?php  $j++;  } ?>
<?php } ?>