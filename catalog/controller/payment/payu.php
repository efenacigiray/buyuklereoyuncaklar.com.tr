<?php
class ControllerPaymentpayu extends Controller {
	public function index() {
		$this->load->model('checkout/order');

		$this->load->language('payment/payu');

		$data['button_confirm'] = $this->language->get('button_confirm');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

		$liveUpdate = new PayuLu($this->config->get('payu_email'), $this->config->get('payu_secret'));
		$liveUpdate->setOrderRef($this->session->data['order_id']);
        $liveUpdate->setDebug(PayuLu::DEBUG_ALL);

		foreach ($this->cart->getProducts() as $product) {
			$product = new PayuProduct(
				trim($product['name']),
				$product['model'],
				'',
				$product['price'] / 1.18,
				'NET',
				$product['quantity'],
				'18'
			);

			$liveUpdate->addProduct($product);
		}

		$billing = new PayuAddress();
		$billing->setFirstName($order_info['payment_firstname']);
		$billing->setLastName($order_info['payment_lastname']);
		$billing->setEmail($order_info['email']);
		$billing->setCity($order_info['payment_city']);
		$billing->setState($order_info['payment_city']);
		$billing->setCountryCode("TR");
		$billing->setAddress($order_info['payment_address_1']);
		$liveUpdate->setBillingAddress($billing);

		$shipping = new PayuAddress();
		$shipping->setFirstName($order_info['payment_firstname']);
		$shipping->setLastName($order_info['payment_lastname']);
		$shipping->setEmail($order_info['email']);
		$shipping->setCity($order_info['shipping_city']);
		$shipping->setState($order_info['shipping_city']);
		$shipping->setCountryCode("TR");
		$shipping->setAddress($order_info['shipping_address_1']);
		$liveUpdate->setDeliveryAddress($shipping);

		$liveUpdate->setPaymentCurrency("TRY");
		$liveUpdate->setInstalments("3,6,9");
		$liveUpdate->setOrderShipping("");
		$liveUpdate->setLanguage("TR");

		$liveUpdate->setBackRef($this->url->link('payment/payu/callback', 'ref_id=' . base64_encode($this->session->data['order_id']), ''));
		$data['payu'] = $liveUpdate->renderPaymentForm();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/payu.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/payu.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/payu.tpl', $data);
		}
	}

	public function callback() {
		$this->load->model('checkout/order');

		$ctrl = $this->request->get['ctrl'];
		$order_id = base64_decode($this->request->get['amp;ref_id']);

		$order_info = $this->model_checkout_order->getOrder($order_id);

		if ($order_info) {
			$verified = false;

			$liveUpdate = new PayuLu($this->config->get('payu_email'), $this->config->get('payu_secret'));

			$liveUpdate->setBackRef($this->url->link('payment/payu/callback', 'ref_id=' . base64_encode($order_id), ''));
			$hash = $liveUpdate->generateControlHash();

			if ($hash == $ctrl) {
				$verified = true;
			}

			if ($verified) {
				$this->model_checkout_order->addOrderHistory($order_id, $this->config->get('payu_order_status_id'), '', true);
			} else {
				$this->model_checkout_order->addOrderHistory($order_id, $this->config->get('payu_pending_status_id'), '', true);
			}

			$this->response->redirect($this->url->link('checkout/success'));
		}
	}
}

/* Make sure strlen behaves as intended by setting multibyte function overload to 0 */
ini_set("mbstring.func_overload", 0);

if (ini_get("mbstring.func_overload") > 2) { /* check if mbstring.func_overload is still set to overload strings(2) */
    echo "WARNING: mbstring.func_overload is set to overload strings and might cause problems\n";
}
error_reporting(E_ALL);
class PayuLu
{
    const DEBUG_NONE='0';
    const DEBUG_ALL='9999';
    const DEBUG_FATAL='9990';
    const DEBUG_ERROR='2';
    const DEBUG_WARNING='1';

    const PAY_METHOD_CCVISAMC = 'CCVISAMC';

