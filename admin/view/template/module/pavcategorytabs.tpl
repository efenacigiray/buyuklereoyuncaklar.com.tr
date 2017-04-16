<?php 
	echo $header; 
	echo $column_left;
	$module_row=0; 
?>
<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a class="btn btn-primary" onclick="$('#form').submit();"><?php echo $button_save; ?></a>
				<?php if(!empty($module_id)) { ?>
				<a onclick="confirm('Are you sure?') ? location.href='<?php echo $delete; ?>' : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Delete">Delete</a>
				<?php } ?>
				<a class="btn btn-default" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div><!-- End div#page-header -->

	<div id="page-content" class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
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
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
			</div>

			<div class="content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-2">
								<ul class="nav nav-pills nav-stacked">
									<?php if ($extensions) { ?>
									<?php foreach ($extensions as $extension) { ?>
									<?php $actived = (empty($module_id))?"class='active'":''; ?>
									<li <?php echo $actived; ?>><a href="<?php echo $extension['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $extension['name']; ?></a></li>
									<?php $i=0; foreach ($extension['module'] as $m) { $i++;?>
									<?php $active = ($m['module_id'] == $module_id)?'class="active"':''; ?>
									<li <?php echo $active; ?>><a href="<?php echo $m['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $m['name']; ?></a></li>
									<?php } //end modules?>
									<?php } //end extensions?>
									<?php } //end if?>
								</ul>
							</div> <!-- End UL TAB -->

							<div class="col-sm-10">
								
								<div class="tab-pane active" id="tab-module-pavcategorybanner">
									<table class="table">
										<tr class="no-border">
											<td class="col-sm-2"><?php echo $entry_status; ?></td>
											<td class="col-sm-10">
												<select class="form-control no-style" name="pavcategorytabs_module[status]">
													<?php if ($module['status']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br>
											</td>
										</tr>
										<tr class="no-border">
											<td class="col-sm-2"><?php echo $entry_module_name; ?></td>
											<td class="col-sm-10"><input class="form-control no-style" type="text" placeholder="<?php echo $entry_module_name; ?>" name="pavcategorytabs_module[name]" value="<?php echo $module['name']; ?>"/></td>
										</tr>
									</table>
									<ul class="nav nav-tabs" id="language">
										<?php foreach ($languages as $language) {?>
										<li><a href="#tab-module-language-<?php echo $language["language_id"]; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
										<?php } ?>
									</ul>
									<div class="tab-content">
										<?php foreach ($languages as $language) {?>
										<div class="tab-pane" id="tab-module-language-<?php echo $language["language_id"]; ?>">
											<table class="table">
												<tr class="no-border">
													<td class="col-sm-2"><?php echo $objlang->get("entry_description"); ?></td>
													<td class="col-sm-10">
														<textarea id="description_<?php echo $language['language_id'];?>" name="pavcategorytabs_module[description][<?php echo $language['language_id']; ?>]">
															<?php echo isset($module['description'][$language['language_id']])?$module['description'][$language['language_id']]:''; ?>
														</textarea>
													</td>
												</tr>
											</table>
										</div>
										<?php } ?>
									</div>
									<table class="table">
										<tr>
											<td><?php echo $objlang->get('prefix_class'); ?></td>
											<td>
												<input class="form-control no-width" type="text" name="pavcategorytabs_module[prefix_class]" value="<?php echo isset($module['prefix_class'])?$module['prefix_class']:''; ?>" />
											</td>
										</tr>
										<tr>
											<td><?php echo $entry_tabs; ?></td>
											<td>
												<select class="form-control no-width" name="pavcategorytabs_module[category_id]">
													<?php foreach ($categories as $category) { ?>
													<?php $category_id = isset($module['category_id'])?$module['category_id']:0;?>
													<?php $selected = ($category['category_id'] == $category_id)?'selected=selected':''?>
													<option value="<?php echo $category['category_id']; ?>" <?php echo $selected;?>><?php echo $category['name']; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td><?php echo $objlang->get( 'entry_icon_image' );?></td>
											<td class="col-sm-8">
												<?php $thumb = isset($module['thumb'])?$module['thumb']:$no_image; ?>
												<a href="" id="thumb-image"data-toggle="image" class="img-thumbnail">
													<img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" />
												</a>
												<input type="hidden" name="pavcategorytabs_module[image]" value="<?php echo $module['image']; ?>" id="input-image" />
											</td>
										</tr>
										<tr>
											<td><?php echo $objlang->get( 'entry_size_icon' );?></td>
											<td class="left">
												<input class="form-control no-width" type="text" name="pavcategorytabs_module[iwidth]" value="<?php echo isset($module['iwidth'])?$module['iwidth']:'50'; ?>" size="3" /> x 
												<input class="form-control no-width" type="text" name="pavcategorytabs_module[iheight]" value="<?php echo isset($module['iheight'])?$module['iheight']:'50'; ?>" size="3"/>
											</td>	
										</tr>
										<tr>
											<td><?php echo $limit_tabs; ?></td>
											<td class="left">	
												<input class="form-control no-width" type="text" name="pavcategorytabs_module[limit_tabs]" value="<?php echo isset($module['limit_tabs'])?$module['limit_tabs']:4;?>" size="3"/>
											</td>	
										</tr>
										<tr>
											<td><?php echo $status_nav; ?></td>
											<td class="left">
												<select class="form-control no-width"name="pavcategorytabs_module[status_nav]">
													<?php if($module['status_nav']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1" ><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>	
										</tr>
										<tr>
											<td><?php echo $entry_dimension; ?></td>
											<td class="left"><input class="form-control no-width"type="text" name="pavcategorytabs_module[width]" value="<?php echo isset($module['width'])?$module['width']:'200'; ?>" size="3" /> x 
											<input class="form-control no-width"type="text" name="pavcategorytabs_module[height]" value="<?php echo isset($module['height'])?$module['height']:'200'; ?>" size="3"/>
											<?php if (isset($error_dimension[$module_row])) { ?>
											<span class="error"><?php echo $error_dimension[$module_row]; ?></span>
											<?php } ?></td>	
										</tr>
										<tr>
											<td class="left"><?php echo $entry_carousel; ?></td>
											<td class="left"><input class="form-control no-width"type="text" name="pavcategorytabs_module[itemsperpage]" value="<?php echo isset($module['itemsperpage'])?$module['itemsperpage']:4; ?>" size="3" /> x 
											<input class="form-control no-width"type="text" name="pavcategorytabs_module[cols]" value="<?php echo isset($module['cols'])?$module['cols']:4; ?>" size="3"/> x 
											<input class="form-control no-width"type="text" name="pavcategorytabs_module[limit]" value="<?php echo isset($module['limit'])?$module['limit']:4; ?>" size="3"/>
											<?php if (isset($error_carousel[$module_row])) { ?>
											<span class="error"><?php echo $error_carousel[$module_row]; ?></span>
											<?php } ?></td>
										</tr>
									</table>



								</div>
							</div>
						</div>
					</div><!-- End div .panel-body -->
				</form>
			</div>
		
			<!-- end div content form -->

		</div>
	</div><!-- End div#page-content -->

</div><!-- End div#content -->



<script type="text/javascript">
	// Description Language
	<?php foreach ($languages as $language) { ?>
		$('#description_<?php echo $language['language_id']; ?>').summernote({ height: 150 });
	<?php } ?>
	$('#language li:first-child a').tab('show');
	// Active Tab Module
	$('#module-pavcategorytabs li:first-child a').tab('show');
</script> 
 
<style type="text/css">
	.no-border > td{ border-top: 1px solid white !important;}
	.no-style{ width: 35%;}
</style>
<?php echo $footer; ?>
