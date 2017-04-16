<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
class ControllerModulePavverticalmenu extends Controller {

	private $mdata = array();

	public function index($setting) {
		static $module = 0;

		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->load->model( 'verticalmenu/verticalmenu' );
		$this->load->model('setting/setting');

		// Get Config store_id
		$store_id = $this->config->get('config_store_id');
		$this->mdata['store_id'] = $store_id;

		$is_installed = $this->model_verticalmenu_verticalmenu->isInstalled();

		if(!$is_installed) {
			return;
		}
		
		$this->load->language('module/pavverticalmenu');
		
		$this->mdata['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavverticalmenu/style.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavverticalmenu/style.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavverticalmenu/style.css');
		}
		
		/* check bootstrap 3 framwework existed or not. this modules is main support for  themes for pavothemes ' */
		if ( !file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/bootstrap.css') ) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavverticalmenu/css/bootstrap.css');
			$this->document->addScript('catalog/view/theme/default/stylesheet/pavverticalmenu/js/bootstrap.js');
		}

		
		$this->mdata['module'] = $module++;
		$params = $this->model_setting_setting->getSetting( 'pavverticalmenu_params' );
		if( isset($params['params']) && !empty($params['params']) ){
	 		$params = json_decode( $params['params'] );
	 	}

		// Get Config store_id
		$store_id = $this->config->get('config_store_id');
		$this->mdata['store_id'] = $store_id;

		$data['category_id'] = 0;

		if (!$data['categories'] = $this->cache->get('categories')) {
			$this->load->model('catalog/category');

			$data['categories'] = array();

			$categories = $this->model_catalog_category->getCategories(0);

			foreach ($categories as $category) {
					// Level 2
					$children_data = array();

					$children = $this->model_catalog_category->getCategories($category['category_id']);

					foreach ($children as $child) {
						$filter_data = array(
							'filter_category_id'  => $child['category_id'],
							'filter_sub_category' => true
						);

						$children_data[] = array(
							'category_id' => $category['category_id'],
							'name'  => $child['name'],
							'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
						);
					}

					$data['categories'][] = array(
						'category_id' => $category['category_id'],
						'name'     => $category['name'],
						'children' => $children_data,
						'column'   => $category['column'] ? $category['column'] : 1,
						'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
					);
			}

			$this->cache->set('categories', $data['categories']);			
		}

		$parent = '1';
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavverticalmenu.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/pavverticalmenu.tpl';
		} else {
			$template = 'default/template/module/pavverticalmenu.tpl';
		}
	
		return $this->load->view($template, $this->mdata);
	}

	public function ajxgenmenu( ){ 
 	 	
	}

	public function renderwidget(){

		$this->load->model( 'verticalmenu/widget' );
		$this->model_verticalmenu_widget->loadWidgets();

		if( isset($this->request->post['widgets']) ){
	
			$widgets = $this->request->post['widgets'];
			$widgets = explode( '|wid-', '|'.$widgets );
			if( !empty($widgets) ){
				unset( $widgets[0] );
				
				$output = '';
				foreach( $widgets as $wid ){
					$output .= $this->model_verticalmenu_widget->renderButton( $wid );
				}

				echo $output;
			}
		 
		}
		exit();
	}
}
?>