    private $_debugLevel = 0;
    private $_errorLog = '';
    private $_allErrors = array();
    private $_merchantId = '';
    private $_secretKey = '';
    private $_AutoMode = 0;
    private $_TestMode = 'FALSE';
    private $_luQueryUrl = 'https://secure.payu.com.tr/order/lu.php';
    private $_Discount;
    private $_Instalment;
    private $_Language;
    private $_OrderRef;
    private $_OrderDate;
    private $_PriceCurrency;
    private $_Currency;
    private $_BackRef;
    private $_PayMethod;
    private $_Debug;
    private $_billingAddress;
    private $_deliveryAddress;
    private $_destinationAddress;
    private $_OrderShipping = 0;
    private $_allProducts = array();
    private $_tempProds = array();
    private $_customFields = array();
    private $_htmlFormCode;
    private $_htmlCode;
    private $_htmlHashString;
    private $_hashString;
    private $_HASH;
    public $_explained;
    public $_btnName;


    function __construct($merchantId, $secretKey)
    {
        $this->_merchantId = $merchantId;   // store the merchant id
        $this->_secretKey = $secretKey;    // store the secretkey
        if (empty($merchantId) && empty($secretKey)) {
            return 0;
        }
    }

    public function setDeliveryAddress(PayuAddress $currentAddress) {
        if ($currentAddress) {
            $this->_deliveryAddress = $currentAddress;
            
        }
        return 0;
    }

    public function setBillingAddress(PayuAddress $currentAddress)
    {
            $this->_billingAddress = $currentAddress;
    }

    public function setDestinationAddress(PayuAddress $currentAddress)
    {
        $this->_destinationAddress = $currentAddress;
    }

    public function addProduct(PayuProduct $currentProduct)
    {
        if ($currentProduct) {
            $this->_allProducts[] = $currentProduct; // add the current product
            
        }
        return 0;
    }

    public function renderPaymentInputs()
    {
        $this->_setOrderDate();
        $this->_makeHashString();
        $this->_makeHash();
    }

    public function generateControlHash() {
        $this->_makeHashString(true);
        $this->_makeHash();

        return $this->_HASH;
    }

    public function renderPaymentForm($autoSubmit=FALSE)
    {
        $this->_setOrderDate();
        $this->_makeHashString();
        
        $this->_makeHash();
        $this->_makeFields();
        $this->_makeForm($autoSubmit);

        return $this->_htmlCode;
    }

