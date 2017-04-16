<?php $id = rand(1,time()) . "accordion"; ?>
<?php $target = rand(1,time()) . "target"; ?>

<div class="category box box-highlights theme hidden-xs hidden-sm">
    <div class="box-content tree-menu">
        <ul id="<?php echo $id; ?>" class="box-category box-panel">
            <?php foreach ($categories as $key => $category) { ?>
            <li class="accordion-group clearfix">
                <?php if ($category['category_id'] == $category_id) { ?>
                <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
                <?php } else { ?>
                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                <?php } ?>
                <?php if ($category['children']) { ?>
                <div class="accordion-heading pull-right">
                    <span data-toggle="collapse" data-parent="#<?php echo $id; ?>" data-target="#<?php echo $target.$key ;?>" class="badge">+</span>
                </div>
                <ul id="<?php echo $target.$key ;?>" class="collapse accordion-body <?php if($category['category_id'] == $category_id) echo "in"; ?>">
                <?php foreach ($category['children'] as $child) { ?>
                    <li class="sub-menu">
                        <?php if ($child['category_id'] == $child_id) { ?>
                        <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                        <?php } ?>
                    </li>
            <?php } ?>
        </ul>
        <?php } ?>
        </li>
        <?php } ?>
        </ul>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        var active = $('.collapse.in').attr('id');
        $('span[data-target=#'+active+']').html("-");

        $('.collapse').on('show.bs.collapse', function () {
            $('span[data-target=#'+$(this).attr('id')+']').html("-");
        });
        $('.collapse').on('hide.bs.collapse', function () {
            $('span[data-target=#'+$(this).attr('id')+']').html("+");
        });
    });
</script>

