# Infra Hackaton - Módulo 5 - Pós-tech FIAP

Este repositório contém a configuração de infraestrutura como código (**IaC**) utilizando **Terraform** para provisionar serviços AWS, incluindo:
- **Cognito**: Gerenciamento de autenticação e usuários.
- **DynamoDB**: Banco de dados NoSQL para armazenar metadados.
- **S3**: Armazenamento de vídeos enviados pelos usuários.

---

## **Estrutura do Repositório**

```
.
├── cognito/           # Configuração do AWS Cognito
│   ├── cognito.tf        # Definições principais do Cognito
├── db/                # Configuração do AWS DynamoDB
│   ├── db.tf        # Definições principais do DynamoDB
├── s3/                # Configuração do AWS S3
│   ├── s3.tf        # Definições principais do S3
├── .github/workflows/ # Configuração do GitHub Actions
│   ├── cognito.yml    # Workflow para o Cognito
│   ├── s3.yml         # Workflow para o S3
│   └── db.yml         # Workflow para o DynamoDB
└── README.md          # Documentação do repositório
```

---

## **Pré-requisitos**

Antes de utilizar este repositório, verifique se você possui os seguintes requisitos configurados no ambiente:

1. **Terraform**
   - Versão mínima: `1.5.6`
   - [Guia de instalação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

2. **AWS CLI**
   - Configure suas credenciais com o comando:
     ```bash
     aws configure
     ```
   - As credenciais utilizadas devem possuir permissões adequadas para os serviços Cognito, DynamoDB e S3.

3. **GitHub Secrets**
   - Adicione os seguintes **secrets** ao repositório para permitir que os workflows do GitHub Actions funcionem corretamente:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY`

---

## **Configuração**

### **1. Clonando o Repositório**
Clone o repositório localmente:
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

---

### **2. Diretórios dos Serviços**
Cada diretório contém os arquivos necessários para configurar um serviço AWS:

- **`cognito/`**: Configuração do AWS Cognito (User Pool, Client, e Triggers).
- **`db/`**: Configuração do DynamoDB (tabela para armazenar vídeos).
- **`s3/`**: Configuração do S3 (bucket para armazenar vídeos e notificações de eventos).

---

### **3. Configuração dos Workflows**

Os workflows do GitHub Actions estão configurados para serem acionados automaticamente sempre que houver alterações nos arquivos correspondentes de cada serviço:

- **Cognito**: Arquivos na pasta `cognito/`
- **DynamoDB**: Arquivos na pasta `db/`
- **S3**: Arquivos na pasta `s3/`

Os workflows executam os seguintes passos:
1. **Checkout do Repositório**.
2. **Setup do Terraform**.
3. **Inicialização e validação do Terraform**.
4. **Aplicação automática do Terraform** (`terraform apply`).

---

### **4. Executando Manualmente**

Se preferir executar localmente, siga os passos abaixo para cada diretório (`cognito/`, `db/`, `s3/`):

1. **Inicializar o Terraform**:
   ```bash
   terraform init
   ```

2. **Validar a Configuração**:
   ```bash
   terraform validate
   ```

3. **Aplicar as Configurações**:
   ```bash
   terraform apply -auto-approve
   ```

---

## **Workflows Automáticos**

Os workflows são configurados para rodar automaticamente no **push** para a branch `main`:

### **Cognito Workflow**
- Caminho: `.github/workflows/cognito.yml`
- Disparado por mudanças na pasta `cognito/**`.

### **DynamoDB Workflow**
- Caminho: `.github/workflows/db.yml`
- Disparado por mudanças na pasta `db/**`.

### **S3 Workflow**
- Caminho: `.github/workflows/s3.yml`
- Disparado por mudanças na pasta `s3/**`.

---

## **Saídas (Outputs)**

Após a aplicação bem-sucedida do Terraform, você terá os seguintes recursos provisionados:

### **1. Cognito**
- **User Pool ID**: Identificador único do User Pool.
- **User Pool Client ID**: Identificador do cliente associado ao User Pool.

### **2. DynamoDB**
- **Table Name**: Nome da tabela criada (`VideosTable`).
- **Chaves Primárias**:
  - Partition Key: `userId`
  - Sort Key: `videoId`

### **3. S3**
- **Bucket Name**: Nome do bucket criado.

---

## **Contribuindo**

Contribuições são bem-vindas! Para propor alterações:
1. Crie um fork deste repositório.
2. Faça suas alterações em uma nova branch.
3. Abra um pull request com a descrição das mudanças.

---

## **Licença**

Este projeto está sob a licença **MIT**. Consulte o arquivo `LICENSE` para mais informações.

---

Se precisar de ajuda ou tiver dúvidas, entre em contato com [seu-email@exemplo.com]. 🚀
