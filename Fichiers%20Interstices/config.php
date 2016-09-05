<?php
//require_once(dirname(__FILE__)."/HALSolr.php");


//Infos pour l'accès à Solr
$ENDPOINTS_RESPONDER['HOST'] = "ccsdsolrvip.in2p3.fr";
$ENDPOINTS_RESPONDER['PORT'] = 8080;
$ENDPOINTS_RESPONDER['PATH'] = "/solr";
$ENDPOINTS_RESPONDER['TIMOUT'] = 20;
$ENDPOINTS_RESPONDER['USERNAME'] = "ccsd";
$ENDPOINTS_RESPONDER['PASSWORD'] = "ccsd12solr41";
//url Solr pour accéder aux référentiels et aux doc
//en prod
//$ENDPOINTS_RESPONDER['URL_SOLR_REF'] = "http://api.archives-ouvertes.fr/ref";
//$ENDPOINTS_RESPONDER['URL_SOLR_DOC_API'] = "http://api.archives-ouvertes.fr/search/index"; //via API
//$ENDPOINTS_RESPONDER['URL_SOLR_DOC_SOLR'] = "http://api.archives-ouvertes.fr/search/index"; //via API
//$SWORD_API_URL= 'https://api.archives-ouvertes.fr/sword/inria';

//en preprod
$ENDPOINTS_RESPONDER['URL_SOLR_REF'] = "'http://api-preprod.archives-ouvertes.fr'";
$ENDPOINTS_RESPONDER['URL_SOLR_DOC_API'] = "http://api-preprod.archives-ouvertes.fr/search/index"; //via API
$ENDPOINTS_RESPONDER['URL_SOLR_DOC_SOLR'] = "'http://api-preprod.archives-ouvertes.fr/search/index'"; //via SOLR
$SWORD_API_URL= 'https://api-preprod.archives-ouvertes.fr/sword/inria';


