<div class="<?php echo $additional_class; ?> search_block">
    <form method="GET" action="index.php" class="input-group search-box">
	<?php if(!empty($categories)) { ?>
	<div class="filter_type category_filter input-group-addon group-addon-select icon-select">
		<select name="category_id" class="no-border">
			<option value="0"><?php echo $objlang->get("text_category_all"); ?></option>
			<?php foreach ($categories as $category_1) { ?>
	        <?php if ($category_1['category_id'] == $category_id) { ?>
	        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
	        <?php } else { ?>
	        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
	        <?php } ?>
	        <?php foreach ($category_1['children'] as $category_2) { ?>
	        <?php if ($category_2['category_id'] == $category_id) { ?>
	        <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
	        <?php } else { ?>
	        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
	        <?php } ?>
	        <?php foreach ($category_2['children'] as $category_3) { ?>
	        <?php if ($category_3['category_id'] == $category_id) { ?>
	        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
	        <?php } else { ?>
	        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
	        <?php } ?>
	        <?php } ?>
	        <?php } ?>
	        <?php } ?>
		</select>
	</div>
	<?php } ?>
	<div id="search<?php echo $module ?>" class="search-input-wrapper clearfix clearfixs input-group">
	    <input type="text" value="" size="35" autocomplete="off" placeholder="<?php echo $objlang->get("text_search");?>" name="search" class="form-control input-lg input-search">
        <span class="input-group-addon input-group-search">
	        <button class="fa fa-search"></button>
	        <button class="button-search ">
	            <?php echo $objlang->get("text_search");?>
	        </button>
        </span>
	</div>
	<input type="hidden" name="sub_category" value="1" class="sub_category"/>
	<input type="hidden" name="route" value="product/search"/>
	<input type="hidden" name="sub_category" value="true" class="sub_category"/>
	<input type="hidden" name="description" value="true" id="description"/>
	</form>
	<div class="clear clr"></div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	var selector = '#search<?php echo $module ?>';
	var total = 0;
	var show_image = <?php echo ($show_image==1)?'true':'false';?>;
	var show_price = <?php echo ($show_price==1)?'true':'false';?>;
	var search_sub_category = true;
	var search_description = true;
	var width = 102;
	var height = 102;

	$(selector).find('input[name=\'search\']').autocomplete1({
		delay: 500,
		source: function(request, response) {
			var category_id = $(".category_filter select[name=\"category_id\"]").first().val();
			if(typeof(category_id) == 'undefined')
				category_id = 0;
			var limit = <?php echo $limit;?>;
			var search_sub_category = search_sub_category?'&sub_category=true':'';
			var search_description = search_description?'&description=true':'';
			$.ajax({
				url: 'index.php?route=module/pavautosearch/autocomplete&filter_category_id='+category_id+'&width='+width+'&height='+height+'&limit='+limit+search_sub_category+search_description+'&filter_name='+encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						if($('.pavautosearch_result')){
							$('.pavautosearch_result').first().html("");
						}
						total = 0;
						if(item.total){
							total = item.total;
						}
						return {
							price:   item.price,
							speical: item.special,
							tax:     item.tax,
							label:   item.name,
							image:   item.image,
							link:    item.link,
							value:   item.product_id,
							sprice:  show_price,
							simage:  show_image,
						}
					}));
				}
			});
		},
	}); // End Autocomplete 

});// End document.ready

</script>