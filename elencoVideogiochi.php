
<?php
session_start();
$id = $_SESSION["utente_loggato"]["ID"];
$dns = "mysql:dbname=db_asia;host=10.0.0.35;";
$username = "asia";
$password = "asia";

$cnPDO = new PDO($dns, $username, $password);
$cnPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = "SELECT v.TITOLO, v.GENERE, v.DATA_RILASCIO FROM Utenti_Videogiochi uv INNER JOIN Videogiochi v ON v.ID = uv.ID_VIDEOGIOCO WHERE :id = ID_UTENTE ORDER BY v.titolo";
$sth = $cnPDO->prepare($sql);
$sth->bindValue("id", $id, PDO::PARAM_INT);
$sth->execute();

// if($sth->rowCount() == 0){
//     throw new Exception("Email e password non corrispondono", 1);
// }

$arrayCompleto = $sth->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($arrayCompleto);

// while ($row = $sth->fetch(PDO::FETCH_ASSOC)) {
//     # code...
// }