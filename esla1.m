
info = struct ('nombre', {'Juan' ;'Maria'; 'Pedro'}, 'edad',  {30; 20; 50});

datos = struct2dataset(info)

ordenado = sortrows (datos, {'edad'})
df =[]
for i=1:3
df = [df; ordenado.edad(i)]
end