Feature: Testando API GO REST

Background: Executa antes de cada teste
    * def url_base = "https://gorest.co.in/public/v2"
    * def request_json = read("request_json.json")
    * def token = "access-token=32343feeab8a7867f9413d7221e8d7f4598ae24e7548c69d2e31e0a079791b8b"

Scenario: Testando retorno
    Given url url_base
    And path '/users'
    When method get
    Then status 200

Scenario: Testando retorno com erro de url inválida
    Given url url_base
    And path '/user'
    When method get
    Then status 404

Scenario: Testando retorno do array
    Given url url_base
    And path '/comments'
    When method get
    Then status 200
    And match $ == '#[]'
    And match each $ contains {id: '#number', name: '#string'}

Scenario: Testando retorno de um user_id e usando o método get no usuario
    Given url url_base
    And path '/todos'   
    When method get
    Then status 200
    And def id_user = $[0].user_id
    And url url_base    
    And path '/users/' + id_user
    When method get
    Then status 200
    And match $.name == '#string' 

Scenario: Testando tamanho da página
    Given url url_base
    And path '/users?page=1&per_page=20'
    When method get
    Then status 200
    And match $ == '#[20]'
    
Scenario: Criando um novo elemento usando o método POST
    Given url url_base
    And path '/users?' + token
    And request request_json
    When method post
    Then status 201
    And match $.id == '#number'
    And match $.name == 'teste_nome6'
    And match $.gender == '#string'
    And match $.status == 'active'