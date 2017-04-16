<div class="facebook footer-facebook col-md-4 col-sm-12 text-center">
    <div class="box-content">
        <div class="facebook-wrapper clearfix">
            <?php if(isset($application_id) && $application_id) { ?>
            <div id="fb-root"></div>
            <script>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/<?php echo $language_code ?>/all.js#xfbml=1&appId=<?php echo $application_id ?>";
                fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));
            </script>
            <?php } else {?>
            <script>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/<?php echo $language_code ?>/all.js#xfbml=1";
                           fjs.parentNode.insertBefore(js, fjs);
                           }(document, 'script', 'facebook-jssdk'));
            </script>
            <?php } ?>
            <div class="fb-like-box" data-href="<?php echo $page_url; ?>" data-colorscheme="<?php echo $colorscheme;?>" data-height="<?php echo $face_height; ?>" data-width="100%" data-show-faces="<?php echo ($show_faces ? 'true' : 'false'); ?>" data-stream="<?php echo ($tream ? 'true' : 'false'); ?>" data-show-border="<?php echo ( trim($border_color) ?'true':'false') ; ?>" data-header="<?php echo ($header ? 'true' : 'false'); ?>">Yukleniyor...</div>
        </div>
    </div>
</div>
<div class="twitter footer-twitter col-md-4 col-sm-12 text-center">
    <div class="box-content">
        <div id="pav-twitter">
            <a class="twitter-timeline" data-dnt="true" data-theme="<?php echo $theme; ?>" data-link-color="#<?php echo $link_color;?>" data-chrome="<?php echo $chrome; ?>" data-border-color="#<?php echo $border_color ?>" lang="<?php echo $language_code;?>" data-tweet-limit="<?php echo $count; ?>" data-show-replies="<?php echo $show_replies==1?'true':'false'; ?>" href="https://twitter.com/<?php echo $username; ?>"  data-widget-id="<?php echo $widget_id; ?>">Yukleniyor...</a>
        </div>
    </div>
</div>    
<div class="youtube footer-youtube col-md-4 col-sm-12 text-center">
    <div class="box-content">       
        <object width="100%" height="<?php echo $video_height; ?>" data="https://www.youtube.com/v/<?php echo trim($video_ids); ?>?version=3&amp;autoplay=0" type="application/x-shockwave-flash"> </object>
    </div>
</div>    
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
<script type="text/javascript">
    var hideTwitterAttempts = 0;
    function hideTwitterBoxElements() {
        setTimeout( function() {
            if ( $('[id*=pav-twitter]').length ) {
                $('#pav-twitter iframe').each( function(){
                    var ibody = $(this).contents().find( 'body' );
                    if ( ibody.find( '.timeline .stream .h-feed li.tweet' ).length ) {
                        ibody.find( '.header .p-nickname' ).css( 'color', '<?php echo $nickname_color; ?>' );
                        ibody.find( '.p-name' ).css( 'color', '<?php echo $name_color; ?>' );
                        ibody.find( '.e-entry-title' ).css( 'color', '<?php echo $title_color; ?>' );
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
    hideTwitterBoxElements();
</script>