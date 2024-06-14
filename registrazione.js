/*
var persone = [];
function aggiornaElenco(idElenco){
    const ul = document.getElementById(idElenco);
    ul.innerHTML = '';
    for(let i = 0; i < persone.length; i++){
        const li = document.createElement('li');
        li.textContent = `${persone[i].nome} ${persone[i].cognome}`
        ul.appendChild(li);
    }
}

document.getElementById("formPersona").addEventListener("submit", function(event){
    event.preventDefault();
    const nome = document.getElementById("nome").value;
    const cognome = document.getElementById("cognome").value;
    persone.push({nome, cognome});
    aggiornaElenco("listaPersone");
    event.target.reset();
});
*/
var errore = "";
// function findGetParameter(parameterName) {
//     var result = null,
//         tmp = [];
//     location.search
//         .substring(1)
//         .split("&")
//         .forEach(function (item) {
//           tmp = item.split("=");
//           if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
//         });
//     return result;
// }

async function hashPassword(password) {
  const encoder = new TextEncoder();
  const data = encoder.encode(password);
  const hash = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(hash))
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

function emailAlreadyRegistered(email) {
  for (let i = 0; i < users.length; i++) {
    if (users[i].email == email) {
      return true;
    }
  }
  return false;
}

function passwordTest(password, confirm_password) {
  return password == confirm_password;
}
console.log("window.location.search", window.location.search);
//controllo errore
// if(findGetParameter("msg") == "OK"){
//     errore = "Registrazione completata con successo!";
// }
// else if(findGetParameter("msg") == "KO_mail"){
//     errore = "Errore! email già utilizzata";
// }
// document.getElementById("messaggio_errore").textContent = errore;

document
  .getElementById("formUser")
  .addEventListener("submit", async function (event) {
    event.preventDefault();
    console.log("evento", event);
    const nome = document.getElementById("nome").value;
    const cognome = document.getElementById("cognome").value;
    const sesso = document.getElementById("sesso").value;
    const email = document.getElementById("email").value;
    const username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    const data_nascita = document.getElementById("data_nascita").value;
    const codice_fiscale = document.getElementById("codice_fiscale").value;
    const confirm_password = document.getElementById("confirm_password").value;
    const p = document.getElementById("messaggio_errore");
    p.innerHTML = "";
    if (passwordTest(password, confirm_password)) {
      console.log(password);
      password = await hashPassword(password).then((enpsw) => {
        console.log(enpsw);
        return enpsw;
      });
      // console.log("enpsw",enpsw);
      // document.getElementById("password").value = enpsw;
      // document.getElementById("confirm_password").value = enpsw;
      //password = enpsw;
      //event.target.submit();
      console.log(
        nome,
        cognome,
        sesso,
        data_nascita,
        codice_fiscale,
        username,
        email,
        password
      );
      $.post(
        "/asia.php",
        {
          nome,
          cognome,
          sesso,
          data_nascita,
          codice_fiscale,
          username,
          email,
          password,
        },
        function (returnedData) {
          console.log("returnedData", returnedData);
          if (returnedData.msg == "OK") {
            p.textContent = "Registrazione completata con successo!";
            window.location.href = "/asia/elencoVideogiochi.html";
          } else if (returnedData.msg == "KO_mail") {
            p.textContent = "Errore! email già utilizzata";
          }
        },
        "json"
      ).fail(function () {
        console.log("error");
      });
      document.getElementById("formUser").reset();
      // console.log($("#formUser")[0]);
      $("#formUser")[0].reset();
    } else {
      p.textContent =
        "registrazione non riuscita! La password non corrisponde!";
    }
  });

document
  .getElementById("formLogin")
  .addEventListener("submit", async function (event) {
    event.preventDefault();
    window.location.href = "/asia/login.html";
  });
