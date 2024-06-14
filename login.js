document
  .getElementById("formLogin")
  .addEventListener("submit", async function (event) {
    event.preventDefault();
    const email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    const p = document.getElementById("messaggio_errore");
    password = await hashPassword(password).then((enpsw) => {
      console.log(enpsw);
      return enpsw;
    });
    console.log("password", password);
    $.post(
      "/asia/login.php",
      { email, password },
      function (returnedData) {
        if (returnedData.msg == "OK") {
          p.textContent = "Login effettuato con successo!";
          window.location.href = "/asia/elencoVideogiochi.html";
        } else if (returnedData.msg == "KO") {
          p.textContent = "Email e password non corrispondono";
        }
      },
      "json"
    ).fail(function () {
      console.log("error");
    });
  });

async function hashPassword(password) {
  const encoder = new TextEncoder();
  const data = encoder.encode(password);
  const hash = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(hash))
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}
