<?php
class Excel {
	public function __construct () {
		require_once('external/PHPExcel/PHPExcel.php');
	}

	public function create ( $file ) {
		$filetype = PHPExcel_IOFactory::identify($file);
		$objReader = PHPExcel_IOFactory::createReader($filetype)
		$objPHPExcel = $objReader->load($excel_file);

		return $objPHPExcel;
	}
}