    private function _makeFields()
    {
        $this->_htmlFormCode .= $this->_addInput('MERCHANT', $this->_merchantId);
		$this->_htmlFormCode .= $this->_addInput('ORDER_HASH', $this->_HASH);

        $this->_htmlFormCode .= $this->_addInput('BACK_REF', $this->_BackRef); 
	
		$this->_htmlFormCode .= $this->_addInput('LANGUAGE', $this->_Language);
        $this->_htmlFormCode .= $this->_addInput('ORDER_REF',  $this->_OrderRef);
        $this->_htmlFormCode .= $this->_addInput('INSTALLMENT_OPTIONS', $this->_Instalment);
        $this->_htmlFormCode .= $this->_addInput('ORDER_DATE', $this->_OrderDate);
        $this->_htmlFormCode .= $this->_addInput('DESTINATION_CITY', isset($this->_destinationAddress->city) ? $this->_destinationAddress->city : '');
        $this->_htmlFormCode .= $this->_addInput('DESTINATION_STATE', (empty($this->_destinationAddress->state) ? "" : $this->_destinationAddress->state));
		$this->_htmlFormCode .= $this->_addInput('DESTINATION_COUNTRY', isset($this->_destinationAddress->countryCode) ? $this->_destinationAddress->countryCode : '');
        $this->_htmlFormCode .= $this->_addInput('ORDER_SHIPPING', $this->_OrderShipping);

        $this->_htmlFormCode .= $this->_addInput('BILL_FNAME', $this->_billingAddress->firstName); 
        $this->_htmlFormCode .= $this->_addInput('BILL_LNAME', $this->_billingAddress->lastName); 
        $this->_htmlFormCode .= $this->_addInput('BILL_CISERIAL', $this->_billingAddress->ciSerial);
        $this->_htmlFormCode .= $this->_addInput('BILL_CNP', $this->_billingAddress->cnp);
        $this->_htmlFormCode .= $this->_addInput('BILL_COMPANY', $this->_billingAddress->company);
        $this->_htmlFormCode .= $this->_addInput('BILL_FISCALCODE', $this->_billingAddress->fiscalCode);
        $this->_htmlFormCode .= $this->_addInput('BILL_REGNUMBER', $this->_billingAddress->regNumber);
        $this->_htmlFormCode .= $this->_addInput('BILL_BANK', $this->_billingAddress->bank);
        $this->_htmlFormCode .= $this->_addInput('BILL_BANKACCOUNT', $this->_billingAddress->bankAccount);
        $this->_htmlFormCode .= $this->_addInput('BILL_EMAIL', $this->_billingAddress->email);
        $this->_htmlFormCode .= $this->_addInput('BILL_PHONE', $this->_billingAddress->phone);
        $this->_htmlFormCode .= $this->_addInput('BILL_FAX', $this->_billingAddress->fax);
        $this->_htmlFormCode .= $this->_addInput('BILL_ADDRESS', $this->_billingAddress->address);
        $this->_htmlFormCode .= $this->_addInput('BILL_ADDRESS2', $this->_billingAddress->address2);
        $this->_htmlFormCode .= $this->_addInput('BILL_ZIPCODE', $this->_billingAddress->zipCode);
        $this->_htmlFormCode .= $this->_addInput('BILL_CITY', $this->_billingAddress->city);
        $this->_htmlFormCode .= $this->_addInput('BILL_STATE', $this->_billingAddress->state);
        $this->_htmlFormCode .= $this->_addInput('BILL_COUNTRYCODE', $this->_billingAddress->countryCode);

        $this->_htmlFormCode .= $this->_addInput('DELIVERY_FNAME', $this->_deliveryAddress->firstName);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_LNAME', $this->_deliveryAddress->lastName);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_CISERIAL', $this->_deliveryAddress->ciSerial);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_CNP', $this->_deliveryAddress->cnp);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_COMPANY', $this->_deliveryAddress->company);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_FISCALCODE', $this->_deliveryAddress->fiscalCode);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_REGNUMBER', $this->_deliveryAddress->regNumber);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_BANK', $this->_deliveryAddress->bank);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_BANKACCOUNT', $this->_deliveryAddress->bankAccount);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_EMAIL', $this->_deliveryAddress->email);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_PHONE', $this->_deliveryAddress->phone);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_FAX', $this->_deliveryAddress->fax);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_ADDRESS', $this->_deliveryAddress->address);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_ADDRESS2', $this->_deliveryAddress->address2);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_ZIPCODE', $this->_deliveryAddress->zipCode);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_CITY', $this->_deliveryAddress->city);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_STATE', $this->_deliveryAddress->state);
        $this->_htmlFormCode .= $this->_addInput('DELIVERY_COUNTRYCODE', $this->_deliveryAddress->countryCode);

        $this->_htmlFormCode .= $this->_addInput('DISCOUNT', $this->_Discount);
        $this->_htmlFormCode .= $this->_addInput('PAY_METHOD', $this->_PayMethod);

        $productIterator = 0;
		foreach ($this->_tempProds as $prodCode => $product)
		{
            $this->_htmlFormCode .=$this->_addInput('ORDER_PNAME[' . $productIterator . ']', $product['prodName']);
            $this->_htmlFormCode .=$this->_addInput('ORDER_PCODE[' . $productIterator . ']', $prodCode);
            $this->_htmlFormCode .=$this->_addInput('ORDER_PINFO[' . $productIterator . ']', (empty($product['prodInfo']) ? '' : $product['prodInfo']));
            $this->_htmlFormCode .=$this->_addInput('ORDER_PRICE[' . $productIterator . ']', $product['prodPrice']);
            $this->_htmlFormCode .=$this->_addInput('ORDER_QTY[' . $productIterator . ']', $product['prodQuantity']);
            $this->_htmlFormCode .=$this->_addInput('ORDER_VAT[' . $productIterator . ']', $product['prodVat']);
            $this->_htmlFormCode .=$this->_addInput('ORDER_PRICE_TYPE[' . $productIterator . ']', $product['prodPriceType']);
	    	$this->_htmlFormCode .=$this->_addInput('LU_COMPLEX_PDISCOUNT_PERC[' . $productIterator . ']', 
		    (empty($product['discount']) ? '' : $product['discount']));

	    	foreach ($product['customFields'] as $customFieldName => $customFieldValue)
	    	{
                $this->_htmlFormCode .=$this->_addInput('ORDER_PCUSTOMFIELD[' . $productIterator . '][' . $customFieldName . ']', $customFieldValue);
            }
            $productIterator++;
        }

        $this->_htmlFormCode .= $this->_addInput('PRICES_CURRENCY', $this->_PriceCurrency);
        $this->_htmlFormCode .= $this->_addInput('CURRENCY', isset($this->_Currencyi) ? $this->_Currencyi : ''); 
        $this->_htmlFormCode .= $this->_addInput('DEBUG', "TRUE");
        $this->_htmlFormCode .= $this->_addInput('TESTORDER', $this->_TestMode);
        $this->_htmlFormCode .= $this->_addInput('AUTOMODE', "1");
        $this->_htmlFormCode .= $this->_addInput('ORDER_TIMEOUT', isset($this->_OrderTimeout) ? $this->_OrderTimeout : '');
        $this->_htmlFormCode .= $this->_addInput('TIMEOUT_URL', isset($this->_OrderTimeoutUrl) ? $this->_OrderTimeoutUrl : '');

		foreach ($this->_customFields as $customFieldName => $customFieldValue)
		{
            $this->_htmlFormCode .=$this->_addInput(strtoupper($customFieldName), $customFieldValue);
    	}
    }

    private function _makeForm($autoSubmit=FALSE)
    {
        $this->_htmlCode .= '<form action="' . $this->_luQueryUrl . '" method="POST" id="payForm" name="payForm">' . "\n";
        $this->_htmlCode .=$this->_htmlFormCode;
        $this->_htmlCode .= '</form>';

        if ($autoSubmit === TRUE) {
            $this->_htmlCode .= "
                    <script>
                    document.payForm.submit();
                    </script>
                    ";
        }
        
    }

	private function _addHashValue($string, $name='')
	{
		return strlen($string).$string;
	}

    private function _makeHashString($ctrl = false)
    {
        $finalPriveType = '';
        $this->_hashString = '';

    	if ($ctrl) {
        	$this->_hashString .= $this->_addHashValue($this->_BackRef, 'BACK_REF');
        	return;
    	}

        $this->_hashString .= $this->_addHashValue($this->_merchantId, 'MerchantId');
        $this->_hashString .= $this->_addHashValue($this->_OrderRef, 'OrderRef');
        $this->_hashString .= $this->_addHashValue($this->_OrderDate, 'OrderDate');

        foreach ($this->_allProducts as $product) {
            $tempProd['prodName'] = $product->productName;
            $tempProd['prodInfo'] = $product->productInfo;
            $tempProd['prodPrice'] = $product->productPrice;
            $tempProd['prodQuantity'] = $product->productQuantity;
            $tempProd['prodVat'] = $product->productVat;
            $tempProd['prodPriceType'] = $product->productPriceType;
            $tempProd['customFields'] = $product->customFields;
            $tempProd['discount'] = $product->Discount;

            if (!empty($tempProds[$product->productCode]['prodQuantity'])) {
                if ($tempProds[$product->productCode]['prodPrice'] != $product->productPrice) {
                    $tempProds[$product->productCode] = $tempProd;
                } else {
                    $tempProds[$product->productCode]['prodQuantity']+=$product->productQuantity;
                }
            } else {
                $tempProds[$product->productCode] = $tempProd;
            }
        }

        $prodNames = '';
        $prodInfo = '';
        $prodPrice = '';
        $prodQuantity = '';
        $prodVat = '';
        $prodCodes = '';
        $finalPriveType = '';
        $finalPercDiscount = '';

        $iterator = 0;
        foreach ($tempProds as $prodCode => $product) {
            $prodNames .= $this->_addHashValue($product['prodName'], 'ProductName[' . $iterator . ']');
            $prodInfo .= $this->_addHashValue((empty($product['prodInfo']) ? '' : $product['prodInfo']), 'ProductInfo[' . $iterator . ']');
            $prodPrice .= $this->_addHashValue($product['prodPrice'], 'ProductPrice[' . $iterator . ']');
            $prodQuantity .= $this->_addHashValue($product['prodQuantity'], 'ProductQuality[' . $iterator . ']');
            $prodVat .= $this->_addHashValue($product['prodVat'], 'ProductVat[' . $iterator . ']');
            $prodCodes .= $this->_addHashValue($prodCode, 'ProductCode[' . $iterator . ']');
            $finalPriveType .= $this->_addHashValue((empty($product['prodPriceType']) ? '' : $product['prodPriceType']), 'ProductPriceType[' . $iterator . ']');
            $finalPercDiscount .= $this->_addHashValue((empty($product['discount']) ? '' : $product['discount']), 'ProductPercDiscount[' . $iterator . ']');
            $iterator++;
        }

        $this->_hashString .=$prodNames;
        $this->_hashString .=$prodCodes;
        $this->_hashString .=$prodInfo;
        $this->_hashString .=$prodPrice;
        $this->_hashString .=$prodQuantity;
        $this->_hashString .=$prodVat;        
        $this->_tempProds = $tempProds;
        
        $this->_hashString .= $this->_addHashValue(($this->checkEmptyVar($this->_OrderShipping) ? '' : $this->_OrderShipping), 'OrderShipping');
        $this->_hashString .= $this->_addHashValue(($this->checkEmptyVar($this->_PriceCurrency) ? '' : $this->_PriceCurrency), 'PriceCurrency');
        $this->_hashString .= $this->_addHashValue((empty($this->_Discount) ? '' : $this->_Discount), 'Discount');
        $this->_hashString .= $this->_addHashValue((empty($this->_destinationAddress->city) ? '' : $this->_destinationAddress->city), 'DestinationCity');
        $this->_hashString .= $this->_addHashValue((empty($this->_destinationAddress->state) ? '' : $this->_destinationAddress->state), 'DestinationState');
		$this->_hashString .= $this->_addHashValue((empty($this->_destinationAddress->countryCode) ? '' : $this->_destinationAddress->countryCode),
		'DestinationCountryCode');
        $this->_hashString .= $this->_addHashValue((empty($this->_PayMethod) ? '' : $this->_PayMethod), 'PayMethod');
        $this->_hashString .= $finalPriveType;
        $this->_hashString .= $finalPercDiscount;
        $this->_hashString .= $this->_addHashValue((empty($this->_Instalment) ? '' : $this->_Instalment), 'Instalment');

        $this->_htmlHashString = $this->_hashString;
        $this->_hashString = strip_tags($this->_hashString);

        
    }

    private function checkEmptyVar($string)
    {
        return (strlen(trim($string)) == 0);
    }

    private function _makeHash()
    {
        $this->_HASH = self::generateHmac($this->_secretKey, $this->_hashString);
    }

    public function setAutoMode()
    {
        $this->_AutoMode = 1;
    }

    public function setOrderShipping($val)
    {
        if (!empty($val) && ($val < 0 || !is_numeric($val))) {
        }		
        $this->_OrderShipping = $val;
        
    }	

    public function setTestMode()
    {
        $this->_TestMode = TRUE;
        
    }

    public function setGlobalDiscount($discount)
    {
        $this->_Discount = $discount;
        
    }

    public function setInstalments($Instalment)
    {
        $this->_Instalment = $Instalment;
        
    }

    public function setLanguage($lang)
    {
        $this->_Language = $lang;
        
    }

    public function setOrderRef($refno)
    {
        $this->_OrderRef = $refno;
        
    }

    public function setOrderDate($date) {
        $this->_OrderDate = $date;
    } 

    private function _setOrderDate()
    {
        $this->_OrderDate = date('Y-m-d H:i:s', time());
        
    }

    public function setPayMethod($payMethod) {
        $this->_PayMethod = $payMethod;
        
    }

    public function setPaymentCurrency($currency) {
        $this->_PriceCurrency = $currency;
        
    }

    public function setCurrency($currency) {
        $this->_Currency = $currency;
        
    }

    public function setOrderTimeout($timeout) {
        $this->_OrderTimeout = $timeout;
        
    }

    public function setTimeoutUrl($url) {
        $this->_OrderTimeoutUrl = $url;
        
    }

    public function setBackRef($url) {
        $this->_BackRef = $url;
        
    }

    public function setTrace() {
        $this->_Debug = 1;
        
    }

    public function addCustomField($fieldName, $fieldValue) {
        if (!$fieldName) {
            return 0;
        }
        $this->_customFields[$fieldName] = $fieldValue;
        
    }

    public function setDebug($debugLevel) {
        $this->_debugLevel = $debugLevel;
        
    }

    public function setQueryUrl($url) {
        $this->_luQueryUrl = $url;
        
    }

    public function setButtonName($val) {
        $this->_btnName = $val;
        
    }	
    

    private function _addInput($string, $value)
    {
        return '<input type="hidden" name="' . strtoupper($string) . '" value="' . htmlentities($value, ENT_COMPAT, 'UTF-8') . '"/>' . "\n";
    }

    public static function generateHmac($key, $data)
    {
        $b = 64; // byte length for md5
        if (strlen($key) > $b) {
            $key = pack("H*", md5($key));
        }
        $key = str_pad($key, $b, chr(0x00));
        $ipad = str_pad('', $b, chr(0x36));
        $opad = str_pad('', $b, chr(0x5c));
        $k_ipad = $key ^ $ipad;
        $k_opad = $key ^ $opad;
        return md5($k_opad . pack("H*", md5($k_ipad . $data)));
    }

}

