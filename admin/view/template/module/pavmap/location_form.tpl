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
					<?php echo $objlang->get("text_info_location"); ?>
					<?php if (isset($location_id) && !empty($location_id)): ?>ID: <?php echo $location_id; ?><?php endif ?>
				</h1>
			</div>
			<div class="toolbar"><?php require( dirname(__FILE__).'/action_bar.tpl' ); ?></div>
			<div class="content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<input style="width:55%" name="action" type="hidden" id="action"/>
					<input style="width:55%" name="location_id" type="hidden" value="<?php echo isset($location_id)?$location_id:0; ?>"/>

					<ul class="nav nav-tabs" id="language">
                    	<?php foreach ($languages as $language) { ?>
	                    <li><a href="#tab-module-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
	                    <?php } ?>
	                </ul>
	                <div class="tab-content">
					<?php foreach ($languages as $language) { ?>
					<div class="tab-pane" id="tab-module-language<?php echo $language['language_id']; ?>">
						<table class="table">
							<tr>
								<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_title');?></td>
								<td class="col-sm-10">
									<input style="width:55%" name="location_title[<?php echo $language['language_id'];?>]" value="<?php echo isset($title[$language['language_id']])?$title[$language['language_id']]:''; ?>" size="60"/>
								</td>
							</tr>
							<tr>
								<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_content');?></td>
								<td class="col-sm-10"><textarea class="pavo-editor" name="location_content[<?php echo $language['language_id']; ?>]"><?php echo isset($content[$language['language_id']])?$content[$language['language_id']]:'';?></textarea></td>
							</tr>
						</table>
					</div>
					<?php } ?>
					<table class="table">
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_location_link');?></td>
							<td class="col-sm-10">
								<input style="width:55%" name="location_link" value="<?php echo isset($location_link)?$location_link:''; ?>" size="60"/>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_group_location_name');?></td>
							<td class="col-sm-10">
								<select name="location_group">
									<?php if (isset($groups)): ?>
									<?php foreach ($groups as $group): ?>
									<?php $selected = ($group['group_location_id'] == $location_group)?"selected='selected'":''; ?>
									<option <?php echo $selected; ?> value="<?php echo $group['group_location_id']; ?>"><?php echo $group['name']; ?></option>
									<?php endforeach ?>
									<?php else: ?>
									<option value="0">&nbsp;</option>
									<?php endif ?>
								</select>
							</td>
						</tr>

						<tr>
							<td class="col-sm-2"><?php echo $objlang->get('entry_googlemap');?><span class="help"><?php echo $objlang->get('help_google_map'); ?></span></td>
							<td class="col-sm-10">
								<div id="mapCanvas" style="width: 800px;height: 350px;float: left;"></div>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_location_name');?><span class="help"><?php echo $help_location_address; ?></span></td>
							<td class="col-sm-10"><input style="width:55%" id="searchTextField" name="location_address" type="text" value="<?php echo isset($location_address)?$location_address:''; ?>" placeholder="<?php echo $text_location_address; ?>" autocomplete="on" runat="server" size="60"/></td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_latitude');?></td>
							<td class="col-sm-10">
								<input style="width:55%" id="location_latitude" name="location_latitude" value="<?php echo (isset($latitude) && !empty($latitude))?$latitude:'40.705423'; ?>" size="30"/>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_longitude');?></td>
							<td class="col-sm-10">
								<input style="width:55%" id="location_longitude" name="location_longitude" value="<?php echo (isset($longitude) && !empty($longitude))?$longitude:'-74.008616'; ?>" size="30"/>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_image'); ?></td>
							<td class="col-sm-10">
								<div class="image">
									<a href="" id="thumb-image0" data-toggle="image" class="img-thumbnail">
				                    <img src="<?php echo isset($thumb) ? $thumb : $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
				                    <input type="hidden" name="location_image" value="<?php echo $image; ?>" id="input-image0" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"><span class="required">* </span><?php echo $objlang->get('entry_icon'); ?></td>
							<td class="col-sm-10">
								<div class="image">
									<a href="" id="thumb-image1" data-toggle="image" class="img-thumbnail">
				                    <img src="<?php echo isset($thumb_icon) ? $thumb_icon : $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
				                    <input type="hidden" name="location_icon" value="<?php echo $icon; ?>" id="input-image1" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"></span><?php echo $objlang->get('entry_status');?></td>
							<td class="col-sm-10">
								<select name="location_status">
									<?php if (isset($status) && $status): ?>
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
				</div>
				</form>
			</div>
		</div>
	</div>
