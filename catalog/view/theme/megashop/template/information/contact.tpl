<?php echo $header; ?>
<?php  $config = $this->registry->get('config');   $themeConfig = (array)$config->get('themecontrol') ?>
<div class="container">
	<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
	<?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>
	<div class="row"><?php if( $SPAN[0] ): ?>
		<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
			<?php echo $column_left; ?>
		</aside>	
	<?php endif; ?>
	<section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content" class="wrapper clearfix"><?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
		<div class="contact-location hidden-xs">
			<div id="contact-map"></div>
		</div>
		<?php if ($locations) { ?>
			<h3><?php echo $text_store; ?></h3>
			<div class="panel-group" id="accordion">
				<?php foreach ($locations as $location) { ?>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title"><a href="#collapse-location<?php echo $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $location['name']; ?> <i class="fa fa-caret-down"></i></a></h4>
						</div>
						<div class="panel-collapse collapse in" id="collapse-location<?php echo $location['location_id']; ?>">
							<div class="panel-body">
								<div class="row">
									<?php if ($location['image']) { ?>
										<div class="col-sm-3"><img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>" class="img-thumbnail" /></div>
										<?php } ?>
										<div class="col-sm-3"><strong><?php echo $location['name']; ?></strong><br />
											<address>
												<?php echo $location['address']; ?>
											</address>
											<?php if ($location['geocode']) { ?>
												<a href="https://maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=<?php echo $geocode_hl; ?>&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
												<?php } ?>
											</div>
											<div class="col-sm-3"> <strong><?php echo $text_telephone; ?></strong><br>
												<?php echo $location['telephone']; ?><br />
												<br />
												<?php if ($location['fax']) { ?>
													<strong><?php echo $text_fax; ?></strong><br>
													<?php echo $location['fax']; ?>
													<?php } ?>
												</div>
												<div class="col-sm-3">
													<?php if ($location['open']) { ?>
														<strong><?php echo $text_open; ?></strong><br />
														<?php echo $location['open']; ?><br />
														<br />
														<?php } ?>
														<?php if ($location['comment']) { ?>
															<strong><?php echo $text_comment; ?></strong><br />
															<?php echo $location['comment']; ?>
															<?php } ?>
														</div>
													</div>
												</div>
											</div>
										</div>
										<?php } ?>
									</div>
									<?php } ?>
									<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal ">
										<div class="row contact-content">
											<?php
											$html = html_entity_decode($themeConfig['contact_customhtml'][$config->get('config_language_id')]);
											$c = 0;
											$c2 = 8;
											?>
											<fieldset class="col-md-4">
												<div class="contact-info">
												<h3><?php echo $heading_title; ?></h3>
												<div class="content">
													<div class="media">
														<i class="fa fa-home pull-left"></i>
														<div class="media-body">
															<?php echo $text_address; ?>
															<?php echo $store; ?><br> <?php echo $address; ?>
														</div>
													</div>
													<?php if ($telephone) { ?>
														<div class="media">
															<i class="fa fa-phone pull-left"></i>
															<div class="media-body">
																<?php echo $text_telephone; ?><br>
																<?php echo $telephone; ?>
															</div>
														</div>
														<?php } ?>
														<?php if ($fax) { ?>
															<div class="media">
																<i class="fa fa-envelope-o pull-left"></i>
																<div class="media-body">
																	<?php echo $text_fax; ?><br>
																	<?php echo $fax; ?>
																</div>
															</div>
															<?php } ?>
													</div>
													</div>
													<div class="contact-customhtml">
														<div class="content">
															<?php echo html_entity_decode($themeConfig['contact_customhtml'][$config->get('config_language_id')]); ?>
														</div>
													</div>
												</fieldset>
													<fieldset class="col-md-8">
														<h3><?php echo $text_contact; ?></h3>
														<div class="form-group required">
															<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
															<div class="col-sm-10">
																<input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
																<?php if ($error_name) { ?>
																	<div class="text-danger"><?php echo $error_name; ?></div>
																	<?php } ?>
																</div>
															</div>
															<div class="form-group required">
																<label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
																<div class="col-sm-10">
																	<input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
																	<?php if ($error_email) { ?>
																		<div class="text-danger"><?php echo $error_email; ?></div>
																		<?php } ?>
																	</div>
																</div>
																<div class="form-group required">
																	<label class="col-sm-2 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
																	<div class="col-sm-10">
																		<textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
																		<?php if ($error_enquiry) { ?>
																			<div class="text-danger"><?php echo $error_enquiry; ?></div>
																			<?php } ?>
																		</div>
																	</div>

																	<?php echo $captcha; ?>
																	<div class="buttons">
																		<div class="pull-right">
																			<input class="btn btn-outline" type="submit" value="<?php echo $button_submit; ?>" />
																		</div>
																	</div>
																</fieldset>
															</div>

														</form>
														<?php echo $content_bottom; ?></div>
													</section> 
													<?php if( $SPAN[2] ): ?>
														<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
															<?php echo $column_right; ?>
														</aside>
													<?php endif; ?></div>
												</div>
												<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false&amp;language=en"></script>
												<script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.min.js"></script>
												<script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.infobox.js"></script>
												<script type="text/javascript">
													var mapDiv, map, infobox;
													var lat = <?php echo isset($themeConfig['location_latitude'])?$themeConfig['location_latitude']:'40.705423'; ?>;
													var lon = <?php echo isset($themeConfig['location_longitude'])?$themeConfig['location_longitude']:'-74.008616'; ?>;
													jQuery(document).ready(function($) {
														mapDiv = $("#contact-map");
														mapDiv.height(400).gmap3({
															map:{
																options:{
																	center:[lat,lon],
																	zoom: 15
																}
															},
															marker:{
																values:[
																{latLng:[lat, lon], data:"<?php echo isset($themeConfig['location_address'])?$themeConfig['location_address']:'79-99 Beaver Street, New York, NY 10005, USA'; ?>"},
																],
																options:{
																	draggable: false
																},
																events:{
																	mouseover: function(marker, event, context){
																		var map = $(this).gmap3("get"),
																		infowindow = $(this).gmap3({get:{name:"infowindow"}});
																		if (infowindow){
																			infowindow.open(map, marker);
																			infowindow.setContent(context.data);
																		} else {
																			$(this).gmap3({
																				infowindow:{
																					anchor:marker, 
																					options:{content: context.data}
																				}
																			});
																		}
																	},
																	mouseout: function(){
																		var infowindow = $(this).gmap3({get:{name:"infowindow"}});
																		if (infowindow){
																			infowindow.close();
																		}
																	}
																}
															}
														});
													});
													$(document).ready(function () {
														$('#collapse-location1').click();
													});
												</script>
												<?php //end contact map ?>
												<?php echo $footer; ?>
