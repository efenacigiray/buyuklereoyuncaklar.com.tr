<?php
/******************************************************
 * @package  : Pav Map module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/
?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="container-fluid">
	  <div class="page-header">
		<h1><?php echo $heading_title; ?></h1>
		<ul class="breadcrumb">
		    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
		    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		    <?php } ?>
		  </ul>
  		</div><!-- End div#page-header -->
  	</div>
  <div id="page-content" class="container-fluid">
    <?php if ($error_warning) { ?>
    	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      	<button type="button" class="close" data-dismiss="alert">&times;</button>
    	</div>
     	<?php } ?>
	<?php if (isset($success) && !empty($success)) { ?>
	<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>
	<?php } ?>
	<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">

		<div class="col-md-2">
			<div class="logo"><h3><?php echo $objlang->get('left_title'); ?> </h3></div>
			<div class="slidebar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
			<div class="clear clr"></div>
		</div>
		<div class="col-md-10">
			<div class="heading">
				<h3 class="logo"><?php echo $objlang->get("text_configuration_module"); ?></h3>
			</div>
			<div class="toolbar"><?php require( dirname(__FILE__).'/action_bar.tpl' ); ?></div>
			<div class="clearfix">
			 			

				 <!-- Nav tabs -->
	                <div class="row">
		                  <ul class="nav nav-tabs" role="tablist">
		                    <li <?php if( $selectedid ==0 ) { ?>class="active" <?php } ?>> <a href="<?php echo $link; ?>"> <span class="fa fa-plus"></span> <?php echo $olang->get('button_add_module');?></a></li>
		                    <?php $i=1; foreach( $moduletabs as $key => $moduletab ){ ?>
		                    <li role="presentation" <?php if( $moduletab['module_id']==$selectedid ) {?>class="active"<?php } ?>>
		                      <a href="<?php echo $link; ?>&module_id=<?php echo $moduletab['module_id']?>" aria-controls="bannermodule-<?php echo $key; ?>"  >
		                        <span class="fa fa-pencil"></span> <?php echo $moduletab['name']?>
		                       </a>
		                      </li>
		                    <?php $i++ ;} ?>
		                  
		                  </ul>
	                      
	                </div>
       				 <!-- Tab panes -->

            </div>   				 
			<div class="content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<input style="width:55%" name="action" type="hidden" id="action"/>
					<input style="width:55%" type="hidden" value="<?php echo $store_id;?>" name="pavmap_module[store_id]"/>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" style="font-weight: bold;color:red;"><?php echo $objlang->get('entry_default_store'); ?></label>
						<div class="col-sm-10">
							<select name="pavmap_module[stores]" id="pavstores">
								<?php foreach($stores as $store):?>
								<?php if($store['store_id'] == $store_id):?>
								<option value="<?php echo $store['store_id'];?>" selected="selected"><?php echo $store['name'];?></option>
								<?php else:?>
								<option value="<?php echo $store['store_id'];?>"><?php echo $store['name'];?></option>
								<?php endif;?>
								<?php endforeach;?>
							</select><br/><br/>
						</div>
					</div>
					 
		            <div class="col-sm-12">
		            <div class="tab-content" id="tab-content">
				      <?php $module_row = 1; ?>
				      <?php foreach ($modules as $module) { ?>
				      <div class="clearfix" id="tab-module<?php echo $module_row; ?>">
				      	 <div class="row form-group">
				            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
				            <div class="col-sm-10">
				              <select name="pavmap_module[<?php echo $module_row; ?>][status]" id="input-status" class="form-control">
				                <?php if ( $module['status'] ) { ?>
				                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				                <option value="0"><?php echo $text_disabled; ?></option>
				                <?php } else { ?>
				                <option value="1"><?php echo $text_enabled; ?></option>
				                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				                <?php } ?>
				              </select>
				            </div>
				        </div>


						<div class="row form-group">
							<label class="col-sm-2 control-label" for="input-status"><?php echo $objlang->get('entry_name'); ?></label> 
							<div class="col-sm-10">
								<input   name="pavmap_module[<?php echo $module_row; ?>][name]" value="<?php echo (isset($module['name'])?$module['name']:'' ) ?>" class="form-control" />
							</div>
						</div>

						<div class=""></div>
						<ul class="nav nav-tabs" id="language<?php echo $module_row; ?>">
	                      <?php foreach ($languages as $language) { ?>
	                      <li><a href="#tab-module<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
	                      <?php } ?>
	                    </ul>
						<div class="tab-content">
                 		 <?php foreach ($languages as $language) { ?>
                   			<div class="tab-pane" id="tab-module<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>">
       							<table class="table">
									<tr>
										<td class="col-sm-2"><?php echo $objlang->get('entry_title'); ?></td>
										<td class="col-sm-10"><input style="width:55%" type="text" value="<?php echo isset($module['title'][$language['language_id']]) ? $module['title'][$language['language_id']] : ''; ?>" name="pavmap_module[<?php echo $module_row; ?>][title][<?php echo $language['language_id']; ?>]" class="form-control"></td>
									</tr>
									<tr>
										<td class="col-sm-2"><?php echo $objlang->get('entry_description'); ?></td>
										<td class="col-sm-10"><textarea class="pavo-editor" rows="2" cols="60" name="pavmap_module[<?php echo $module_row; ?>][des][<?php echo $language['language_id']; ?>]" id="des-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['des'][$language['language_id']]) ? $module['des'][$language['language_id']] : ''; ?></textarea></td>
									</tr>
								</table>
							</div>
							<?php } ?>
								<table class="table">
									

									<tr>
										<td class="col-sm-2"><?php echo $objlang->get('prefix_class'); ?></td>
										<td class="col-sm-10">
											<input style="width:55%" name="pavmap_module[<?php echo $module_row; ?>][prefix]" value="<?php echo (isset($module['prefix'])?$module['prefix']:'' ) ?>" class="form-control" />
											<span class="help"><?php echo $objlang->get("help_prefix_class"); ?></span>
										</td>
									</tr>
									<tr>
										<td class="col-sm-2"><?php echo $entry_limit; ?></td>
										<td class="col-sm-10"><input style="width:55%" type="text" name="pavmap_module[<?php echo $module_row; ?>][limit]" value="<?php echo isset($module['limit'])?$module['limit']:20; ?>" class="form-control" />
											<span class="help"><?php echo $help_limit; ?></span>
										</td>
									</tr>
									<tr>
										<td class="col-sm-2"><?php echo $entry_height; ?></td>
										<td class="col-sm-10"><input style="width:55%" type="text" name="pavmap_module[<?php echo $module_row; ?>][height]" value="<?php echo isset($module['height'])?$module['height']:400; ?>" class="form-control" /></td>
									</tr>
								</table>
						</div>
					</div>
					<?php $module_row++; ?>
					<?php } ?>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$('.pavo-editor').summernote({
    height: 300
  });
//--></script>
<script type="text/javascript"><!--
$(document).ready( function() {
  $('#pavstores').bind('change', function () {
      url = 'index.php?route=module/pavmap&token=<?php echo $token; ?>';
      var id = $(this).val();
      if (id) {
          url += '&store_id=' + encodeURIComponent(id);
      }
      window.location = url;
  });
});
//--></script>
 <script type="text/javascript"><!--
 <?php $module_row = 1; ?>
$('#module li:first-child a').tab('show');
<?php foreach ($modules as $module) { ?>
$('#language<?php echo $module_row; ?> li:first-child a').tab('show');
<?php $module_row++; ?>
<?php } ?>
//--></script>
<?php echo $footer; ?>