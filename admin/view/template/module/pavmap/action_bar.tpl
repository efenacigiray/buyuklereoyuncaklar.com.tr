<div class="pav-toolbar">
	<div class="pav-group">
		<?php
			if(isset($menu_active)){
				switch ($menu_active) {
					case 'modules':
						?>
						<a class="btn btn-primary btn-sm" onclick="$('#form').submit();"><?php echo $button_save; ?></a>
				        <a class="btn btn-success btn-sm" onclick="$('#action').val('save-stay');$('#form').submit();"><?php echo $objlang->get('button_save_stay'); ?></a>
				        <a class="btn btn-danger btn-sm" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
				        <?php if( $selectedid ){ ?>
			             
			              <a href="<?php echo $action;?>&delete=1" class="remove btn btn-danger pull-right btn-sm" ><span><i class="fa fa-remove"></i><?php echo $olang->get('text_dete_module');?></span></a>
			     
			            <?php } ?>


						<?php
						break;
					case 'grouplocation':
						?>
						<a href="<?php echo $insert_link;?>" class="btn btn-primary btn-sm"><span><?php echo $button_insert; ?></span></a>&nbsp;&nbsp;
						<a onclick="$('#action').val('delete');$('#form').submit();" class="btn btn-danger btn-sm"><span><?php echo $button_delete; ?></span></a>&nbsp;&nbsp;
						<?php
					break;
					case 'location':
						?>
						<a href="<?php echo $insert_link;?>" class="btn btn-primary btn-sm"><span><?php echo $button_insert; ?></span></a>&nbsp;&nbsp;
						<a onclick="$('#action').val('delete');$('#form').submit();" class="btn btn-danger btn-sm"><span><?php echo $button_delete; ?></span></a>&nbsp;&nbsp;
						<?php
					break;
					case 'insert':
						?>
						<a onclick="$('#form').submit();" class="btn btn-primary btn-sm"><span><?php echo $button_save; ?></span></a>&nbsp;&nbsp;
						<a href="<?php echo $cancel; ?>" class="btn btn-danger btn-sm"><span><?php echo $button_cancel; ?></span></a>&nbsp;&nbsp;
						<?php
						break;
					break;
					case 'update':
						?>
						<a onclick="$('#form').submit();" class="btn btn-primary btn-sm"><span><?php echo $button_save; ?></span></a>&nbsp;&nbsp;
						<a onclick="$('#action').val('save-stay');$('#form').submit();" class="btn btn-success btn-sm"><span><?php echo $button_save_stay; ?></span></a>&nbsp;&nbsp;
						<a href="<?php echo $cancel; ?>" class="btn btn-danger btn-sm"><span><?php echo $button_cancel; ?></span></a>&nbsp;&nbsp;
						<?php
						break;
					break;
					default:
						break;
				}
			}
		?>
	</div>
</div>