//Product class
class PayuProduct {
    const DEBUG_NONE='0';
    const DEBUG_ALL='9999';
    const DEBUG_ERROR='2';
    const DEBUG_WARNING='1';

    const PRICE_TYPE_GROSS = 'GROSS'; // price includes VAT
    const PRICE_TYPE_NET = 'NET';   // price does not include VAT

    const PAY_OPTION_VISA = 'VISA';
    const PAY_OPTION_MASTERCARD = 'MASTERCARD';
    const PAY_OPTION_MAESTRO = 'MAESTRO';
    const PAY_OPTION_VISA_ELECTRON = 'VISA ELECTRON';
    const PAY_OPTION_ALL = 'ALL';

    const PAY_METHOD_CCVISAMC = 'CCVISAMC';
  
    public $productName = '';
    public $productCode = '';
    public $productInfo = '';
    public $productPrice = '';
    public $productPriceType = '';
    public $productQuantity = '';
    public $productVat = '';
    public $Discount = '';
    public $customFields = array();
    private $_errorLog = array();

    function __construct($productName='', $productCode='', $productInfo='', $productPrice='', $productPriceType='', $productQuantity='', $productTax='')
    {
        $this->setName($productName);
        $this->setCode($productCode);
        $this->setInfo($productInfo);
        $this->setPrice($productPrice);
        $this->setPriceType($productPriceType);
        $this->setQuantity($productQuantity);
        $this->setTax($productTax);

        
    }

