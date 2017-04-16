<?php 

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu_params' and `key` = 'params'";
$query['pavmegamenu'][] =  " 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(0, 0, 'pavmegamenu_params', 'pavmegamenu_params', '[{\"submenu\":1,\"id\":40,\"align\":\"aligned-left\",\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"submenu\":1,\"subwidth\":1170,\"id\":2,\"align\":\"aligned-fullwidth\",\"group\":0,\"cols\":3,\"rows\":[{\"cols\":[{\"widgets\":\"wid-26\",\"colwidth\":3},{\"widgets\":\"wid-27\",\"colwidth\":3},{\"widgets\":\"wid-28\",\"colwidth\":3},{\"widgets\":\"wid-29\",\"colwidth\":3}]}]},{\"submenu\":1,\"id\":5,\"align\":\"aligned-fullwidth\",\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-30\",\"colwidth\":3},{\"widgets\":\"wid-34|wid-35\",\"colwidth\":6},{\"widgets\":\"wid-32\",\"colwidth\":3}]}]},{\"submenu\":1,\"subwidth\":700,\"id\":52,\"align\":\"aligned-left\",\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-64\",\"colwidth\":6},{\"widgets\":\"wid-65\",\"colwidth\":6}]}]},{\"submenu\":1,\"id\":49,\"align\":\"aligned-fullwidth\",\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-48\",\"colwidth\":6},{\"widgets\":\"wid-51\",\"colwidth\":6}]}]},{\"id\":50,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":58,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);
"; 

$query['pavverticalmenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavverticalmenu_params' and `key` = 'params'";
$query['pavverticalmenu'][] =" 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(0, 0, 'pavverticalmenu_params', 'params', '[{\"id\":40,\"group\":0,\"cols\":1,\"subwidth\":700,\"submenu\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-30\",\"colwidth\":4},{\"widgets\":\"wid-31\",\"colwidth\":4},{\"widgets\":\"wid-32\",\"colwidth\":4}]},{\"cols\":[{\"widgets\":\"wid-33\",\"colwidth\":12}]}]},{\"submenu\":1,\"subwidth\":700,\"id\":44,\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-11|wid-34|wid-36\",\"colwidth\":8},{\"widgets\":\"wid-35\",\"colwidth\":4,\"colclass\":\"sidebar\"}]}]},{\"id\":3,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":26,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":13,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":28,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);
";

$query['pavblog'][] ="INSERT INTO `".DB_PREFIX ."layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES(33, 14, 0,'pavblog/%');";
$query['pavblog'][] ="INSERT INTO `".DB_PREFIX ."layout` (`layout_id`, `name`) VALUES(14, 'Pav Blog');";

?>