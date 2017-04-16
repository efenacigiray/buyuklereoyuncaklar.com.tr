<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
          <a class="btn btn-primary" onclick="$('#form').submit();"><?php echo $button_save; ?></a>
	        <a class="btn btn-success" onclick="$('#action').val('saveedit');$('#form').submit();"><?php echo $objlang->get('text_save_edit'); ?></a>
	        <a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="action" id="action" value=""/>
		 	  <?php if( $selectedid ){ ?>
		            <div class="pull-right">
		              <a href="<?php echo $action;?>&delete=1" class="remove btn btn-danger" ><span><i class="fa fa-remove"></i><?php echo $olang->get('text_dete_module');?></span></a>
		            </div>  
		            <?php } ?>
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


	  



          <div class="row">
            
            <div class="col-sm-12">

            <div class="tab-content" id="tab-content">
		      	<?php $module_row = 1; ?>
		      	<?php foreach ($modules as $module) { ?>

		      	  <div class="form-group row">
					<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
					<div class="col-sm-10">
						<select class="form-control no-width" class="form-control" name="pavsocial_module[<?php echo $module_row;?>][status]" id="input-status" class="form-control">
							<?php if ( isset($module['status']) && $module['status'] ) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select><br>
					</div>

				</div>

				<div class="module-class form-group row">
					<label class="col-sm-2"><?php echo $olang->get('text_module_name');?></label>
					<div class="col-sm-10"><input class="form-control" name="pavsocial_module[<?php echo $module_row;?>][name]" value="<?php if(isset($module['name'])){ echo $module['name']; }?>"></div>
				</div>	<hr>


		      	<div "clearfix">

					<ul class="nav nav-tabs">
			            <li class="active"><a href="#tab-<?php echo $module_row; ?>-Facebook" data-toggle="tab"><?php echo "Facebook"; ?></a></li>
			            <li><a href="#tab-<?php echo $module_row; ?>-Twitter" data-toggle="tab"><?php echo "Twitter"; ?></a></li>
			            <li><a href="#tab-<?php echo $module_row; ?>-Youtube" data-toggle="tab"><?php echo "Youtube"; ?></a></li>
			         </ul>
			        <div class="tab-content">
					<div class="tab-pane active" id="tab-<?php echo $module_row; ?>-Facebook">
						<table class="form">
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_facebook_url"); ?></td>
								<td class="col-sm-10">
									<input class="form-control" size="60" type="text" value="<?php echo (isset($module['facebook'])?$module['facebook']:'' ) ?>" name="pavsocial_module[<?php echo $module_row; ?>][facebook]" >
								</td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_application_id"); ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][application_id]" value="<?php echo isset($module['application_id'])?$module['application_id']:''; ?>" size="60" /></td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_border_color"); ?></td>
								<td class="col-sm-10">
									<select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][border_color]">
										<?php foreach( $yesno as $k=>$v ){ ?>
										<option value="<?php echo $k;?>" <?php if(isset($module['border_color']) && $k==$module['border_color']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_colorscheme"); ?></td>
								<td class="col-sm-10">
									<select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][colorscheme]">
										<?php if (isset($module['colorscheme']) && $module['colorscheme']=='dark') { ?>
										<option value="dark" selected="selected">Dark</option>
										<option value="light">Light</option>
										<?php } else { ?>
										<option value="dark" >Dark</option>
										<option value="light" selected="selected">Light</option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_width"); ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][face_width]" value="<?php echo isset($module['face_width'])?$module['face_width']:220; ?>"/></td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_height"); ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][face_height]" value="<?php echo isset($module['face_height'])?$module['face_height']:220; ?>"/></td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_show_tream"); ?></td>
								<td class="col-sm-10">
									<select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][tream]">
									<?php foreach( $yesno as $k=>$v ){ ?>
										<option value="<?php echo $k;?>" <?php if(isset($module['tream']) && $k==$module['tream']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
									<?php } ?>
									</select>
								</td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_show_faces"); ?></td>
								<td class="col-sm-10">
									<select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][show_faces]">
									<?php foreach( $yesno as $k=>$v ){ ?>
										<option value="<?php echo $k;?>" <?php if(isset($module['show_faces']) && $k==$module['show_faces']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
									<?php } ?>
									</select>
								</td>
							</tr>
							<tr class="form-group">
								<td class="col-sm-2"><?php echo $objlang->get("entry_header"); ?></td>
								<td class="col-sm-10">
									<select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][header]">
										<?php foreach( $yesno as $k=>$v ){ ?>
										<option value="<?php echo $k;?>" <?php if(isset($module['header']) && $k==$module['header']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
						</table>
					</div>
					<div class="tab-pane" id="tab-<?php echo $module_row; ?>-Twitter">
						<table class="form">
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_widgetid; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][widget_id]" value="<?php echo isset($module['widget_id'])?$module['widget_id']:'366766896986591232'; ?>" size="35" /><br/><p><?php echo $entry_widget_help; ?></p></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_limit; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][count]" value="<?php echo isset($module['count'])?$module['count']:5; ?>" size="3" /><br/>
								<p><?php echo $entry_count_help; ?></p></td>
							</tr>
						<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_username; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][username]" value="<?php echo isset($module['username'])?$module['username']:"PavoThemes"; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_theme; ?></td>
								<td class="col-sm-10">
									<select name="pavsocial_module[<?php echo $module_row; ?>][theme]" class="form-control">
									<?php foreach($themes as $theme):?>
									<?php if(isset($module['theme']) && $module['theme'] == $theme):?>
									<option value="<?php echo $theme; ?>" selected="selected"><?php echo $theme; ?></option>
									<?php else: ?>
									<option value="<?php echo $theme; ?>"><?php echo $theme; ?></option>
									<?php endif;?>
									<?php endforeach; ?>
								</select>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_nickname_color; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" class="color" name="pavsocial_module[<?php echo $module_row; ?>][nickname_color]" value="<?php echo isset($module['nickname_color'])?$module['nickname_color']:'#000000'; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_name_color; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" class="color" name="pavsocial_module[<?php echo $module_row; ?>][name_color]" value="<?php echo isset($module['name_color'])?$module['name_color']:'#000000'; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_title_color; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" class="color" name="pavsocial_module[<?php echo $module_row; ?>][title_color]" value="<?php echo isset($module['title_color'])?$module['title_color']:'#000000'; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_linkcolor; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" class="color" name="pavsocial_module[<?php echo $module_row; ?>][link_color]" value="<?php echo isset($module['link_color'])?$module['link_color']:'#000000'; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_bordercolor; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" class="color" name="pavsocial_module[<?php echo $module_row; ?>][border_color]" value="<?php echo isset($module['border_color'])?$module['border_color']:'#000000'; ?>" size="35" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_width; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][width]" value="<?php echo isset($module['width'])?$module['width']:'220'; ?>" size="10" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_height; ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][height]" value="<?php echo isset($module['height'])?$module['height']:'220'; ?>" size="10" /></td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_showreply; ?></td>
								<td class="col-sm-10">
									<select name="pavsocial_module[<?php echo $module_row; ?>][show_replies]" class="form-control">
										<?php if (isset($module['show_replies']) && $module['show_replies']) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr class="form-group"> 
								<td class="col-sm-2"><?php echo $entry_chrome; ?></td>
								<td class="col-sm-10"><select class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][chrome][]" multiple="multiple">
								<?php foreach($chromes as $chrome):?>
								<?php if(isset($module['chrome']) && is_array($module['chrome']) && in_array($chrome, $module['chrome'])):?>
								<option value="<?php echo $chrome; ?>" selected="selected"><?php echo $chrome; ?></option>
								<?php else: ?>
								<option value="<?php echo $chrome; ?>"><?php echo $chrome; ?></option>
								<?php endif;?>
								<?php endforeach; ?>
								</select><br/><p><?php echo $entry_chrome_help; ?></p></td>
							</tr>
						</table>
					</div>
					<div class="tab-pane" id="tab-<?php echo $module_row; ?>-Youtube">
						<table class="form">
							<tr>
								<td class="col-sm-2"><?php echo $objlang->get("entry_video_ids"); ?></td>
								<td class="col-sm-10"><input class="form-control" name="pavsocial_module[<?php echo $module_row; ?>][youtube_video_ids]" value="<?php echo isset($module['youtube_video_ids'])?$module['youtube_video_ids']:''; ?>"/></td>
							</tr>
							<tr>
								<td class="col-sm-2"><?php echo $objlang->get("entry_video_width_height"); ?></td>
								<td class="col-sm-10"><input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][video_width]" value="<?php echo isset($module['video_width'])?$module['video_width']:'766'; ?>" size="15" /> X <input class="form-control" type="text" name="pavsocial_module[<?php echo $module_row; ?>][video_height]" value="<?php echo isset($module['video_height'])?$module['video_height']:'419'; ?>" size="15" /></td>
							</tr>
						</table>
					</div>
					<?php /*
					<div id="tab-social-<?php echo $module_row; ?>-Pinterest">
						<table class="form">
							<tr>
								<td class="col-sm-10"><?php echo $objlang->get("entry_pinterest_url"); ?></td>
								<td class="col-sm-10">
									<input size="60" type="text" value="<?php echo (isset($module['pinterest'])?$module['pinterest']:'' ) ?>" name="pavsocial_module[<?php echo $module_row; ?>][pinterest]" >
								</td>
							</tr>
						</table>
					</div>
					<div id="tab-social-<?php echo $module_row; ?>-Google">
						<table class="form">
							<tr>
								<td class="col-sm-10"><?php echo $objlang->get("entry_google_url"); ?></td>
								<td class="col-sm-10">
									<input size="60" type="text" value="<?php echo (isset($module['google'])?$module['google']:'' ) ?>" name="pavsocial_module[<?php echo $module_row; ?>][google]" >
								</td>
							</tr>
						</table>
					</div>
					*/?>
				</div>
			</div>
				<?php $module_row++; ?>
				<?php } ?>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$('.pavo-editor').summernote({
    height: 300
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