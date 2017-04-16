<div class="box">
    <div class="box-heading hidden"><?php echo $objlang->get("entry_newsletter");?></div>
    <div class="box-content no-bg">
        <div class="<?php echo $prefix; ?> pav-newsletter  clearfix" id="newsletter_<?php echo $position.$module;?>">
            <form id="formNewLestter" method="post" action="<?php echo $action; ?>" class="formNewLestter">
                <span class="pull-left"></span>
                <div class="explain"><?php echo html_entity_decode( $description );?></div>
                <div class="clearfix input-group input-newsletter">
                    <div class="input-group">
                        <input type="text" class="form-control email input-inverse input-lg inputNew" <?php if(!isset($customer_email)): ?> onblur="javascript:if(this.value=='')this.value='<?php echo $objlang->get("default_input_text");?>';" onfocus="javascript:if(this.value=='<?php echo $objlang->get("default_input_text");?>')this.value='';"<?php endif; ?> value="<?php echo isset($customer_email)?$customer_email:$objlang->get("default_input_text");?>" size="18" name="email">
                        <span class="input-group-btn">
                            <button type="submit" name="submitNewsletter" class="btn btn-newsletter"><?php echo  $objlang->get("button_subscribe");?></button>
                        </span>
                    </div>
                    <input type="hidden" value="1" name="action">
                    <div class="valid"></div>
                </div>
            </form>

        </div>
        <?php if (!empty($social)): ?>
        <?php  echo html_entity_decode( $social );?>
        <?php endif ?>
    </div>
</div>
<script type="text/javascript"><!--
$( document ).ready(function() {
    var id = 'newsletter_<?php echo $position.$module;?>';
    $('#'+id+' .box-heading').bind('click', function(){
        $('#'+id).toggleClass('active');
    });

    $('#formNewLestter').on('submit', function() {
        var email = $('.inputNew').val();
        $(".success_inline, .warning_inline, .error").remove();
        if(!isValidEmailAddress(email)) {
            $('.valid').html("<div class=\"error alert alert-danger\"><?php echo $objlang->get('valid_email'); ?><button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div></div>");
            $('.inputNew').focus();
            return false;
        }
        var url = "<?php echo $action; ?>";
        $.ajax({
            type: "post",
            url: url,
            data: $("#formNewLestter").serialize(),
            dataType: 'json',
            success: function(json)
            {
                $(".success_inline, .warning_inline, .error").remove();
                if (json['error']) {
                    $('.valid').html("<div class=\"warning_inline alert alert-danger\">"+json['error']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
                }
                if (json['success']) {
                    $('.valid').html("<div class=\"success_inline alert alert-success\">"+json['success']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
                }
            }
        });
        return false;
    });
});

function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
}
--></script>