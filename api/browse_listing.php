<?php
 header("Access-Control-Allow-Origin: *");
 $arr=null;
 $conn = new mysqli("localhost", "flutter_160421058", "ubaya", "flutter_160421058");
 if($conn->connect_error) {
  $arr= ["result"=>"error","message"=>"unable to connect"];
 }
 $sql = "SELECT * FROM animals where status = 'available'";
 $stmt = $conn->prepare($sql);
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