<?php
class ControllerPaymentPayu extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/payu');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('payu', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');

		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_pending_status'] = $this->language->get('entry_pending_status');
		$data['entry_canceled_status'] = $this->language->get('entry_canceled_status');
		$data['entry_failed_status'] = $this->language->get('entry_failed_status');
		$data['entry_chargeback_status'] = $this->language->get('entry_chargeback_status');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_mb_id'] = $this->language->get('entry_mb_id');
		$data['entry_secret'] = $this->language->get('entry_secret');
		$data['entry_custnote'] = $this->language->get('entry_custnote');

		$data['help_total'] = $this->language->get('help_total');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/payu', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('payment/payu', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['payu_email'])) {
			$data['payu_email'] = $this->request->post['payu_email'];
		} else {
			$data['payu_email'] = $this->config->get('payu_email');
		}

		if (isset($this->request->post['payu_secret'])) {
			$data['payu_secret'] = $this->request->post['payu_secret'];
		} else {
			$data['payu_secret'] = $this->config->get('payu_secret');
		}

		if (isset($this->request->post['payu_total'])) {
			$data['payu_total'] = $this->request->post['payu_total'];
		} else {
			$data['payu_total'] = $this->config->get('payu_total');
		}

		if (isset($this->request->post['payu_order_status_id'])) {
			$data['payu_order_status_id'] = $this->request->post['payu_order_status_id'];
		} else {
			$data['payu_order_status_id'] = $this->config->get('payu_order_status_id');
		}

		if (isset($this->request->post['payu_pending_status_id'])) {
			$data['payu_pending_status_id'] = $this->request->post['payu_pending_status_id'];
		} else {
			$data['payu_pending_status_id'] = $this->config->get('payu_pending_status_id');
		}

		if (isset($this->request->post['payu_canceled_status_id'])) {
			$data['payu_canceled_status_id'] = $this->request->post['payu_canceled_status_id'];
		} else {
			$data['payu_canceled_status_id'] = $this->config->get('payu_canceled_status_id');
		}

		if (isset($this->request->post['payu_failed_status_id'])) {
			$data['payu_failed_status_id'] = $this->request->post['payu_failed_status_id'];
		} else {
			$data['payu_failed_status_id'] = $this->config->get('payu_failed_status_id');
		}

		if (isset($this->request->post['payu_chargeback_status_id'])) {
			$data['payu_chargeback_status_id'] = $this->request->post['payu_chargeback_status_id'];
		} else {
			$data['payu_chargeback_status_id'] = $this->config->get('payu_chargeback_status_id');
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['payu_geo_zone_id'])) {
			$data['payu_geo_zone_id'] = $this->request->post['payu_geo_zone_id'];
		} else {
			$data['payu_geo_zone_id'] = $this->config->get('payu_geo_zone_id');
		}

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['payu_status'])) {
			$data['payu_status'] = $this->request->post['payu_status'];
		} else {
			$data['payu_status'] = $this->config->get('payu_status');
		}

		if (isset($this->request->post['payu_sort_order'])) {
			$data['payu_sort_order'] = $this->request->post['payu_sort_order'];
		} else {
			$data['payu_sort_order'] = $this->config->get('payu_sort_order');
		}

		if (isset($this->request->post['payu_rid'])) {
			$data['payu_rid'] = $this->request->post['payu_rid'];
		} else {
			$data['payu_rid'] = $this->config->get('payu_rid');
		}

		if (isset($this->request->post['payu_custnote'])) {
			$data['payu_custnote'] = $this->request->post['payu_custnote'];
		} else {
			$data['payu_custnote'] = $this->config->get('payu_custnote');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/payu.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/payu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['payu_email']) {
			$this->error['email'] = $this->language->get('error_email');
		}

		return !$this->error;
	}
}