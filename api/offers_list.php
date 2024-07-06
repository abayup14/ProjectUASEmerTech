<?php
 header("Access-Control-Allow-Origin: *");
 extract($_POST);
 $arr=null;
 $conn = new mysqli("localhost", "flutter_160421058", "ubaya", "flutter_160421058");
 if($conn->connect_error) {
  $arr= ["result"=>"error","message"=>"unable to connect"];
 }
 $sql = "SELECT animals.*, count(users_animals.users_id) as propose_count FROM animals LEFT JOIN users_animals on animals.id=users_animals.animals_id WHERE owner_id = ? GROUP BY animals.id, animals.jenis_hewan, animals.nama_hewan, animals.foto,animals.keterangan,animals.status,animals.owner_id,animals.adopter_id";
 $stmt = $conn->prepare($sql);
 $stmt->bind_param("i",$owner_id);
 $stmt->execute();
 $result = $stmt->get_result();
 $data=[];
 if ($result->num_rows > 0) {
  while($r=$result->fetch_assoc())
  {
    array_push($data,$r);
  }
  $arr=["result"=>"success","data"=>$data];
 } else {
  $arr= ["result"=>"error","message"=>"sql error: $sql"];
 }
 echo json_encode($arr);
 $stmt->close();
 $conn->close();