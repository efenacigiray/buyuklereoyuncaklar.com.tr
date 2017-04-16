<?php
	$sconfig = $this->registry->get('config');
	$language_code = $sconfig->get('config_language');
	$config  = $sconfig->get('themecontrol');

	$default = array(
		'facebook'    => "pavothemes",
		'youtube'     => "Wdtw_A5FDGs",
		'google'      => "103343417831594763276",

		't_widgetid'  => "366766896986591232",
		't_username'  => "pavothemes",
		't_name'      => "000000",
		't_title'     => "000000",
		't_link'      => "000000",
		't_border'    => "000000",
		
	);
	$config = array_merge($default, $config);
?>
<style type="text/css">
.socials-theme .list-socials li.google {top: 346px;}
.socials-theme .list-socials li.feedback {top: 20px;}
</style>


<ul class="list-socials">
	<li class="facebook">
		<div class="media">
			<div class="icon-facebook">
				<span class="fa fa-facebook"></span>
			</div>
			<div class="media-body">
				<span>facebook</span>
			</div>
		</div>
		<div class="box-content">
			<div class="facebook-wrapper clearfix" style="width:270px">
				<div id="fb-root"></div>
				<script>(function(d, s, id) {
				  var js, fjs = d.getElementsByTagName(s)[0];
				  if (d.getElementById(id)) return;
				  js = d.createElement(s); js.id = id;
				  js.src = "//connect.facebook.net/<?php echo $language_code ?>/sdk.js#xfbml=1&version=v2.4";
				  fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'));</script>
				<div class="fb-page" data-href="https://www.facebook.com/<?php echo $config['facebook']; ?>" data-width="270" data-height="355" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="true"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/<?php echo $config['facebook']; ?>"><a href="https://www.facebook.com/<?php echo $config['facebook']; ?>"><?php echo $config['facebook']; ?></a></blockquote></div></div>
			</div>
		</div>
	</li>
	<!-- twitter -->

	<li class="twitter">
		<div class="media">
			<div class="icon-twitter">
				<span class="fa fa-twitter"></span>
			</div>
			<div class="media-body">
				<span>twitter</span>
			</div>
		</div>

		<div class="box-content">
			<div id="pav-twitter" style="width:270px">
				<a class="twitter-timeline" data-dnt="true" lang="<?php echo $language_code;?>" data-chrome="noheader nofooter noborders transparent" data-theme="light" data-tweet-limit="5" data-show-replies="true" data-link-color="#<?php echo $config['t_link']; ?>" data-border-color="#<?php echo $config['t_border']; ?>" href="https://twitter.com/<?php echo $config['t_username']; ?>" data-widget-id="<?php echo $config['t_widgetid']; ?>">Tweets by @<?php echo $config['t_username'];?></a>

				<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
			</div>
		</div>
	</li>


</ul>
<script type="text/javascript">

$(document).ready(function() {

	//<!-- dont remove class alert of bootstrap -->
	$('#feedback-form').on('submit', function() {
		$(".alert").remove();
		$.ajax({
			type: "post",
			url: "index.php?route=themecontrol/feedback",
			data: $("#feedback-form").serialize(),
			dataType: 'json',
			success: function(json)
			{
				$(".alert").remove();

				if (json['error']) {
					$('.valid').html("<div class=\"alert alert-warning\">"+json['error']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
				if (json['success']) {
					$('.valid').html("<div class=\"alert alert-success\">"+json['success']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
			}
		});
		return false;
	});
});
</script>
<script type="text/javascript">
// Customize twitter feed
var hideTwitterAttempts = 0;
function hideTwitterBoxElements() {
	setTimeout( function() {
		if ( $('[id*=pav-twitter]').length ) {
			$('#pav-twitter iframe').each( function(){
				var ibody = $(this).contents().find( 'body' );
				if ( ibody.find( '.timeline .stream .h-feed li.tweet' ).length ) {
					ibody.find( '.header .p-nickname' ).css( 'color', '<?php echo $config["t_name"]; ?>' );
					ibody.find( '.p-name' ).css( 'color', '<?php echo $config["t_name"]; ?>' );
					ibody.find( '.e-entry-title' ).css( 'color', '<?php echo $config["t_title"]; ?>' );
				} else {
					$(this).hide();
				}
			});
		}
		hideTwitterAttempts++;
		if ( hideTwitterAttempts < 3 ) {
			hideTwitterBoxElements();
		}
	}, 1500);
}
// somewhere in your code after html page load
hideTwitterBoxElements();
</script>