    public function addCustomField($fieldName, $fieldValue)
    {
        if (!$fieldName) {
            return 0;
        }
        $this->customFields[$fieldName] = $fieldValue;
        
    }

    public function setName($productName)
    {
        $this->productName = $productName;
        
    }

    public function setCode($setCode)
    {
        $this->productCode = $setCode;
        
    }

    public function setInfo($productInfo)
    {
        $this->productInfo = $productInfo;
        
    }

    public function setPrice($productPrice)
    {
        $this->productPrice = $productPrice;
        
    }

    public function setPriceType($productPriceType)
    {
        $this->productPriceType = $productPriceType;
        
    }

    public function setQuantity($productQuantity)
    {
        $this->productQuantity = $productQuantity;
        
    }

    public function setTax($productVat)
    {
        $this->productVat = $productVat;
        
    }
}

class PayuAddress {
    const DEBUG_NONE='0';
    const DEBUG_ALL='9999';
    const DEBUG_ERROR='2';
    const DEBUG_WARNING='1';

    public $firstName;
    public $lastName;
    public $ciSerial;
    public $ciNumber;
    public $ciIssuer;
    public $cnp;
    public $company;
    public $fiscalCode;
    public $regNumber;
    public $bank;
    public $bankAccount;
    public $email;
    public $phone;
    public $fax;
    public $address;
    public $address2;
    public $zipCode;
    public $city;
    public $state;
    public $countryCode;
    private $_errorLog = array();

