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

