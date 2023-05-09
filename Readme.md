# Xquery
---
[Guía Xquery](https://docs.google.com/document/d/17W2AZrEdgAoe1Fj78LWI9BFmK5fHSHeidJe6C1l51Cc/edit?usp=sharing)

Para poder tener la salida de las consultas en un fichero diferene:

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