    function __construct($firstName='', $lastName='', $ciSerial='', $ciNumber='', $ciIssuer='', $cnp='', $company='', $fiscalCode='', $regNumber='', $bank='', $bankAccount='', $email='', $phone='', $fax='', $address='', $address2='', $zipCode='', $city='', $state='', $countryCode='') {
        if (!empty($firstName))
            $this->setFirstName($firstName);

        if (!empty($lastName))
            $this->setLastName($lastName);

        if (!empty($ciSerial))
            $this->setCiSerial($ciSerial);

        if (!empty($ciNumber))
            $this->setCiNumber($ciNumber);

        if (!empty($ciIssuer))
            $this->setCiIssuer($ciIssuer);

        if (!empty($cnp))
            $this->setCnp($cnp);

        if (!empty($company))
            $this->setCompany($company);

        if (!empty($fiscalCode))
            $this->setFiscalCode($fiscalCode);

        if (!empty($regNumber))
            $this->setRegNumber($regNumber);

        if (!empty($bank))
            $this->setBank($bank);

        if (!empty($bankAccount))
            $this->setBankAccount($bankAccount);

        if (!empty($email))
            $this->setEmail($email);

        if (!empty($phone))
            $this->setPhone($phone);

        if (!empty($fax))
            $this->setFax($fax);

        if (!empty($address))
            $this->setAddress($address);

        if (!empty($address2))
            $this->setAddress2($address2);

        if (!empty($zipCode))
            $this->setZipCode($zipCode);

        if (!empty($city))
            $this->setCity($city);

        if (!empty($state))
            $this->setState($state);

        if (!empty($countryCode))
            $this->setCountryCode($countryCode);

        
    }

