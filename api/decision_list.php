<?php
 header("Access-Control-Allow-Origin: *");
 extract($_POST);
 $arr=null;
 $conn = new mysqli("localhost", "flutter_160421058", "ubaya", "flutter_160421058");
 if($conn->connect_error) {
  $arr= ["result"=>"error","message"=>"unable to connect"];
 }
 $sql = "SELECT users_animals.*,users.fullname FROM `users_animals` inner join `users` on users_animals.users_id=users.id WHERE animals_id = ?";
 $stmt = $conn->prepare($sql);
 $stmt->bind_param("i",$animal_id);
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