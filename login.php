<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
session_start();
$dns = "mysql:dbname=db_asia;host=10.0.0.35;";
$username = "asia";
$password = "asia";

$cnPDO = new PDO($dns, $username, $password);
$cnPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// $cnPDO->beginTransaction();

try {
    //code...
    $email = $_POST["email"];
    $password = $_POST["password"];
    $sql = "SELECT ID, EMAIL, PASSWORD FROM Utenti WHERE EMAIL = :email AND PASSWORD = :password";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("email", $email, PDO::PARAM_STR);
    $sth->bindValue("password", $password, PDO::PARAM_STR);
    $sth->execute();
    if ($sth->rowCount() == 0) {
        throw new Exception("Email e password non corrispondono", 1);
    }
    $utente = $sth->fetch(PDO::FETCH_ASSOC);
    // $cnPDO->commit();
    $_SESSION["utente_loggato"] = $utente;
    // $_SESSION["utente_loggato"]["ID"]
    $msg = "OK";
} catch (\Throwable $th) {
    //throw $th;
    // $cnPDO->rollBack();
    $msg = "KO";
}

$arrayrisposta = array("msg" => $msg, "esito" => true);
echo json_encode($arrayrisposta);
