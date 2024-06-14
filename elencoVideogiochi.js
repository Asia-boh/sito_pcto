// var table = document.getElementById("tabella");
// $.post('/asia/elencoVideogiochi.php', {email, password},
//     function(returnedData){
//          console.log('returnedData',returnedData);
//          if(returnedData.msg == "OK"){
//             p.textContent = "Login effettuato con successo!";
//             window.location.href = "/asia/elencoVideogiochi.html";
//         }
//         else if(returnedData.msg == "KO"){
//             p.textContent = "Email e password non corrispondono";
//         }
// }, "json").fail(function(){
//       console.log("error");
// });

$(function () {
  var table = document.getElementById("tabella");
  generaTabella("tabella");
  document
    .getElementById("formNuovoVideogioco")
    .addEventListener("submit", async function (event) {
      event.preventDefault();
      const titolo = document.getElementById("titolo").value;
      const genere = document.getElementById("genere").value;
      const data_rilascio = document.getElementById("data_rilascio").value;
      $.post(
        "/asia/inserisciVideogiochi.php",
        { titolo, genere, data_rilascio },
        function (returnedData) {
          generaTabella("tabella");
        },
        "json"
      ).fail(function () {
        console.log("error");
      });
    });

    document
    .getElementById("formIndietro")
    .addEventListener("submit", async function (event) {
      event.preventDefault();
      window.location.href = "/asia/login.html";
    });
});

function generaTabella(id_table) {
  var rows = document.getElementById(id_table).rows.length;
  for (j = 1; j < rows; j++) {
    document.getElementById(id_table).deleteRow(1);
  }
  var table = document.getElementById(id_table);
  $.post(
    "/asia/elencoVideogiochi.php",
    {},
    function (returnedData) {
      console.log("returnedData", returnedData);
      returnedData.forEach((x, i) => {
        let row = table.insertRow(-1);

        let cell1 = row.insertCell(0);
        let cell2 = row.insertCell(1);
        let cell3 = row.insertCell(2);

        cell1.innerHTML = x.TITOLO;
        cell2.innerHTML = x.GENERE;
        cell3.innerHTML = x.DATA_RILASCIO;
      });
    },
    "json"
  ).fail(function () {
    console.log("error");
  });
}