</div>

 <script type="text/javascript"><!--
$('#module li:first-child a').tab('show');
$('#language li:first-child a').tab('show');
//--></script>
<script type="text/javascript"><!--
$('.pavo-editor').summernote({
    height: 300
  });
//--></script>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places" type="text/javascript"></script>
<script type="text/javascript">
	function initialize() {
		var input = document.getElementById('searchTextField');
		var autocomplete = new google.maps.places.Autocomplete(input);
		google.maps.event.addListener(autocomplete, 'place_changed', function () {
			var place = autocomplete.getPlace();

			var lat = place.geometry.location.lat();
			var lon = place.geometry.location.lng();

			document.getElementById('location_latitude').value = lat;
			document.getElementById('location_longitude').value = lon;

			var latLng = new google.maps.LatLng(lat, lon);
			var map = new google.maps.Map(document.getElementById('mapCanvas'), {
				zoom: 15,
				center: latLng,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
			var marker = new google.maps.Marker({
				position: latLng,
				title: 'Point A',
				map: map,
				draggable: true
			});
			// Update current position info.
			geocodePosition(latLng);

			// Add dragging event listeners.
			google.maps.event.addListener(marker, 'dragstart', function() {
				updateMarkerAddress('Dragging...');
			});

			google.maps.event.addListener(marker, 'drag', function() {
				updateMarkerPosition(marker.getPosition());
			});

			google.maps.event.addListener(marker, 'dragend', function() {
				geocodePosition(marker.getPosition());
			});
		});
	}
    google.maps.event.addDomListener(window, 'load', initialize);
</script>

<script type="text/javascript">
	var geocoder = new google.maps.Geocoder();

	function geocodePosition(pos) {
		geocoder.geocode({
			latLng: pos
		}, function(responses) {
			if (responses && responses.length > 0) {
				updateMarkerAddress(responses[0].formatted_address);
			} else {
				updateMarkerAddress('Cannot determine address at this location.');
			}
		});
	}

	function updateMarkerPosition(latLng) {
		document.getElementById('location_latitude').value = latLng.lat();
		document.getElementById('location_longitude').value = latLng.lng();
	}

	function updateMarkerAddress(str) {
		document.getElementById('searchTextField').value = str;
	}

	function initialize() {

		var lat = <?php echo (isset($latitude) && !empty($latitude))?$latitude:'40.705423'; ?>;
		var lon = <?php echo (isset($longitude) && !empty($longitude))?$longitude:'-74.008616'; ?>;

		var latLng = new google.maps.LatLng(lat, lon);
		var map = new google.maps.Map(document.getElementById('mapCanvas'), {
			zoom: 15,
			center: latLng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
		var marker = new google.maps.Marker({
			position: latLng,
			title: 'Point A',
			map: map,
			draggable: true
		});

		// Update current position info.
		geocodePosition(latLng);

		// Add dragging event listeners.
		google.maps.event.addListener(marker, 'dragstart', function() {
			updateMarkerAddress('Dragging...');
		});

		google.maps.event.addListener(marker, 'drag', function() {
			updateMarkerPosition(marker.getPosition());
		});

		google.maps.event.addListener(marker, 'dragend', function() {
			geocodePosition(marker.getPosition());
		});
	}
	// Onload handler to fire off the app.
	google.maps.event.addDomListener(window, 'load', initialize);
</script>