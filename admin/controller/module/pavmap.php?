<?php
class ControllerModulePavmap extends Controller {
	private $error = array();

	private $data = array();

	/**
	 * [initData]
	 */
	public function initData() {

		$this->data['objlang'] = $this->language;
		$this->data['objurl'] = $this->url;

		$this->load->language('module/pavmap');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
		$this->load->model('extension/module');

		$this->load->model('design/layout');

		$this->load->model('localisation/language');

		$this->load->model('tool/image');

		$this->load->model('pavmap/location');

		$model = $this->model_pavmap_location;

		$model->installModule();

		$this->_language();

		//Message
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['yesno'] = array(
			0=>$this->language->get('text_no'),
			1=>$this->language->get('text_yes')
		);

		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['token'] = $this->session->data['token'];

		$menus = array();
		$menus["modules"] = array("link"=>$this->url->link('module/pavmap', 'token=' . $this->session->data['token'], 'SSL'),"title"=>$this->language->get('menu_manage_modules'));
		$menus["grouplocation"] = array("link"=>$this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'], 'SSL'),"title"=>$this->language->get('menu_group_location_map'));
		$menus["location"] = array("link"=>$this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'], 'SSL'),"title"=>$this->language->get('menu_location_map'));

		$this->data["menus"] = $menus;

		$this->document->addStyle('view/stylesheet/pavmap.css');
	}

	/**
	 * [setBreadcrumb]
	 */
	public function setBreadcrumb() {
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavmap', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
	}

	/**
	 * [index description]
	 * @return [module.tpl]
	 */
	public function index() {
		$this->initData();

		$this->setBreadcrumb();

		$this->data["menu_active"] = "modules";


		if( isset($this->request->get['module_id']) && isset($this->request->get['delete']) ){
			$this->model_extension_module->deleteModule( $this->request->get['module_id'] );
			$this->response->redirect($this->url->link('module/pavmap', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = $this->request->post['action'];
			$store_id = $this->request->post['pavmap_module']['store_id'];
			$surl = isset($store_id)?'&store_id='.$store_id:'';

			unset($this->request->post['action']);
			unset( $this->request->post['pavmap_module']['store_id']);
			unset( $this->request->post['pavmap_module']['stores']);

			 
			$data = array();
				
			foreach ($this->request->post['pavmap_module'] as $key => $value) {
		 	 	$data = $value;	
		 	 	break;
		 	}	

			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavmap', $data );
			} else {
				$this->model_extension_module->editModule( $this->request->get['module_id'], $data );
			}	
 			
			$this->session->data['success'] = $this->language->get('text_success');
			if( isset($this->request->get['module_id'])  && $action == 'save-stay' ) {
				$this->response->redirect($this->url->link('module/pavmap', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'].$surl, 'SSL'));
			}else{
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}

		}

		$this->data['action'] = $this->url->link('module/pavmap', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		// Start GetData Store
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

		// status
		if (isset($this->request->post['pavmap_status'])) {
			$this->data['pavmap_status'] = $this->request->post['pavmap_status'];
		} else {
			$this->data['pavmap_status'] = $this->config->get('pavmap_status');
		}

		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);

		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('module/pavmap', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		$this->data['stores'] = $stores;
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		$this->data['store_id'] = $store_id;
		// End GetData Store

			
		$default = array(
			'name' => '',
			'prefix'	=> '',
			'show_title'	=> 0,
			'title'	=> array(),
			'des'	=> array(), 
			'limit' => 200,
			'height' => 400
		);

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
			$module_info = array_merge( $default, $module_info );
			$this->data['selectedid'] = $this->request->get['module_id'];
			$this->data['subheading'] = $this->language->get('text_edit_module') . $module_info['name'];
			$this->data['action'] = $this->url->link('module/pavmap', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL');
		}else {
			$module_info = $default;
			$this->data['selectedid'] = 0;
			$this->data['subheading'] = $this->language->get('text_create_new_module');
			$this->data['action'] = $this->url->link('module/pavmap', 'token=' . $this->session->data['token'], 'SSL');
		}

		$moduletabs = $this->model_extension_module->getModulesByCode( 'pavmap' );
	 	$this->data['link'] = $this->url->link('module/pavmap', 'token=' . $this->session->data['token'] . '', 'SSL');
 	
 	 
 		$this->data['moduletabs'] = $moduletabs;
 
 		$this->data['olang']  = $this->language; 
		$modules = array( 0=> $module_info );
 
		$this->data['modules'] = $modules; 

 	// 	echo '<pre>'.print_r( $module_info,  1);


		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_name'] = $this->language->get('entry_name');

		$this->data['layouts'] = array();
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );

		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavmap/module.tpl', $this->data));
	}

	/**
	 * [groupLocation]
	 * @return [grouplocation.tpl]
	 */
	public function grouplocation() {
		$this->initData();

		$this->data['token'] = $this->session->data['token'];
		$this->data['insert_link'] = $this->url->link('module/pavmap/groupinsert', 'token=' . $this->session->data['token'], 'SSL');

		$this->setBreadcrumb();

		$this->data["menu_active"] = "grouplocation";


		if (isset($this->request->get['page'])) {
			$data['page'] = $this->request->get['page'];
		} else {
			$data['page'] = 1;
		}

		$data['limit'] = $this->config->get('config_admin_limit');
		$data['filter'] = array();

		if (isset($this->request->get['filter_name'])) {
			$data['filter']['name'] = $this->request->get['filter_name'];
		} else {
			$data['filter']['name'] = null;
		}
		if (isset($this->request->get['filter_status'])) {
			$data['filter']['status'] = $this->request->get['filter_status'];
		} else {
			$data['filter']['status'] = null;
		}
		if (isset($this->request->get['filter_store'])) {
			$data['filter']['store_id'] = $this->request->get['filter_store'];
		} else {
			$data['filter']['store_id'] = null;
		}

		if (isset($this->request->get['sort'])) {
			$data['sort'] = $this->request->get['sort'];
		} else {
			$data['sort'] = 'name';
		}
		if (isset($this->request->get['order'])) {
			$data['order'] = $this->request->get['order'];
		} else {
			$data['order'] = 'DESC';
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . urlencode(html_entity_decode($this->request->get['filter_status'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . urlencode(html_entity_decode($this->request->get['filter_store'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['action'] = $this->url->link('module/pavmap/groupdelete', 'token=' . $this->session->data['token'] . $url, 'SSL');


		$location_total = $this->model_pavmap_location->getTotalGroupLocations($data);
		$results = $this->model_pavmap_location->getGroupLocations($data);
		foreach ($results as &$result) {
			$result['action'] = $this->url->link('module/pavmap/groupupdate', 'group_id='.$result['group_location_id'].'&token=' . $this->session->data['token'] . $url, 'SSL');;
		}
		$this->data['groups'] = $results;

    	$url = '';
    	if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}

		if ($data['order'] == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['button_filter'] = $this->language->get("button_filter");

		$this->data['column_name'] = $this->language->get("column_name");
		$this->data['column_status'] = $this->language->get("column_status");
		$this->data['action_edit'] = $this->language->get("action_edit");
		$this->data['column_store'] = $this->language->get("column_store");
		$this->data['column_action'] = $this->language->get("column_action");
		$this->data['text_no_results'] = $this->language->get("text_no_results");

		$this->data['sort_name'] = $this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $location_total;
		$pagination->page = $data['page'];
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['results'] = sprintf($this->language->get('text_pagination'), ($location_total) ? (($data['page'] - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($data['page'] - 1) * $this->config->get('config_limit_admin')) > ($location_total - $this->config->get('config_limit_admin'))) ? $location_total : ((($data['page'] - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $location_total, ceil($location_total / $this->config->get('config_limit_admin')));

		$this->data['sort'] = $data['sort'];
		$this->data['order'] = $data['order'];

		$this->data['filter_name'] = $data['filter']['name'];
		$this->data['filter_status'] = $data['filter']['status'];
		$this->data['filter_store'] = $data['filter']['store_id'];

		//stores
		$this->load->model('setting/store');
		$store_default = array(
			'store_id' => '0',
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
			$store['option'] = $this->url->link('module/pavmap/grouplocation', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		$this->data['stores'] = $stores;

		if (isset($this->request->get['store_id'])) {
			$this->data['config_store_id'] = $this->request->post['store_id'];
		} elseif (!empty($location_info)) {
			$this->data['config_store_id'] = $location_info['content'];
		} else {
			$this->data['config_store_id'] = (int)$this->config->get('config_store_id');
		}

		$this->data['config_store_id'] = (int)$this->config->get('config_store_id');

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavmap/group_location.tpl', $this->data));
	}

	/**
	 * [groupinsert]
	 */
	public function groupinsert() {
		$this->initData();
		$this->setBreadcrumb();
		$this->data["menu_active"] = "insert";
		$this->load->model('pavmap/location');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->model_pavmap_location->addGroupLocation($this->request->post);

			$this->response->redirect($this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$this->getGroupFrom();
	}

	/**
	 * [groupupdate]
	 */
	public function groupupdate() {

		$this->initData();
		$this->setBreadcrumb();
		$this->data["menu_active"] = "update";
		$this->load->model('pavmap/location');

		$this->data['group_id'] = $this->request->get['group_id'];

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->model_pavmap_location->editGroupLocation($this->request->get['group_id'], $this->request->post);

			if ($action == 'save-stay') {
				$this->response->redirect($this->url->link('module/pavmap/groupupdate', 'group_id='.$this->request->get['group_id'].'&token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		$this->getGroupFrom();
	}

	public function groupdelete() {
		$this->initData();
		$this->setBreadcrumb();
		$this->load->model('pavmap/location');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			$this->model_pavmap_location->deleteGroupLocation($this->request->post['selected']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
	/**
	 * [getFrom]
	 * @return [Form]
	 */
	public function getGroupFrom() {

		$url = '';

		if (!isset($this->request->get['group_id'])) {
			$this->data['action'] = $this->url->link('module/pavmap/groupinsert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('module/pavmap/groupupdate', 'token=' . $this->session->data['token'] . '&group_id=' . $this->request->get['group_id'] . $url, 'SSL');
		}
		$this->data['cancel'] = $this->url->link('module/pavmap/grouplocation', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['group_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$grouplocation_info = $this->model_pavmap_location->getGroupLocation($this->request->get['group_id']);
		}

		if (isset($this->request->get['group_id'])) {
			$this->data['group_id'] = $this->request->get['group_id'];
		} else {
			$this->data['group_id'] = 0;
		}

		if (isset($this->request->post['group_name'])) {
			$this->data['group_name'] = $this->request->post['group_name'];
		} elseif (!empty($grouplocation_info)) {
			$this->data['group_name'] = $grouplocation_info['name'];
		} else {
			$this->data['group_name'] = '';
		}

		if (isset($this->request->post['group_store'])) {
			$this->data['group_store'] = $this->request->post['group_store'];
		} elseif (!empty($grouplocation_info)) {
			$this->data['group_store'] = $grouplocation_info['store_id'];
		} else {
			$this->data['group_store'] = '';
		}

		if (isset($this->request->post['group_status'])) {
			$this->data['group_status'] = $this->request->post['group_status'];
		} elseif (!empty($grouplocation_info)) {
			$this->data['group_status'] = $grouplocation_info['status'];
		} else {
			$this->data['group_status'] = '';
		}

		// Stores
		$this->load->model('setting/store');
		$store_default = array(
			'store_id' => '0',
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
			$store['option'] = $this->url->link('module/pavmap/grouplocation', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		$this->data['stores'] = $stores;

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavmap/group_form.tpl', $this->data));
	}

	/**
	 * [location]
	 */
	public function location() {
		$this->initData();

		$this->data['token'] = $this->session->data['token'];
		$this->data['insert_link'] = $this->url->link('module/pavmap/insert', 'token=' . $this->session->data['token'], 'SSL');

		$this->setBreadcrumb();

		$this->data["menu_active"] = "location";

		$this->load->model('pavmap/location');


		if (isset($this->request->get['page'])) {
			$data['page'] = $this->request->get['page'];
		} else {
			$data['page'] = 1;
		}
		$data['limit'] = $this->config->get('config_admin_limit');
		$data['filter'] = array();
		if (isset($this->request->get['filter_title'])) {
			$data['filter']['title'] = $this->request->get['filter_title'];
		} else {
			$data['filter']['title'] = null;
		}
		if (isset($this->request->get['filter_status'])) {
			$data['filter']['status'] = $this->request->get['filter_status'];
		} else {
			$data['filter']['status'] = null;
		}
		if (isset($this->request->get['filter_latitude'])) {
			$data['filter']['latitude'] = $this->request->get['filter_latitude'];
		} else {
			$data['filter']['latitude'] = null;
		}
		if (isset($this->request->get['filter_longitude'])) {
			$data['filter']['longitude'] = $this->request->get['filter_longitude'];
		} else {
			$data['filter']['longitude'] = null;
		}

		$data['sort'] = isset($this->request->get['sort'])?$this->request->get['sort']:"title";
		$data['order'] = isset($this->request->get['order'])?$this->request->get['order']:"DESC";


		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . urlencode(html_entity_decode($this->request->get['filter_status'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_latitude'])) {
			$url .= '&filter_latitude=' . $this->request->get['filter_latitude'];
		}

		if (isset($this->request->get['filter_longitude'])) {
			$url .= '&filter_longitude=' . $this->request->get['filter_longitude'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['action'] = $this->url->link('module/pavmap/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$location_total = $this->model_pavmap_location->getTotalLocations($data);
		$results = $this->model_pavmap_location->getlocations($data);
		foreach ($results as &$result) {
			$result['action'] = $this->url->link('module/pavmap/update', 'location_id='.$result['location_id'].'&token=' . $this->session->data['token'] . $url, 'SSL');;
		}
		$this->data['locations'] = $results;

    	$url = '';
    	if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_latitude'])) {
			$url .= '&filter_latitude=' . $this->request->get['filter_latitude'];
		}

		if (isset($this->request->get['filter_longitude'])) {
			$url .= '&filter_longitude=' . $this->request->get['filter_longitude'];
		}

		if ($data['order'] == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['button_filter'] = $this->language->get("button_filter");

		$this->data['column_title'] = $this->language->get("column_title");
		$this->data['column_icon'] = $this->language->get("column_icon");
		$this->data['column_latitude'] = $this->language->get("column_latitude");
		$this->data['column_longitude'] = $this->language->get("column_longitude");
		$this->data['column_status'] = $this->language->get("column_status");

		$this->data['action_edit'] = $this->language->get("action_edit");

		$this->data['column_store'] = $this->language->get("column_store");
		$this->data['column_action'] = $this->language->get("column_action");
		$this->data['text_no_results'] = $this->language->get("text_no_results");


		$this->data['sort_title'] = $this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'] . '&sort=title' . $url, 'SSL');

		$url = '';


		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_latitude'])) {
			$url .= '&filter_latitude=' . urlencode(html_entity_decode($this->request->get['filter_latitude'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_longitude'])) {
			$url .= '&filter_longitude=' . $this->request->get['filter_longitude'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $location_total;
		$pagination->page = $data['page'];
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['results'] = sprintf($this->language->get('text_pagination'), ($location_total) ? (($data['page'] - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($data['page'] - 1) * $this->config->get('config_limit_admin')) > ($location_total - $this->config->get('config_limit_admin'))) ? $location_total : ((($data['page'] - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $location_total, ceil($location_total / $this->config->get('config_limit_admin')));



		$this->data['sort'] = $data['sort'];
		$this->data['order'] = $data['order'];

		$this->data['filter_title'] = $data['filter']['title'];
		$this->data['filter_latitude'] = $data['filter']['latitude'];
		$this->data['filter_longitude'] = $data['filter']['longitude'];
		$this->data['filter_status'] = $data['filter']['status'];

		//stores
		$this->load->model('setting/store');
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
			$store['option'] = $this->url->link('module/pavmap/location', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		$this->data['stores'] = $stores;

		if (isset($this->request->get['store_id'])) {
			$this->data['config_store_id'] = $this->request->post['store_id'];
		} elseif (!empty($location_info)) {
			$this->data['config_store_id'] = $location_info['content'];
		} else {
			$this->data['config_store_id'] = (int)$this->config->get('config_store_id');
		}

		$this->data['config_store_id'] = (int)$this->config->get('config_store_id');


		//echo "<pre>"; print_r($stores); die;

		//echo "<pre>".print_r($this->data,1);die;
		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavmap/location.tpl', $this->data));
	}

	/**
	 * [update Location]
	 */
	public function update () {

		$this->initData();
		$this->setBreadcrumb();
		$this->data["menu_active"] = "update";
		$this->load->model('pavmap/location');

		$this->data['location_id'] = $this->request->get['location_id'];

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			$this->session->data['success'] = $this->language->get('text_success');

			//echo "<pre>"; print_r($this->request->post); die;

			$this->model_pavmap_location->editLocation($this->request->get['location_id'], $this->request->post);

			if ($action == 'save-stay') {
				$this->response->redirect($this->url->link('module/pavmap/update', 'location_id='.$this->request->get['location_id'].'&token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->getForm();
	}

	/**
	 * [insert Location]
	 * @return [type] [description]
	 */
	public function insert() {
		$this->initData();
		$this->setBreadcrumb();
		$this->data["menu_active"] = "insert";
		$this->load->model('pavmap/location');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			//echo "<pre>"; print_r($this->request->post); die;

			$this->model_pavmap_location->addLocation($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			if ($action == 'save-stay') {
				$this->response->redirect($this->url->link('module/pavmap/insert', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->getForm();
	}
	/**
	 * [delete Location]
	 */
	public function delete() {
		$this->initData();
		$this->setBreadcrumb();
		$this->load->model('pavmap/location');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = $this->request->post['action'];

			unset($this->request->post['action']);

			$this->model_pavmap_location->deleteLocation($this->request->post['selected']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	/**
	 * [getForm Location]
	 */
	public function getForm() {
		$this->load->model('tool/image');

		$this->load->model('pavmap/location');

		$groups = $this->model_pavmap_location->getGroupLocations(null);
		$this->data['groups'] = $groups;

		$url = '';

		if (!isset($this->request->get['location_id'])) {
			$this->data['action'] = $this->url->link('module/pavmap/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('module/pavmap/update', 'token=' . $this->session->data['token'] . '&location_id=' . $this->request->get['location_id'] . $url, 'SSL');
		}
		$this->data['cancel'] = $this->url->link('module/pavmap/location', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['location_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$location_info = $this->model_pavmap_location->getLocation($this->request->get['location_id']);
    	}

    	if (isset($this->request->get['location_id'])) {
			$this->data['location_id'] = $this->request->get['location_id'];
		} else {
			$this->data['location_id'] = 0;
		}

    	if (isset($this->request->post['location_title'])) {
			$this->data['title'] = $this->request->post['location_title'];
		} elseif (!empty($location_info)) {
			$this->data['title'] = $location_info['title'];
		} else {
			$this->data['title'] = '';
		}

		if (isset($this->request->post['location_link'])) {
			$this->data['location_link'] = $this->request->post['location_title'];
		} elseif (!empty($location_info)) {
			$this->data['location_link'] = $location_info['link'];
		} else {
			$this->data['location_link'] = '';
		}

		if (isset($this->request->post['location_address'])) {
			$this->data['location_address'] = $this->request->post['location_address'];
		} elseif (!empty($location_info)) {
			$this->data['location_address'] = $location_info['address'];
		} else {
			$this->data['location_address'] = '';
		}

		if (isset($this->request->post['location_group'])) {
			$this->data['location_group'] = $this->request->post['location_group'];
		} elseif (!empty($location_info)) {
			$this->data['location_group'] = $location_info['group_location_id'];
		} else {
			$this->data['location_group'] = '';
		}

		if (isset($this->request->post['location_status'])) {
			$this->data['status'] = $this->request->post['location_status'];
		} elseif (!empty($location_info)) {
			$this->data['status'] = $location_info['status'];
		} else {
			$this->data['status'] = '';
		}

		if (isset($this->request->post['location_content'])) {
			$this->data['content'] = $this->request->post['location_content'];
		} elseif (!empty($location_info)) {
			$this->data['content'] = $location_info['content'];
		} else {
			$this->data['content'] = '';
		}

		if (isset($this->request->post['location_latitude'])) {
			$this->data['latitude'] = $this->request->post['location_latitude'];
		} elseif (!empty($location_info)) {
			$this->data['latitude'] = $location_info['latitude'];
		} else {
			$this->data['latitude'] = '';
		}

		if (isset($this->request->post['location_longitude'])) {
			$this->data['longitude'] = $this->request->post['location_longitude'];
		} elseif (!empty($location_info)) {
			$this->data['longitude'] = $location_info['longitude'];
		} else {
			$this->data['longitude'] = '';
		}

		if (isset($this->request->post['location_image'])) {
			$this->data['image'] = $this->request->post['location_image'];
		} elseif (!empty($location_info)) {
			$this->data['image'] = $location_info['image'];
		} else {
			$this->data['image'] = '';
		}

		if (isset($this->request->post['location_icon'])) {
			$this->data['icon'] = $this->request->post['location_icon'];
		} elseif (!empty($location_info)) {
			$this->data['icon'] = $location_info['icon'];
		} else {
			$this->data['icon'] = '';
		}

		//echo "<pre>"; print_r($location_info); die;

		if (isset($this->request->post['location_image']) && file_exists(DIR_IMAGE . $this->request->post['location_image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($this->request->post['location_image'], 100, 100);
		} elseif (!empty($location_info) && $location_info['image'] && file_exists(DIR_IMAGE . $location_info['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($location_info['image'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		if (isset($this->request->post['location_icon']) && file_exists(DIR_IMAGE . $this->request->post['location_icon'])) {
			$this->data['thumb_icon'] = $this->model_tool_image->resize($this->request->post['location_icon'], 49, 56);
		} elseif (!empty($location_info) && $location_info['icon'] && file_exists(DIR_IMAGE . $location_info['icon'])) {
			$this->data['thumb_icon'] = $this->model_tool_image->resize($location_info['icon'], 49, 56);
		} else {
			$this->data['thumb_icon'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		$this->data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);



		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavmap/location_form.tpl', $this->data));
	}

	/**
	* Language function
	*/
	public function _language(){
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$this->data['text_location_address'] = $this->language->get('text_location_address');
		$this->data['help_location_address'] = $this->language->get('help_location_address');

		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_height'] = $this->language->get('entry_height');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_group_location'] = $this->language->get('entry_group_location');
		$this->data['help_store'] = $this->language->get('help_store');
		$this->data['help_group_location'] = $this->language->get('help_group_location');
		$this->data['help_limit'] = $this->language->get('help_limit');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_stay'] = $this->language->get('button_save_stay');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_module_add'] = $this->language->get('button_module_add');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_copy'] = $this->language->get('button_copy');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');
	}

	/**
	 * [validate]
	 */
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavmap')) {
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