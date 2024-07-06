<?php
header("Access-Control-Allow-Origin: *");
 $arr=null;
 $conn = new mysqli("localhost", "flutter_160421058", "ubaya", "flutter_160421058");
 if($conn->connect_error) {
  $arr= ["result"=>"error","message"=>"unable to connect"];
 }
 extract($_POST);
//setelah koneksi DB  extract($_POST);
  $sql="INSERT INTO animals(jenis_hewan,nama_hewan,foto,keterangan,owner_id) VALUES(?,?,?,?,?)";
  $stmt=$conn->prepare($sql);
  $stmt->bind_param("sssi",$jenis,$nama,$url,$keterangan,$owner_id);
  $stmt->execute();
  $aid = $conn->insert_id;
  if ($stmt->affected_rows > 0) {
    $arr=["result"=>"success","id"=>$conn->insert_id];
  } else {
    $arr=["result"=>"fail","Error"=>$conn->error];
  }
  echo json_encode($arr);
?>