    public function setFirstName($firstName) {
        $this->firstName = $firstName;
        
    }

    public function setLastName($lastName) {
        $this->lastName = $lastName;
        
    }

    public function setCiSerial($ciSerial) {
        $this->ciSerial = $ciSerial;
        
    }

    public function setCiNumber($ciNumber) {
        $this->ciNumber = $ciNumber;
        
    }

    public function setCiIssuer($ciIssuer) {
        $this->ciIssuer = $ciIssuer;
        
    }

    public function setCnp($cnp) {
        $this->cnp = $cnp;
        
    }

    public function setCompany($company) {
        $this->company = $company;
        
    }

    public function setFiscalCode($fiscalCode) {
        $this->fiscalCode = $fiscalCode;
        
    }

    public function setRegNumber($regNumber) {
        $this->regNumber = $regNumber;
        
    }

    public function setBank($bank) {
        $this->bank = $bank;
        
    }

    public function setBankAccount($bankAccount) {
        $this->bankAccount = $bankAccount;
        
    }

    public function setEmail($email) {
        $this->email = $email;
        
    }

    public function setPhone($phone) {
        $this->phone = $phone;
        
    }

    public function setFax($fax) {
        $this->fax = $fax;
        
    }

    public function setAddress($address) {
        $this->address = $address;
    }

    public function setAddress2($address2) {
        $this->address2 = $address2;
    }

    public function setZipCode($zipCode) {
        $this->zipCode = $zipCode;
        
    }

    public function setCity($City) {
        $this->city = $City;
        
    }

    public function setState($State) {
        $this->state = $State;
        
    }

    public function setCountryCode($CountryCode) {
        $this->countryCode = $CountryCode;
        
    }
}