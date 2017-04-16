 <div class="sidebar-offcanvas  visible-xs visible-sm">
      <div class="offcanvas-inner panel panel-offcanvas">
          <div class="offcanvas-heading">
              <button type="button" class="btn btn-outline btn-close " data-toggle="offcanvas"> <span class="fa fa-times"></span></button>
          </div>
          <div class="offcanvas-body panel-body">
               <?php echo $this->renderModule('category'); ?>
          </div>
          <div class="offcanvas-footer panel-footer">
              <div class="input-group" id="offcanvas-search">
                <input type="text" class="form-control" placeholder="Search" value="" name="search">
                <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                </span>
              </div>
          </div>
       </div> 
 </div>