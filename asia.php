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

// echo "variabili passate in GET<br>";
// var_dump($_GET);
// echo "<br><br>";
// echo "variabili passate in POST<br>";
// var_dump($_POST);

// TODO far partire la transazione

$cnPDO->beginTransaction();
try {

    // TODO inserire dati in Anagrafica

    $nome = $_POST["nome"];
    $cognome = $_POST["cognome"];
    $sesso = $_POST["sesso"];
    $data_nascita = $_POST["data_nascita"];
    $codice_fiscale = $_POST["codice_fiscale"];
    $username = $_POST["username"];
    $email = $_POST["email"];
    $password = $_POST["password"];

    //query controllo email

    $sql = "SELECT EMAIL FROM Utenti WHERE EMAIL = :email";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("email", $email, PDO::PARAM_STR);
    $sth->execute();
    if ($sth->rowCount() != 0) {
        throw new Exception("Email già presente", 1);
    }

    //query per inserire in anagrafica

    $sql = "INSERT INTO Anagrafica(NOME, COGNOME, SESSO, NASCITA, CODICE_FISCALE) VALUES (:nome, :cognome, :sesso, :data_nascita, :codice_fiscale)";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("nome", $nome, PDO::PARAM_STR);
    $sth->bindValue("cognome", $cognome, PDO::PARAM_STR);
    $sth->bindValue("sesso", $sesso);
    $sth->bindValue("data_nascita", $data_nascita);
    $sth->bindValue("codice_fiscale", $codice_fiscale);
    $sth->execute();
    $id_anagrafica = $cnPDO->lastInsertId();

    //query per inserire in utenti

    $sql = "INSERT INTO Utenti(USERNAME, EMAIL, PASSWORD, ID_ANAGRAFICA) VALUES (:username, :email, :password, :id_anagrafica)";
    $sth = $cnPDO->prepare($sql);
    $sth->bindValue("username", $username, PDO::PARAM_STR);
    $sth->bindValue("email", $email, PDO::PARAM_STR);
    $sth->bindValue("password", $password, PDO::PARAM_STR);
    $sth->bindValue("id_anagrafica", $id_anagrafica, PDO::PARAM_INT);
    $sth->execute();

    //commit

    $cnPDO->commit();
    //echo "<br><br>commit";
    $msg = "OK";

    $utente = $sth->fetch(PDO::FETCH_ASSOC);
    $_SESSION["utente_loggato"] = $utente;

    // TODO le cose le ho fatte tutte bene, commit
} catch (\Throwable $th) {
    //throw $th;
    // echo "<br><br>rollback<br>";
    // var_dump($th);
    $cnPDO->rollBack();
    if ($th->getCode() == 1) {
        $msg = "KO_mail";
    }
    // TODO c'è stato qualche errore, rollback
}

$arrayrisposta = array("msg" => $msg, "esito" => true);
echo json_encode($arrayrisposta);
