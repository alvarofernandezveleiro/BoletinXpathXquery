# Xquery
---
[Guía Xquery](https://docs.google.com/document/d/17W2AZrEdgAoe1Fj78LWI9BFmK5fHSHeidJe6C1l51Cc/edit?usp=sharing)

Para poder tener la salida de las consultas en un fichero diferente:

```
file:write('ejemplo_consulta.html',
 <html>
    <ul> 
     {
        for $x in doc("biblio.xml")/bookstore/book/title 
        order by $x
        return <li>{data($x)}</li> 
     }
    </ul>
 </html>
)
```

Es la consulta `ejemplo_consulta.xql` y la salida `ejemplo_consulta.html`

-----------------------------
Consulta1:
for $libro in doc("libros.xml")//libro
order by $libro/titulo
return $libro/titulo
Resultado1:
<titulo>El Quijote</titulo>
<titulo>Programas ERP</titulo>
Explicacion:la consulta recorre todos los elementros de "libro" y los ordena alfabeticamente dentro del elemento titulo.
----------------------------
Consulta2:
for $libro in doc("libros.xml")//libro
order by $libro/autores/autor[1]/nombre
return $libro/titulo
Resultado:
<titulo>Programas ERP</titulo>
<titulo>El Quijote</titulo>
Explicacion:lo mismo que el anterior pero basandose en el nombre del primer autor en vez del titulo del libro.
------------------------------
Consulta3:
for $libro in doc("libros.xml")//libro
return concat($libro/titulo, ": ", $libro/autores/autor[1]/nombre, " ", $libro/autores/autor[1]/apellido)
Resultado3:
El Quijote: Miguel Cervantes
Programas ERP: Axel García
Explicacion:la consulta recorre todos los elementros de "libro" y nos muestra concatenados el titulo junto con su respectivo autor.
-------------------------------
Consulta4:
for $libro in doc("libros.xml")//libro
return concat($libro/titulo, ": ", count($libro/autores/autor), " autor(es)")
Resultado:
El Quijote: 1 autor(es)
Programas ERP: 2 autor(es)
Explicacion:aqui se usa la funcion count para contar los elementos "autor" dentro de "autores" para cada libro.
--------------------------------
Consulta5:
let $librosMultiples := doc("libros.xml")//libro[count(autores/autor) > 1]
let $librosUnico := doc("libros.xml")//libro[count(autores/autor) = 1]
return (
  "Libros con varios autores:",
  $librosMultiples/titulo,
  "Libros con un autor:",
  $librosUnico/titulo
)
Resultado5:
Libros con varios autores:
<titulo>Programas ERP</titulo>
Libros con un autor:
<titulo>El Quijote</titulo>
Explicacion:Aqui ya usamos let para identificar los titulos de los libros con varios autores y los que solo tienen un autor usando tambien operadores matematicos > y =.
---------------------------------
Consulta6:
for $libro in doc("libros.xml")//libro
where $libro/autores/autor[nombre = "Axel"]
return $libro/titulo
Resultado6:
<titulo>Programas ERP</titulo>
Explicacion:una consulta basica donde buscamos los libros cuyo autor contenga exactamente el nombre Axel.
--------------------------------
Consulta7:
<ul>{
  for $libro in doc("libros.xml")//libro
  return <li>{$libro/titulo} - {$libro/precio}</li>
}</ul>
Resultado7:
<ul><li><titulo>El Quijote</titulo> - <precio>60</precio></li><li><titulo>Programas ERP</titulo> - <precio>34.50</precio></li></ul>
Explicacion:una consulta basica de libros y precios pero que muestra el resultado en una lista de html.
-----------------------------------
Consulta8:
<table>
  <tr>
    <th>Título</th>
    <th>ISBN</th>
    <th>Precio</th>
  </tr>
  {
    for $libro in doc("libros.xml")//libro
    return <tr>
      <td>{$libro/titulo}</td>
      <td>{$libro/isbn}</td>
      <td>{$libro/precio}</td>
    </tr>
  }
</table>
Resultado8:
<table><tr><th>Título</th><th>ISBN</th><th>Precio</th></tr><tr><td><titulo>El Quijote</titulo></td><td><isbn>1234</isbn></td><td><precio>60</precio></td></tr><tr><td><titulo>Programas ERP</titulo></td><td><isbn>4321</isbn></td><td><precio>34.50</precio></td></tr></table>
Explicacion:parecido a la consulta anterior solo que un poco mas complicado ya que hay que hay mas datos que mostrar.

---------------------------------------
----------------------------------------
Consulta1:
for $alumno in doc("alumnos.xml")//alumno
where $alumno/nota >= 5
return $alumno/nombre
Resultado1:
<nombre>Jose</nombre>
<nombre>Sonia</nombre>
<nombre>Ana</nombre>
Explicacion: selecciona los elementos "alumno" que tengan una nota superior o igual a 5 ya que es el aprobado.
-----------------------------------------
Consulta2:
for $alumno in doc("alumnos.xml")//alumno
where $alumno/nota >= 5
return <alumno dni="{$alumno/@dni}" nota="{$alumno/nota}"/>
Resultado2:
<alumno dni="41293940" nota="7"/>
<alumno dni="23456782" nota="8"/>
<alumno dni="12345678" nota="9"/>
Explicacion: con la consulta anterior añadimos en el return el dni de cada uno de los alumnos aprobado dentro de un nuevo elemento "alumno"
------------------------------------------
Consulta3:
for $alumno in doc("alumnos.xml")//alumno
where $alumno/nota >= 6 and $alumno/nota <= 8
return $alumno/nombre
Resultado3:
<nombre>Jose</nombre>
<nombre>Sonia</nombre>
Explicacion: consulta sencilla donde se usan los operadores <> y = para buscar a los alunmos con notas de entre 6 y 8(incluidas).
-------------------------------------
Consulta4:
for $alumno in doc("alumnos.xml")//alumno
order by $alumno/apells
return $alumno/nombre
Resultado4:
<nombre>Jose</nombre>
<nombre>Juan</nombre>
<nombre>Sonia</nombre>
<nombre>Ana</nombre>
<nombre>Manuel</nombre>
Explicacion: busca entre los elemento alumnos y los ordena alfabeticamente por sus apellidos con el elemento "apells". Muestra solo los nombres ordenados por los apellidos.
-------------------------------------
Consulta5:
for $alumno in doc("alumnos.xml")//alumno
order by $alumno/@dni
return $alumno/nombre
Resultado6:
<nombre>Ana</nombre>
<nombre>Juan</nombre>
<nombre>Sonia</nombre>
<nombre>Manuel</nombre>
<nombre>Jose</nombre>
Explicacion: misma consulta que la anterior pero esta vez los nombres son ordenados segun su DNI y no su apellido.
------------------------------------
Consulta6:
for $alumno in doc("alumnos.xml")//alumno
return concat("DNI: ", $alumno/@dni, ", Nombre: ", $alumno/nombre)
Resultado:
DNI: 41293940, Nombre: Jose
DNI: 23456782, Nombre: Sonia
DNI: 12367845, Nombre: Juan
DNI: 34567821, Nombre: Manuel
DNI: 12345678, Nombre: Ana
Explicacion: con la funcion concat nos aseguramos que las busquedas de dni y nombre salgan en el orden indicado.
