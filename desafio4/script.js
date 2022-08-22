"use strict";

var recursos = [{
  id: 1,
  nombre: "Agua",
  um: "LT"
}, {
  id: 2,
  nombre: "Pólvora",
  um: "GL"
}, {
  id: 3,
  nombre: "GAS",
  um: "LT"
}, {
  id: 4,
  nombre: "Hojas (filo)",
  um: "GL"
}, {
  id: 5,
  nombre: "Equipo maniobras",
  um: "GL"
}];
var selectRecursos = document.querySelector("#selectRecursos");

function eliminarFila(r) {
  var i = r.parentNode.parentNode.rowIndex;
  document.getElementById('miTabla').deleteRow(i);
}

var obtenerFechaActual = function obtenerFechaActual() {
  var date = new Date();
  var output = String(date.getDate()).padStart(2, '0') + '/' + String(date.getMonth() + 1).padStart(2, '0') + '/' + date.getFullYear();
  return output;
};

function insertarFila() {
  if (document.getElementById("cantidad").value === '') {
    alert("debe ingresar una cantidad");
    return;
  }

  var x = document.getElementById('miTabla').insertRow(document.getElementById('miTabla').rows.length);
  var celdaRecurso = x.insertCell(0);
  var celdaCantidad = x.insertCell(1);
  var celdaFecha = x.insertCell(2);
  var celdaEliminar = x.insertCell(3); // valor select

  var sel = document.getElementById("selectRecursos");
  var textSelected = sel.options[sel.selectedIndex].text;
  var unidadMedida = document.getElementById("unidadMedida").innerHTML;
  celdaRecurso.innerHTML = textSelected;
  celdaCantidad.innerHTML = document.getElementById("cantidad").value + ' ' + unidadMedida;
  celdaFecha.innerHTML = obtenerFechaActual();
  celdaEliminar.innerHTML = '<input type="button" value="eliminar" onclick="eliminarFila(this)"/>';
}

function llenarRecursos() {
  recursos.forEach(function (array, indice) {
    var nuevaOpcion = document.createElement("option");
    nuevaOpcion.value = array.um;
    nuevaOpcion.text = array.nombre;
    selectRecursos.add(nuevaOpcion);
  });
}

window.addEventListener("load", function (event) {
  llenarRecursos();
  document.getElementById('selectRecursos').addEventListener('change', function () {
    if (this.value === '') {
      document.getElementById('cantidad').style.display = 'none';
    } else {
      document.getElementById('cantidad').style.display = 'block';
    }

    document.getElementById("unidadMedida").innerHTML = this.value;
  });
  var campoNumerico = document.getElementById('cantidad');
  campoNumerico.addEventListener('keydown', function (evento) {
    var teclaPresionada = evento.key;
    var teclaPresionadaEsUnNumero = Number.isInteger(parseInt(teclaPresionada));
    var sePresionoUnaTeclaNoAdmitida = teclaPresionada != 'ArrowDown' && teclaPresionada != 'ArrowUp' && teclaPresionada != 'ArrowLeft' && teclaPresionada != 'ArrowRight' && teclaPresionada != 'Backspace' && teclaPresionada != 'Delete' && teclaPresionada != 'Enter' && !teclaPresionadaEsUnNumero;
    var comienzaPorCero = campoNumerico.value.length === 0 && teclaPresionada == 0;

    if (sePresionoUnaTeclaNoAdmitida || comienzaPorCero) {
      evento.preventDefault();
    }
  });
});