<?php 

$json = file_get_contents('last_year.json');
$decoded_json = json_decode($json, true);
$indice = 0;

// dias del año
$nuevoArray = array_fill(0, 365, 0);
$inicioAnio = 0;
$finAnio = 365;

for ($i = 0; $i < count($decoded_json); $i++) {
    $dia = $decoded_json[$i][0];
    $diasFuera = $decoded_json[$i][1];

    if($diasFuera > $finAnio ){
        $diasSiguientes = $diasFuera - $finAnio;

        //calculo de dias del año vigente
        for ($j = $dia; $j < $finAnio; $j++) {
            $nuevoArray[$j] += 1;
        }

        //calculo de dias del año siguiente
        for ($j = $inicioAnio; $j < $diasSiguientes; $j++) {
            $nuevoArray[$j] += 1;
        }

    } else {
        for ($j = $dia; $j < $diasFuera; $j++) {
            $nuevoArray[$j] += 1;
        }   
    }
}

// eliminar enero
for($i=0;$i<= 30;$i++){
    unset($nuevoArray[$i]);
}

// eliminar diciembre
for($i=334;$i<= 364;$i++){
    unset($nuevoArray[$i]);
}


function minimo ($posicionInicioAnio,$array){
    $min = $array[$posicionInicioAnio];
    $mes = 0;
    foreach($array as $key => $value) {    
        if($min > $value) {
            $min = $value; 
            $mes = $key;
        }
    }
    print "el dia con menos avistamiento de titantes fue $mes con un valor de $min";
}

echo '<pre>';
echo minimo(31, $nuevoArray);
echo '</pre>';
?>
