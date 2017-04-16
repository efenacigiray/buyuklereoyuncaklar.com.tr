<?php
class ControllerModulePavcategorytabs extends Controller {

	private $mdata = array();
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/pavcategorytabs');
		$this->load->model('setting/setting');
		$this->load->model('tool/image');
		$this->load->model('design/layout');
		$this->load->model('localisation/language');
		$this->load->model('catalog/category');
		$this->load->model('extension/extension');
		$this->load->model('extension/module');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->session->data['success'] = $this->language->get('text_success');
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavcategorytabs', $this->request->post['pavcategorytabs_module']);
				$this->response->redirect( $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'], 'SSL') );
			} else {

				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post['pavcategorytabs_module']);
				$this->response->redirect( $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL') );
			}
		}

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;

		// Get Entry Language
		$this->_entryLanguage();

		// Get message
		$this->_message();

		// Get Breadcrumbs
		$this->_breadcrumbs();
		
		// Get Tab Language
		$this->mdata['languages'] = $this->model_localisation_language->getLanguages();
	
		// Get Stores
		$this->mdata['stores'] = $this->_getStores();
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		$this->mdata['store_id'] = $store_id;

		// Get Category SelectBox
		$this->_getCategories();
		
	 	// Data
	 	$this->_dataModule();


		// Set template
		$template = 'module/pavcategorytabs.tpl';

		// Render
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($template, $this->mdata));
	}

	public function _dataModule(){
		// Module ID
		if (isset($this->request->get['module_id'])) {
			$module_id = $this->request->get['module_id'];
			$url = '&module_id='.$module_id;
		} else {
			$module_id = '';
			$url = '';
		}
		$this->mdata['module_id'] = $module_id;

		// action
		$this->mdata['delete'] = $this->url->link('module/pavcategorytabs/ndelete', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->mdata['action'] = $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'].$url, 'SSL');

		$this->mdata['extensions'] = $this->module("pavcategorytabs");

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$this->mdata['module'] = array();
		// status
		if (isset($this->request->post['pavcategorytabs']['status'])) {
			$this->mdata['module']['status'] = $this->request->post['pavcategorytabs']['status'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['status'] = $module_info['status'];
		} else {
			$this->mdata['module']['status'] = 1;
		}
		// name
		if (isset($this->request->post['pavcategorytabs']['name'])) {
			$this->mdata['module']['name'] = $this->request->post['pavcategorytabs']['name'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['name'] = $module_info['name'];
		} else {
			$this->mdata['module']['name'] = '';
		}
		// description
		if (isset($this->request->post['pavcategorytabs']['description'])) {
			$this->mdata['module']['description'] = $this->request->post['pavcategorytabs']['description'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['description'] = $module_info['description'];
		} else {
			$this->mdata['module']['description'] = '';
		}
		//prefix_class
		if (isset($this->request->post['pavcategorytabs']['prefix_class'])) {
			$this->mdata['module']['prefix_class'] = $this->request->post['pavcategorytabs']['prefix_class'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['prefix_class'] = $module_info['prefix_class'];
		} else {
			$this->mdata['module']['prefix_class'] = '';
		}
		//category_id
		if (isset($this->request->post['pavcategorytabs']['category_id'])) {
			$this->mdata['module']['category_id'] = $this->request->post['pavcategorytabs']['category_id'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['category_id'] = $module_info['category_id'];
		} else {
			$this->mdata['module']['category_id'] = '';
		}
		//image
		if (isset($this->request->post['pavcategorytabs']['image'])) {
			$this->mdata['module']['image'] = $this->request->post['pavcategorytabs']['image'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['image'] = $module_info['image'];
			$this->mdata['module']['thumb'] = $this->model_tool_image->resize($module_info['image'], 50, 50);
		} else {
			$this->mdata['module']['image'] = '';
		}
		//iwidth
		if (isset($this->request->post['pavcategorytabs']['iwidth'])) {
			$this->mdata['module']['iwidth'] = $this->request->post['pavcategorytabs']['iwidth'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['iwidth'] = $module_info['iwidth'];
		} else {
			$this->mdata['module']['iwidth'] = 50;
		}
		//iheight
		if (isset($this->request->post['pavcategorytabs']['iheight'])) {
			$this->mdata['module']['iheight'] = $this->request->post['pavcategorytabs']['iheight'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['iheight'] = $module_info['iheight'];
		} else {
			$this->mdata['module']['iheight'] = 50;
		}
		//limit_tabs
		if (isset($this->request->post['pavcategorytabs']['limit_tabs'])) {
			$this->mdata['module']['limit_tabs'] = $this->request->post['pavcategorytabs']['limit_tabs'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['limit_tabs'] = $module_info['limit_tabs'];
		} else {
			$this->mdata['module']['limit_tabs'] = 4;
		}
		//status_nav
		if (isset($this->request->post['pavcategorytabs']['status_nav'])) {
			$this->mdata['module']['status_nav'] = $this->request->post['pavcategorytabs']['status_nav'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['status_nav'] = $module_info['status_nav'];
		} else {
			$this->mdata['module']['status_nav'] = 1;
		}
		// width
		if (isset($this->request->post['pavcategorytabs']['width'])) {
			$this->mdata['module']['width'] = $this->request->post['pavcategorytabs']['width'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['width'] = $module_info['width'];
		} else {
			$this->mdata['module']['width'] = 300;
		}
		// height
		if (isset($this->request->post['pavcategorytabs']['height'])) {
			$this->mdata['module']['height'] = $this->request->post['pavcategorytabs']['height'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['height'] = $module_info['height'];
		} else {
			$this->mdata['module']['height'] = 300;
		}
		// itemsperpage
		if (isset($this->request->post['pavcategorytabs']['itemsperpage'])) {
			$this->mdata['module']['itemsperpage'] = $this->request->post['pavcategorytabs']['itemsperpage'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['itemsperpage'] = $module_info['itemsperpage'];
		} else {
			$this->mdata['module']['itemsperpage'] = 4;
		}
		// cols
		if (isset($this->request->post['pavcategorytabs']['cols'])) {
			$this->mdata['module']['cols'] = $this->request->post['pavcategorytabs']['cols'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['cols'] = $module_info['cols'];
		} else {
			$this->mdata['module']['cols'] = 4;
		}
		//limit
		if (isset($this->request->post['pavcategorytabs']['limit'])) {
			$this->mdata['module']['limit'] = $this->request->post['pavcategorytabs']['limit'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['limit'] = $module_info['limit'];
		} else {
			$this->mdata['module']['limit'] = 4;
		}
	}

	public function ndelete(){
		$this->load->model('extension/module');
		$this->load->language('module/pavcategorytabs');
		if (isset($this->request->get['module_id'])) {
			$this->model_extension_module->deleteModule($this->request->get['module_id']);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function module($extension){
		$module_data = array();
		$this->load->model('extension/extension');
		$this->load->model('extension/module');
		$extensions = $this->model_extension_extension->getInstalled('module');
		$modules = $this->model_extension_module->getModulesByCode($extension);
		foreach ($modules as $module) {
			$module_data[] = array(
				'module_id' => $module['module_id'],
				'name'      => $module['name'],
				'edit'      => $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], 'SSL'),
			);
		}
		$ex[] = array(
			'name'      => $this->language->get("create_module"),
			'module'    => $module_data,
			'edit'      => $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'], 'SSL')
		);
		return $ex;
	}

	public function _d($var){
		echo "<pre>"; print_r($var); die;
	}
	
	public function _getCategories(){
		if( VERSION == '1.5.4' ){
			$categories = $this->model_catalog_category->getCategories(0);
		}else {
			$categories = $this->model_catalog_category->getCategories( array('limit' => 999999999, 'start'=>0 ) );
		}
		$this->mdata['categories'] = $categories;
	}

	public function _getProductSetting($module){
		$this->load->model('catalog/product');
		$setting = array();
		// Get List Product
		if (isset($module['featured_product'])) {
			$products = $module['featured_product'];
		} else {		
			$products = array();
		}
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			if ($product_info) {
				$setting[] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}
		return $setting;
	}

	public function _getStores(){

		$this->load->model('setting/store');

		$action = array();
		$action[] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
		);
		$store_default = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
		);
		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);
		
		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('module/pavcategorytabs', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		return $stores;
	}
	
	public function _message(){
 		if (isset($this->error['warning'])) {
			$this->mdata['error_warning'] = $this->error['warning'];
		} else {
			$this->mdata['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->mdata['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->mdata['success'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->mdata['error_dimension'] = $this->error['dimension'];
		} else {
			$this->mdata['error_dimension'] = array();
		}
	}

	public function _entryLanguage(){

		$this->mdata['heading_title'] = $this->language->get('heading_title');
		$this->mdata['text_enabled'] = $this->language->get('text_enabled');
		$this->mdata['text_disabled'] = $this->language->get('text_disabled');
		$this->mdata['text_content_top'] = $this->language->get('text_content_top');
		$this->mdata['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->mdata['text_column_left'] = $this->language->get('text_column_left');
		$this->mdata['text_column_right'] = $this->language->get('text_column_right');
		$this->mdata['entry_description'] = $this->language->get('entry_description');
		$this->mdata['entry_tabs'] = $this->language->get('entry_tabs');
		$this->mdata['limit_tabs'] = $this->language->get('label_limit_tabs');
		
		$this->mdata['entry_banner'] = $this->language->get('entry_banner');
		$this->mdata['entry_dimension'] = $this->language->get('entry_dimension'); 
		$this->mdata['entry_carousel'] = $this->language->get('entry_carousel');

		$this->mdata['entry_product'] = $this->language->get('entry_product');
		$this->mdata['entry_help_product'] = $this->language->get('entry_help_product');
		$this->mdata['entry_title_product'] = $this->language->get('entry_title_product');
		$this->mdata['entry_help_title_product'] = $this->language->get('entry_help_title_product');

		$this->mdata['entry_prefix_product'] = $this->language->get('entry_prefix_product');
		$this->mdata['entry_help_prefix_product'] = $this->language->get('entry_help_prefix_product');

		$this->mdata['entry_status_column'] = $this->language->get('entry_status_column');
		$this->mdata['entry_help_status_column'] = $this->language->get('entry_help_status_column');
		
		$this->mdata['entry_layout'] = $this->language->get('entry_layout');
		$this->mdata['entry_position'] = $this->language->get('entry_position');
		$this->mdata['entry_status'] = $this->language->get('entry_status');
		$this->mdata['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->mdata['entry_limit'] = $this->language->get('entry_limit');
		
		$this->mdata['button_save'] = $this->language->get('button_save');
		$this->mdata['button_cancel'] = $this->language->get('button_cancel');
		$this->mdata['button_add_module'] = $this->language->get('button_add_module');
		$this->mdata['button_remove'] = $this->language->get('button_remove');
		$this->mdata['status_nav'] = $this->language->get('label_status_nav');
		$this->mdata['tab_module'] = $this->language->get('tab_module');

		$this->mdata['no_image'] = '';
		$this->mdata['text_browse'] = $this->language->get('text_browse');
		$this->mdata['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->mdata['text_browse'] = $this->language->get('text_browse');
		$this->mdata['text_clear'] = $this->language->get('text_clear');	
		$this->mdata['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->mdata['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->mdata['token'] = $this->session->data['token'];

		$this->mdata['entry_module_name'] = $this->language->get('entry_module_name');
		
	}

	public function _breadcrumbs(){
		$this->mdata['breadcrumbs'] = array();

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavcategorytabs', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavcategorytabs')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
						
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
