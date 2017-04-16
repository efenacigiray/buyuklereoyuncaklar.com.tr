<?php
/******************************************************
 * @package  : Pav Social module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/

class ControllerModulePavsocial extends Controller {
	private $error = array();

	public $data = array();

	public function index() {

		$this->data['objlang'] = $this->language;
		$this->data['objurl'] = $this->url;

		$this->load->language('module/pavsocial');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
		$this->load->model('extension/module');


		$this->document->addScript('view/javascript/pavsocial/jscolor/jscolor.js');


		if( isset($this->request->get['module_id']) && isset($this->request->get['delete']) ){
			$this->model_extension_module->deleteModule( $this->request->get['module_id'] );
			$this->response->redirect($this->url->link('module/pavpavsocial', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting('pavsocial', $this->request->post);

			$action = $this->request->post['action'];

			unset($this->request->post['action']);
			
			$data = array();
				
			foreach ($this->request->post['pavsocial_module'] as $key => $value) {
		 	 	$data = $value;	
		 	 	break;
		 	}	

		  
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavsocial', $data ); 
			} else {
				$this->model_extension_module->editModule( $this->request->get['module_id'], $data );
			}	
 	
			$this->session->data['success'] = $this->language->get('text_success');
			if( isset($this->request->get['module_id'])  && $action == 'saveedit' ) {
				$this->response->redirect($this->url->link('module/pavsocial', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL'));
			}else{
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}


		}

		$this->_language();


		$this->data['positions'] = array( 
			// 'mainmenu',
			// 'slideshow',
			// 'promotion',
			// 'content_top',
			// 'column_left',
			// 'column_right',
			// 'content_bottom',
			// 'mass_bottom',
			// 'footer_top',
			// 'footer_center',
			// 'footer_bottom',
			'outsite_left',
			'outsite_right',
		);

		$this->data['themes'] = array('light','dark');
		$this->data['chromes'] = array('noheader', 'nofooter', 'noborders', 'noscrollbar', 'transparent');
		// Data
		$this->data['tab_module'] = $this->language->get('tab_module');

		$this->data['yesno'] = array(
			0=>$this->language->get('text_no'),
			1=>$this->language->get('text_yes')
		);

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['token'] = $this->session->data['token'];


		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->request->post['pavsocial_status'])) {
			$this->data['pavsocial_status'] = $this->request->post['pavsocial_status'];
		} else {
			$this->data['pavsocial_status'] = $this->config->get('pavsocial_status');
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->_breadcrumbs();

		$this->data['action'] = $this->url->link('module/pavsocial', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		 $default = array(
			'name' => '',
			'module_class'	=> '',
			'show_title'	=> 0,
			'module_title'	=> array(),
			'description'	=> array(), 
		);

	 
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
			$module_info = array_merge( $default, $module_info );
			$this->data['selectedid'] = $this->request->get['module_id'];
			$this->data['subheading'] = $this->language->get('text_edit_module') . $module_info['name'];
			$this->data['action'] = $this->url->link('module/pavsocial', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL');
		}else {
			$module_info = $default;
			$this->data['selectedid'] = 0;
			$this->data['subheading'] = $this->language->get('text_create_new_module');
			$this->data['action'] = $this->url->link('module/pavsocial', 'token=' . $this->session->data['token'], 'SSL');
		}

		$modules = array( 0=> $module_info );
		
	
		$moduletabs = $this->model_extension_module->getModulesByCode( 'pavsocial' );
	 	$this->data['link'] = $this->url->link('module/pavsocial', 'token=' . $this->session->data['token'] . '', 'SSL');
 	
 	 
 		$this->data['moduletabs'] = $moduletabs;
 		$this->data['modules']  = $modules; 

 		$this->data['olang']  = $this->language; 

 		//  echo '<pre>'.print_r( $modules, 1);die; 


		$this->load->model('design/layout');
		$this->data['layouts'] = array();
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
		// foreach ($this->model_design_layout->getLayouts() as $layout) {
		// 	$this->data['layouts'][] = $layout;
		// }

		$this->load->model('design/banner');
		$this->data['banners'] = $this->model_design_banner->getBanners();

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavsocial.tpl', $this->data));
	}

	public function _language(){

		$base = "";
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$base = $this->config->get('config_ssl');
		} else {
			$base = $this->config->get('config_url');
		}


		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_tabs'] = $this->language->get('entry_tabs');
		$this->data['entry_status_order'] = $this->language->get('entry_status_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_module_add'] = $this->language->get('button_module_add');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_username'] = $this->language->get('entry_username');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_widgetid'] = $this->language->get('entry_widgetid');
		$this->data['entry_theme'] = $this->language->get('entry_theme');
		$this->data['entry_linkcolor'] = $this->language->get('entry_linkcolor');
		$this->data['entry_bordercolor'] = $this->language->get('entry_bordercolor');
		$this->data['entry_width'] = $this->language->get('entry_width');
		$this->data['entry_height'] = $this->language->get('entry_height');
		$this->data['entry_showreply'] = $this->language->get('entry_showreply');
		$this->data['entry_chrome'] = $this->language->get('entry_chrome');
		$this->data['entry_widget_help'] = $this->language->get('entry_widget_help');
		$this->data['entry_widget_help'] = sprintf($this->data['entry_widget_help'],$base,$base,$base,$base);
		$this->data['entry_count_help'] = $this->language->get('entry_count_help');
		$this->data['entry_nickname_color'] = $this->language->get('entry_nickname_color');
		$this->data['entry_name_color'] = $this->language->get('entry_name_color');
		$this->data['entry_title_color'] = $this->language->get('entry_title_color');
		$this->data['entry_chrome_help'] = $this->language->get('entry_chrome_help');
	}


	public function _breadcrumbs(){
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
			'href'      => $this->url->link('module/pavsocial', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavsocial')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['pavsocial_module'])) {

		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
?>
