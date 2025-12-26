# Data Project

Este é um projeto pessoal de estudo criado para aprofundar meus conhecimentos em modelagem analítica de dados utilizando `dbt-core`. O objetivo é praticar conceitos de engenharia de dados em um ambiente local, reproduzível e próximo de cenários reais de trabalho.

O projeto utiliza PostgreSQL via Docker como banco de dados e dbt para transformação e organização dos dados, permitindo desenvolver, executar e testar modelos analíticos de forma estruturada e versionada.

## Visão Geral
- **Banco:** PostgreSQL rodando em Docker (`docker-compose`)
- **Transformações:** `dbt-core`
- **Porta:** `5432` exposta no host

## Estrutura do Projeto
- `docker-compose.yml`: Serviço do Postgres
- `Makefile`: Automação de setup e tarefas comuns
- `requiriments.txt`: Dependências Python do projeto
- `data/`: Projeto `dbt`
	- `dbt_project.yml`: Configuração do projeto
	- `dbt_profile/profiles.yml`: Template de configuração do dbt
	- `models/`: Modelos (`schedule.sql`)
	- `seeds/`, `snapshots/`, `tests/`, `macros/`, `analyses/`: Pastas padrão do dbt
- `LICENSE`: Licença do projeto

## Pré-requisitos
- Docker e Docker Compose
- Python 3.12+
- Acesso de escrita a `~/.dbt/` para configurar `profiles.yml`

## Instalação de Dependências

O arquivo `requiriments.txt` lista os pacotes necessários:

```
dbt-core>=1.10.0
dbt-postgres>=1.10.0
psycopg2-binary>=2.9
```

## Setup Rápido (Usando Makefile)

O Makefile fornece comandos automatizados para simplificar o setup:

1) Subir o banco PostgreSQL:

```bash
docker-compose up -d
```

2) Configurar o dbt (copia `profiles.yml` para `~/.dbt/`):

```bash
make init-dbt
```

3) Criar ambiente virtual e instalar dependências:

```bash
make init-venv
source data/.venv/bin/activate
```

4) Rodar o projeto dbt:

```bash
cd data
dbt debug
dbt run
dbt test
```

5) (Opcional) Conectar diretamente ao banco via psql:

```bash
make db-connect
```

### Comandos Make Disponíveis
- `make init-dbt`: Configura o `~/.dbt/profiles.yml` automaticamente
- `make init-venv`: Cria virtualenv em `data/.venv`, instala dependências e roda `dbt deps`
- `make db-connect`: Abre uma sessão psql no container Postgres

## Setup Rápido (Manual)
## Setup Rápido (Manual)
1) Subir o banco PostgreSQL:

```bash
docker-compose up -d
```

2) Criar e ativar o ambiente Python local com `dbt`:

```bash
python3 -m venv env
source env/bin/activate
pip install -r requiriments.txt
dbt --version
```

3) Configurar `profiles.yml` do dbt em `~/.dbt/profiles.yml` (crie a pasta se não existir):

```yaml
data_project:
	target: dev
	outputs:
		dev:
			type: postgres
			host: localhost
			port: 5432
			user: postgres
			password: postgres
			dbname: db
			schema: public
			threads: 4
			keepalives_idle: 0
```

> **Dica:** Use `make init-dbt` para copiar automaticamente o template de `profiles.yml`.

4) Rodar o projeto dbt (a partir da pasta `data/`):

```bash
cd data
dbt debug
dbt seed
dbt run
dbt test
```

5) Encerrar os serviços:

```bash
docker-compose down
```

## Comandos Úteis

### dbt
- `dbt debug`: valida conexão e configuração do projeto
- `dbt run`: executa todos os modelos
- `dbt run -s <model_name>`: executa um modelo específico
- `dbt test`: roda testes de qualidade
- `dbt seed`: carrega tabelas de semente em `seeds/`
- `dbt deps`: instala pacotes dbt declarados em `packages.yml`

## Notas
- O container é chamado `database` e usa `postgres:latest`.
- Credenciais padrão: `POSTGRES_USER=postgres`, `POSTGRES_PASSWORD=postgres`, `POSTGRES_DB=db`.
- O Makefile cria o ambiente virtual em `data/.venv` (não versionado).
- O template `profiles.yml` está em `data/dbt_profile/profiles.yml`.

## Troubleshooting

**Problemas com `profiles.yml`:**
- Use `make init-dbt` para configurar automaticamente
- Ou garanta que o arquivo está em `~/.dbt/profiles.yml`
- Use `dbt debug` para verificar a conexão

**Ambiente virtual não encontrado:**
Se você usou `make init-venv`, o ambiente está em `data/.venv`:
```bash
source data/.venv/bin/activate
```

**dbt_project.yml não encontrado:** para fuuncionar, os comandos do dbt devem ser executados dentro do ambiente virtual e na pasta `data-project/data`

## Licença
Consulte o arquivo `LICENSE` na raiz do projeto.

