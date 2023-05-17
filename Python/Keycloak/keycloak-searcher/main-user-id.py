import requests
import json
import csv
from config import auth

# configuração básica da API do Keycloak
realm_name = auth["realm"]
base_url = auth["domain"]
realm_src = auth["realm-src"]

# Selecionar o nome do arquivo e da role a ser pesquisada, alterando o nome da variavel role o arquivo terá o mesmo nome
role = "RoleRequerida"
file_name = f"{role}.csv"

# criar as credenciais de usuário
username = auth["user"]
password = auth["password"]

# obter o token de acesso
token_url = f'{base_url}/realms/{realm_name}/protocol/openid-connect/token'
token_payload = {
    'username': username,
    'password': password,
    'grant_type': 'password',
    'client_id': 'admin-cli' # client_id padrão do Keycloak para a administração da API
}
response = requests.post(token_url, data=token_payload)
access_token = json.loads(response.content.decode('utf-8'))['access_token']

# fazer uma chamada à API do Keycloak para obter os usuários da role desejada
role_name = role 
api_url = f'{base_url}/admin/realms/{realm_src}/roles/{role_name}/users'
headers = {
    'Authorization': 'Bearer ' + access_token,
    'Content-Type': 'application/json'
}

# nome da chave no atributo 'attributes' que deseja coletar
attribute_key = 'chave_attributes'

# exportar os usuários para um arquivo CSV - mude o nome do arquivo conforme o nome da role para facilitar a identificação do mesmo
with open(file_name, mode='w', newline='') as csv_file:
    # criar o escritor CSV
    writer = csv.writer(csv_file)
    # escrever o cabeçalho
    writer.writerow(['Nome', 'E-mail', 'Ativo', 'MainUserID'])

    # iterar sobre os usuários e escrever cada um no arquivo CSV
    max_results = 500
    first = True
    while True:
        if first:
            response = requests.get(api_url, headers=headers, params={'max': max_results})
            first = False
        else:
            response = requests.get(next_url, headers=headers)
        if response.status_code == 200:
            users = json.loads(response.content.decode('utf-8'))
            for user in users:
                main_user_id = user.get('attributes', {}).get('main_user_id', '')
                writer.writerow([user['username'], user['username'], user['enabled'], main_user_id])
            next_url = response.links.get('next', {}).get('url')
            if not next_url:
                break
        else:
            print(f'Falha na chamada da API: {response.status_code}')
            break

print(f'Dados exportados para o arquivo {file_name}')
