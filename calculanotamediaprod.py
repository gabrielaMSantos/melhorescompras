titulo = "Calcula o valor médio de avaliação do produto"
print(f'{titulo:^50}')

nota1 = int(input("Digite a primeira nota de avaliação do produto: "))

nota2 = int(input("Digite a segunda nota de avaliação do produto: "))

media = (float(nota1) + float(nota2))/7

print("A média alcançada foi: %s" % media)

if media > 6:
    print("Parabéns, produto adequado aos clientes!")
else:
    print("Que pena, esse produto inadequado e com muitas reclamações. 
		   Acione o controle de qualidade!")