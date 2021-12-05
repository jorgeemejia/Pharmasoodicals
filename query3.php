<!-- TODO: Include header file -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link href="kanika-style.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
img.one {
  height: 10%;
  width: 100%;
}

img.two {
  height: 10%;
  width: 60%;
}
.style3 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style></head>

<head>
<h1><center> Welcome to CPSC 332 </center> </h1></head>
<hr><b><center>ABOUT THE WEBSITE</center></b><hr>
<center> <p><b> Assignment 4 </center>
</b>
<body>
<table width="1350" border="0" align="center" cellpadding="0" cellspacing="0">

  <tr>
    <td colspan="2"><img class = "one" src="images/sunset.jpg" width="100" height="230" /></td>
  </tr>
  <tr>
    <td colspan="2" bgcolor="#DBE2E8"><strong>&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; <a href="query1.php">Current and Previous rentals</a>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;   </strong><strong> <a href="query3.php">Pay owed to employees</a>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp;
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;    <a href="query2.php"> Customer with most rentals</a>  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;<a href="starter.php">Home</a>   </strong></td>
  </tr>
</table>

</body>
</html>

<html>
<head>
<body bgcolor="FFCCCC">
<hr>







<?php
$servername = "localhost";
$username = "root";
$password = "";
$database_name = "bighitvideo";

$link = mysqli_connect($servername, $username, $password, $database_name);

if(!$link){
    die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";

$sql = "";
        
$result = mysqli_query($link,$sql);
print "<pre>";
print "<table border=1>";
print "<tr><td>SSN </td><td> Amount_Owed </td>";
while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
{
print "\n";
print "<tr><td>$row[SSN] </td><td> $row[Amount_Owed]  </td></tr>	";
}
print "</table>";
print "</pre>";
mysqli_free_result($result);
mysqli_close($link);
?>
</center>
