<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   <div id="pavtestimonial<?php echo $id;?>" class="carousel slide pavtestimonial hidden-sm hidden-xs">
		<div class="carousel-inner">
			 <?php foreach ($testimonials as $i => $testimonial) {  ?>
				<div class="item <?php if($i==0) {?>active<?php } ?>" data-slide-to="<?php echo $i; ?>">
	 				<div class="testimonial-item">
	 					<h1>testimonials</h1>	<br/>
	 					<div class="line-border"></div>
						<?php if(  $testimonial['description'] ) { ?>
						<div class="testimonial">
							<?php echo $testimonial['description']; ?>
						</div>
						<?php } ?>
						<?php if(  $testimonial['profile'] ) { ?>
						<div class="profile">
							<?php echo $testimonial['profile']; ?>
						</div>
						<?php } ?>
					</div>
				</div>
			<?php } ?>
		</div>
		<?php if( count($testimonials) > 1 ){ ?>
		<div id="slider-thumbs">
	    	<!-- thumb navigation carousel items -->
	    	
		    <ul class="list-inline">
		    	<li><a class="carousel-control" href="#pavtestimonial<?php echo $id;?>" data-slide="prev"><i class="fa fa-angle-left"></i></a></li>
		    	<?php foreach ($testimonials as $i => $testimonial) {  ?>
		        <li>
			         <a id="carousel-selector-<?php echo $i; ?>" class="<?php if($i==0) {?>selected<?php } ?>">
			        	<img src="<?php echo $testimonial['thumb']; ?>" alt="">
			      	</a>
		        </li>
		    	<?php } ?>
		    	<li><a class="carousel-control" href="#pavtestimonial<?php echo $id;?>" data-slide="next"><i class="fa fa-angle-right"></i></a></li>
		    </ul>
		</div>
	 	<?php } ?>	
    </div>
	<?php if( count($testimonials) > 1 ){ ?>
	<script type="text/javascript">
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});


		 $('[id^=carousel-selector-]').click( function(){
			 var id_selector = $(this).attr("id");
			 var id = id_selector.substr(id_selector.length -1);
			 id = parseInt(id);
			 $('#pavtestimonial<?php echo $id;?>').carousel(id);
			 $('[id^=carousel-selector-]').removeClass('selected');
			 $(this).addClass('selected');
		 });

		$('#pavtestimonial<?php echo $id;?>').on('slid.bs.carousel', function () {
		  var carouselData = $(this).data('bs.carousel');
		  var currentIndex = carouselData.getActiveIndex();
		  var total = carouselData.$items.length;
		  $('[id^=carousel-selector-]').removeClass('selected');
		  $('[id^=carousel-selector-'+currentIndex+']').addClass('selected');

		});

	</script>
	<?php } ?>
<?php } ?>

