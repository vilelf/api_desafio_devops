# API Desafio Devops

## Sobre o projeto
- API criada usando python e fastapi
- CI/CD usando Github Action
- Provisionamento dos recursos na AWS usando terraform

## Como rodar localmente
- Certifique que o `docker` esteja rodando
- Rode:
    ```sh
    make build 
    make up
    ```
- Acesse: `http://localhost`

## Como deployar a API via CI/CD
- Basta mergear na branch main, o Github Actions fará o processo automáticamente

## Como deployar a API localmente
- Crie um arquivo .env baseado no .env.template
- Adicione suas chaves da AWS
- Rode:
    ```sh
    make terraform-init
    make terraform-plan
    make terraform-apply
    ```

# Próximos passos
- Usar groundwork totalmente provisionado pelo módulo
- Usar tags de release baseadas nos hashs dos commits ao invés de latest
- Usar HTTPS para o subdomínio
- Adicionar tags para melhorar organização de acordo com ambiente, aplicação, etc
- Criar testes para infra usando Terragrunt
