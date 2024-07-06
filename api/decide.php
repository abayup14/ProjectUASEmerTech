<?php
header("Access-Control-Allow-Origin: *");
 $arr=null;
 $conn = new mysqli("localhost", "flutter_160421058", "ubaya", "flutter_160421058");
 if($conn->connect_error) {
  $arr= ["result"=>"error","message"=>"unable to connect"];
 }
 extract($_POST);
//setelah koneksi DB  extract($_POST);
  $sql="update animals set status= 'adopted' ,adopter_id=? where id = ?";
  $stmt=$conn->prepare($sql);
  $stmt->bind_param("ii",$adopter_id,$animal_id);
  $stmt->execute();
  $sql="update users_animals set status='denied' where animals_id = ?";
  $stmt=$conn->prepare($sql);
  $stmt->bind_param("i",$animal_id);
  $stmt->execute();
  $sql="update users_animals set status='accepted' where users_id = ? and animals_id = ?";
  $stmt=$conn->prepare($sql);
  $stmt->bind_param("ii",$adopter_id,$animal_id);
  $stmt->execute();
  if ($stmt->affected_rows > 0) {
    $arr=["result"=>"success","id"=>$conn->insert_id];
  } else {
    $arr=["result"=>"fail","Error"=>$conn->error];
  }
  echo json_encode($arr);
?>