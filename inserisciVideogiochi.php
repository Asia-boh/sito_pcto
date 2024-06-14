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

$cnPDO->beginTransaction();

try {

    $titolo = $_POST["titolo"];
    $genere = $_POST["genere"];
    $data_rilascio = $_POST["data_rilascio"];

    $sql = "INSERT INTO Videogiochi(TITOLO, GENERE, DATA_RILASCIO) VALUES (:titolo, :genere, :data_rilascio)";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("titolo", $titolo, PDO::PARAM_STR);
    $sth->bindValue("genere", $genere, PDO::PARAM_STR);
    $sth->bindValue("data_rilascio", $data_rilascio, PDO::PARAM_STR);
    $sth->execute();

    $id_videogioco = $cnPDO->lastInsertId();
    $id_utente = $_SESSION["utente_loggato"]["ID"];

    $sql = "INSERT INTO Utenti_Videogiochi(ID_VIDEOGIOCO, ID_UTENTE) VALUES (:id_videogioco, :id_utente)";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("id_videogioco", $id_videogioco, PDO::PARAM_INT);
    $sth->bindValue("id_utente", $id_utente, PDO::PARAM_INT);
    $sth->execute();

    $cnPDO->commit();
} catch (\Throwable $th) {
}

$arrayCompleto = $sth->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($arrayCompleto);
