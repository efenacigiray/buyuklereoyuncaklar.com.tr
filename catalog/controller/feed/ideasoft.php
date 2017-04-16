<?php
class ControllerFeedIdeasoft extends Controller {
	public function index() {
		$output  = '<?xml version="1.0" encoding="UTF-8" ?>';
		$output .= '<root>';
		$output .= '<title>' . $this->config->get('config_name') . '</title>';
		$output .= '<description>' . $this->config->get('config_meta_description') . '</description>';
		$output .= '<link>' . HTTP_SERVER . '</link>';

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$product_data = array();

		$categories = $this->model_catalog_category->getCategories();

		foreach ($categories as $category) {
			$filter_data = array(
				'filter_category_id' => $category['category_id'],
				'filter_filter'      => false
			);

			$products = $this->model_catalog_product->getProducts($filter_data);

			foreach ($products as $product) {
				if (!in_array($product['product_id'], $product_data) && $product['description']) {
					$output .= '<item>';
					$output .= '<stockCode><![CDATA[' . $product['model'] . ']]></stockCode>';
					$output .= '<label><![CDATA[' . $product['name'] . ']]></label>';
					$output .= '<brand><![CDATA[' . html_entity_decode($product['manufacturer'], ENT_QUOTES, 'UTF-8') . ']]></brand>';

					$categories = $this->model_catalog_product->getCategories($product['product_id']);
					foreach ($categories as $category) {
						$path = $this->getPath($category['category_id']);

						if ($path) {
							$string = '';

							foreach (explode('_', $path) as $path_id) {
								$category_info = $this->model_catalog_category->getCategory($path_id);

								if ($category_info) {
									if (!$string) {
										$string = $category_info['name'];
									} else {
										$string .= ' &gt; ' . $category_info['name'];
									}
								}
							}

							$output .= '<category><![CDATA[' . $string . ']]></category>';
						}
					}

					if ((float)$product['special']) {
						$output .= '<price>' .  $product['special'] . '</price>';
					} else {
						$output .= '<price>' . $product['price'] . '</price>';
					}

					$output .= '<tax>18</tax>';
					$output .= '<currencyAbbr>TL</currencyAbbr>';

					if ($product['image']) {
						$output .= '<picture1Path><![CDATA[' . $this->model_tool_image->resize($product['image'], 500, 500) . ']]></picture1Path>';
					} else {
						$output .= '<picture1Path></picture1Path>';
					}

					$output .= '<details><![CDATA[' . $product['description'] . ']]></details>';
					$output .= '</item>';
				}
			}
		}

		$output .= '</root>';

		$this->response->addHeader('Content-Type: application/xml');
		$this->response->setOutput($output);
	}

	protected function getPath($parent_id, $current_path = '') {
		$category_info = $this->model_catalog_category->getCategory($parent_id);

		if ($category_info) {
			if (!$current_path) {
				$new_path = $category_info['category_id'];
			} else {
				$new_path = $category_info['category_id'] . '_' . $current_path;
			}

			$path = $this->getPath($category_info['parent_id'], $new_path);

			if ($path) {
				return $path;
			} else {
				return $new_path;
			}
		}
	}
}
