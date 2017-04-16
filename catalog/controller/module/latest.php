<?php
class ControllerModuleLatest extends Controller {
	public function index($setting) {
		$this->load->language('module/latest');

		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('catalog/manufacturer');
		$this->load->model('tool/image');

		$data['manufacturers'] = array();

		$results = $this->model_catalog_manufacturer->getManufacturers(array());

		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					continue;
				}

				$data['manufacturers'][] = array(
					'thumb'       => $image,
					'name'        => $result['name'],
					'href'        => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
				);
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/latest.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/latest.tpl', $data);
			} else {
				return $this->load->view('default/template/module/latest.tpl', $data);
			}
		}
	}
}
