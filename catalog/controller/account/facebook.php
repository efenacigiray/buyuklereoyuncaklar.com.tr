<?php
class ControllerAccountFacebook extends Controller {
	private $error = array();

	public function index() {
		$this->load->model('account/customer');

		$data = array();

		if ($this->customer->isLogged()) {
			echo json_encode(array('status'=>'true'));
			exit;
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			// Trigger customer pre login event
			$this->event->trigger('pre.customer.login');

			// Unset guest
			unset($this->session->data['guest']);

			// Default Shipping Address
			$this->load->model('account/address');

			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if ($this->config->get('config_tax_customer') == 'shipping') {
				$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			// Wishlist
			if (isset($this->session->data['wishlist']) && is_array($this->session->data['wishlist'])) {
				$this->load->model('account/wishlist');

				foreach ($this->session->data['wishlist'] as $key => $product_id) {
					$this->model_account_wishlist->addWishlist($product_id);

					unset($this->session->data['wishlist'][$key]);
				}
			}

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			if (empty($this->customer->getEmail())) {
				$data['email'] = 'true';
			}

			$this->model_account_activity->addActivity('login', $activity_data);

			$this->event->trigger('post.customer.login');
			$data['status'] = 'true';
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		}

		echo json_encode($data);
		exit;
	}

	protected function validate() {
		$this->event->trigger('pre.customer.login');

		$user = json_decode(htmlspecialchars_decode($this->request->post['user']), true);

		if (!isset($this->request->post['auth']) || $this->request->post['auth'] != 'connected') {
			$this->error['error'] = 'Facebook ile girilemiyor!';
		}

		if (empty($user['id'])) {
			$this->error['error'] = 'Kullanıcı bilgilerinize erişilemiyor!';
		}

		if (!$this->error) {
			if (!$this->customer->facebookLogin($user)) {
				$this->error['error'] = 'Facebook ile girilemiyor!';
			}
		}

		return !$this->error;
	}
}
