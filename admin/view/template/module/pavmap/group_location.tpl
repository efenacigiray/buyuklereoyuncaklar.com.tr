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
			<div class="logo"><h1><?php echo $objlang->get('left_title'); ?> </h1></div>
			<div class="slidebar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
			<div class="clear clr"></div>
		</div>
		<div class="col-md-10">
			<div class="heading">
				<h1 class="logo"><?php echo $objlang->get("text_group_location"); ?></h1>
			</div>
			<div class="toolbar"><?php require( dirname(__FILE__).'/action_bar.tpl' ); ?></div>

			<div class="content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<input name="action" type="hidden" id="action"/>

					<table class="table table-bordered table-hover">

						<thead>
						<tr>
							<td class="left"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></td>
							<td class="left"><?php if ($sort == 'name') { ?>
								<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
								<?php } ?>
							</td>
							<td class="left"><?php echo $column_store; ?></td>
							<td class="left"><?php echo $column_status; ?></td>
							<td class="right"><?php echo $column_action; ?></td>
						</tr>
						</thead>
						<tbody>
							<tr class="filter">
								<td>&nbsp;</td>
								<td class="left"><input size="40" type="text" name="filter_name" value="<?php echo $filter_name; ?>" class="form-control" style="width:55%;"/></td>
								<td align="left">
									<select name="filter_store" class="form-control" style="width:75%;">
										<?php if ($filter_store =="") { ?>
										<option value="" selected="selected"></option>
										<?php } else { ?>
										<option value=""></option>
										<?php } ?>
										<?php foreach ($stores as $store):?>
										<?php $slected = ($store['store_id'] == $filter_store)?"selected='selected'":''; ?>
										<option <?php echo $slected; ?> value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
										<?php endforeach ?>
									</select>
								</td>
								<td align="left">
									<select name="filter_status" id="input-status" class="form-control">
					                  <option value="*"></option>
					                  <?php if ($filter_status) { ?>
					                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					                  <?php } else { ?>
					                  <option value="1"><?php echo $text_enabled; ?></option>
					                  <?php } ?>
					                  <?php if (($filter_status !== null) && !$filter_status) { ?>
					                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					                  <?php } else { ?>
					                  <option value="0"><?php echo $text_disabled; ?></option>
					                  <?php } ?>
					                </select>
								</td>
								<td align="right"><a onclick="filter();" class="btn btn-primary pull-right"><?php echo $button_filter; ?></a></td>
							</tr>
							<?php if ($groups) { ?>
							<?php foreach ($groups as $group) {?>
							<tr>
								<td><input type="checkbox" value="<?php echo $group['group_location_id'] ?>" name="selected[]"></td>
								<td class="left"><?php echo $group['name']; ?></td>
								<td class="left"><?php echo $group['store_id']; ?></td>
								<td class="left"><?php echo ($group['status'])?$text_enabled:$text_disabled; ?></td>
								<td class="right">[ <a href="<?php echo $group['action']; ?>"><?php echo $action_edit; ?></a> ]</td>
							</tr>
							<?php } ?>
							<?php } else { ?>
							<tr>
								<td class="center" colspan="7"><?php echo $text_no_results; ?></td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</form>
				<div class="row">
		          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
		          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
		        </div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript"><!--
function filter() {
  url = 'index.php?route=module/pavmap/grouplocation&token=<?php echo $token; ?>';

  var filter_name = $('input[name=\'filter_name\']').val();

  if (filter_name) {
    url += '&filter_name=' + encodeURIComponent(filter_name);
  }

  var filter_status = $('select[name=\'filter_status\']').val();

  if (filter_status != '*') {
    url += '&filter_status=' + encodeURIComponent(filter_status);
  }

  var filter_store = $('select[name=\'filter_store\']').val();

  if (filter_store != '') {
    url += '&filter_store=' + encodeURIComponent(filter_store);
  }


  location = url;
}
//--></script>
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
  if (e.keyCode == 13) {
    filter();
  }
});
//--></script>