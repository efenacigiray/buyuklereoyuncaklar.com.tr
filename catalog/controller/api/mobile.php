<?php
class ControllerApiMobile extends Controller {
	public function index () {
		$errors = array (
			'unknown' => 'Bilinmeyen istek!'
		);

		if (!isset($this->request->post['function'])) {
			echo $errors['unknown'];
			exit;
		}

		$function = $this->request->post['function'];

		echo $this->$function();
		exit;
	}

	public function getMainPage() {
		$this->load->model('tool/image');
		$this->load->model('design/banner');

		/* Slideshow */
		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner(9); // TODO: get from panel

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], 300, 300) // TODO: get from panel
				);
			}
		}
		/* Slideshow */

		return json_encode($data);
	}

	public function getCategories() {
		if (!$data['categories'] = $this->cache->get('categories.mobile')) {
			$this->load->model('catalog/category');
			$this->load->model('tool/image');

			$data['categories'] = array();

			$categories = $this->model_catalog_category->getCategories(0);

			foreach ($categories as $category) {
				if ($category['image']) {
					$thumb = $this->model_tool_image->resize($category['image'], 200, 200);// TODO: get from panel
				} else {
					$thumb = $this->model_tool_image->resize('placeholder.png', 200, 200);
				}

				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					if ($child['image']) {
						$child_thumb = $this->model_tool_image->resize($child['image'], 200, 200);// TODO: get from panel
					} else {
						$child_thumb = $this->model_tool_image->resize('placeholder.png', 200, 200);
					}

					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name'  => $child['name'],
						'thumb' => $child_thumb
					);
				}

				$data['categories'][] = array(
					'category_id' => $category['category_id'],
					'name'     => $category['name'],
					'children' => $children_data,
					'thumb'	   => $thumb
				);
			}

			$this->cache->set('categories.mobile', $data['categories']);			
		}

		return json_encode($data['categories']);
	}

	public function getProducts() {
		if (isset($this->request->post['category_id'])) {
			$category_id = $this->request->post['category_id'];
		} else {
			$category_id = '';
		}

		if (!$data['products'] = $this->cache->get('products.mobile' . $category_id)) {
			$this->load->model('catalog/product');
			$this->load->model('tool/image');

			if (isset($this->request->post['sort'])) {
				$sort = $this->request->post['sort'];
			} else {
				$sort = 'p.sort_order';
			}

			if (isset($this->request->post['order'])) {
				$order = $this->request->post['order'];
			} else {
				$order = 'ASC';
			}

			if (isset($this->request->post['page'])) {
				$page = $this->request->post['page'];
			} else {
				$page = 1;
			}

			if (isset($this->request->post['limit'])) {
				$limit = (int)$this->request->post['limit'];
			} else {
				$limit = $this->config->get('config_product_limit');// TODO: get from panel
			}

			$filter_data = array(
				'filter_category_id' => $category_id,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);
			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));// TODO: get from panel
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));// TODO: get from panel
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => strlen($result['name']) > 60 ? substr($result['name'], 0, 60) . '...' : $result['name'],
					'price'       => $price,
					'special'     => $special,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
				);
			}

			$this->cache->set('products.mobile' . $category_id, $data['products']);			
		}

		return json_encode($data['products']);
	}	

	public function getProduct() {

	}

	public function getCategory() {

	}

	public function getManufacturer() {

	}

	public function getCart() {

	}

	public function login() {

	}
}
