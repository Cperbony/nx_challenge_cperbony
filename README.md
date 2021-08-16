# README

```txt
Nexoos Challenge

Seu desafio será completar o desenvolvimento dessa API capaz de gerir empréstimos, salvando informações necessárias do cliente para podermos realizar o cálculo do valor da parcela (PMT), além de haver a possibilidade de leitura desses dados pelo cliente.

Deve-se:

- Modelar o banco de dados parar ter os dados necessários do cálculo da PMT
- Completar as rotas `POST /loans` e `GET /loans/ID`, alterando a API para escrever e retornar dados do banco de dados.
  - Na escrita, deve-se calcular o valor da parcela (PMT) e salvar no banco de dados.

Sobre a PMT:

https://fia.com.br/blog/matematica-financeira/#:~:text=PMT%20s%C3%A3o%20pagamentos%20de%20mesmo,ou%20empresarial)%20de%20forma%20recorrente.&text=Por%20isso%2C%20tamb%C3%A9m%20s%C3%A3o%20tratados,fixa%20de%20empr%C3%A9stimo%20ou%20financiamento

Cálculo da PMT:

http://ghiorzi.org/amortiza.htm
```
# Criando ambiente rvm para a gemset
rvm gemset create nx_challenge

# setar a versão do ruby e gems
rvm --rvmrc 2.7.2@nx_challenge

# setar como default in shell and IDE
rvm use 2.7.2 -default2.7.2@nx_challenge

# Instalar dependências
bundle install

# Iniciar a criação e a migração do banco de dados
rails db:create
rails db:migrate

# Iniciar a API
```ruby
rails s
```
## Run Post Request para Loans:

```sh
curl --location --request POST 'http://localhost:3000/loans/' \
--form 'value="1999"' \
--form 'rate="0.03"' \
--form 'months="2"'
```

### Expected Response:

```json
{
  "loan": {
    "id": 1
  }
}
```
## Run Get Request para Loans:

```sh
curl --request GET http://localhost:3000/loans/1
```

### Expected Response:
```sh
{
  "loan": {
    "id": 1, "pmt": 308
  }
}
```

# Run all Rspec Tests
rspec spec --format documentation

## Run all controller Spec
rspec spec/controllers/loans_controllers_spec.rb 

## Run all models spec
rspec spec/models/loan_spec.rb 

#### Requisitos técnicos
- Usar Ruby on Rails
- É permitido o uso de frameworks e gems
- Deve ser usado GIT para versionamento

#### Pontos extras para:

- Documentação
- Testes unitários e/ou de integração com Rspec

##### Envio:

Envie o seu código pronto através de um Pull Request para esse repositório
# nx_challenge_cperbony
