<?php echo $payu; ?> 
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="Siparişi Onaylıyorum" id="button-confirm" class="btn btn-outline">
  </div>
  <span id="payu-text"><i class="fa fa-lock"></i> <a href="https://www.payu.com.tr/payu-hakk%C4%B1nda" target="_blank">PayU</a></span> Güvenli Ödeme sayfasına yönlendirileceksiniz
</div>
<script>
  $('#button-confirm').click(function(e) {
    e.preventDefault();
    $('#payForm').submit();
  });
</script>