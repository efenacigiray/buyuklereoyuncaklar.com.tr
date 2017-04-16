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
				<h1 class="logo">
					<?php echo $objlang->get("text_info_group_location"); ?>
					<?php if (isset($group_id) && !empty($group_id)): ?>ID: <?php echo $group_id; ?><?php endif ?>
				</h1>
			</div>
			<div class="toolbar"><?php require( dirname(__FILE__).'/action_bar.tpl' ); ?></div>

			<div class="content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<input name="action" type="hidden" id="action"/>
					<input name="group_id" type="hidden" value="<?php echo isset($group_id)?$group_id:0; ?>"/>
					<table class="table">
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_group_name');?></td>
							<td class="col-sm-10">
								<input name="group_name" value="<?php echo (isset($group_name))?$group_name:''; ?>" size="40"/>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_group_store');?></td>
							<td class="col-sm-10">
								<select name="group_store">
									<?php foreach ($stores as $store): ?>
									<?php $selected = (isset($group_store) && $group_store == $store['store_id'])?"selected='selected'":'' ?>
									<option <?php echo $selected;?> value="<?php echo $store['store_id'];?>"><?php echo $store['name']; ?></option>
									<?php endforeach ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_group_status');?></td>
							<td class="col-sm-10">
								<select name="group_status">
									<?php if (isset($group_status) && $group_status): ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php else: ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php endif; ?>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

