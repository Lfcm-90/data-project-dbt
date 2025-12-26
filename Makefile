SHELL := /bin/bash

init-dbt:
	@echo "🔧 Criando diretório ~/.dbt (se não existir)..."
	@mkdir -p ~/.dbt
	@echo "📄 Copiando profiles.yml para ~/.dbt..."
	@cp data/dbt_profile/profiles.yml ~/.dbt/profiles.yml
	@echo "✅ dbt configurado com sucesso! (Credenciais padrão para o container Postgres)"

init-venv:
	@echo "🐍 Criando virtualenv em data/.venv..."
	@cd data && \
	python3 -m venv .venv && \
	echo "📦 Instalando dependências..." && \
	.venv/bin/pip install -r ../requirements.txt && \
	echo "🔗 Baixando pacotes do dbt (dbt deps)..." && \
	.venv/bin/dbt deps
	@echo "✅ Ambiente Python pronto! Para ativar:"
	@echo "   source data/.venv/bin/activate"

db-connect:
	@echo "🐘 Conectando ao banco Postgres (container: database)..."
	@docker exec -it database psql -U postgres -d db
