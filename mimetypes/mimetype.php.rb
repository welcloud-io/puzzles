<?php
//get data,treat extremes
fscanf(STDIN, "%d", $N);
fscanf(STDIN, "%d", $Q);
$assoc=array();
for($i=0;$i<$N;$i++){
    fscanf(STDIN,"%s %s",$ext,$mime);
    $assoc[strtolower($ext)]=$mime;

}

$files=array();
for($i=0;$i<$Q;$i++){
    fscanf(STDIN,"%s",$files[]);

}

//logic begins
foreach($files as $file){
    //get extenstion
    $arr=explode('.',$file);
    if(sizeof($arr)>1)
    $ext=strtolower($arr[sizeof($arr)-1]);
    else {echo "UNKNOWN\n"; continue;}
    //
    if(array_key_exists($ext,$assoc)){
        echo $assoc[$ext]."\n";
        
    }else echo "UNKNOWN\n";
}


?>