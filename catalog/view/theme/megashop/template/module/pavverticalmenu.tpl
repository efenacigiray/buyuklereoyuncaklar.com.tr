<?php $objlang = $this->registry->get('language');?>
<div id="pav-verticalmenu" class="pav-verticalmenu hasicon box box-highlighted hidden-xs">
	<div class="box-heading bg-transparent">
		<span>Kategoriler</span>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	if (typeof $('#category-dropdown-list')[0] == 'undefined' ) {
		$('#category-dropdown-list-backup').detach().appendTo('#pav-verticalmenu');
		$('#pav-verticalmenu').hover(
			function() {
				$('#category-dropdown-list-backup').removeClass('hidden');
			}, 
			function() {
				$('#category-dropdown-list-backup').addClass('hidden');
			}
		);
	}
});
</script>