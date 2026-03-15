.PHONY: help build up down logs clean restart ps bash db

help:
	@echo "Comandos disponibles:"
	@echo "  make build      - Construir todas las imágenes Docker"
	@echo "  make up         - Iniciar contenedores en background"
	@echo "  make down       - Detener y eliminar contenedores"
	@echo "  make logs       - Ver logs de todos los contenedores"
	@echo "  make restart    - Reiniciar todos los contenedores"
	@echo "  make ps         - Listar contenedores en ejecución"
	@echo "  make bash       - Entrar en bash del backend"
	@echo "  make db         - Entrar en psql de la base de datos"
	@echo "  make clean      - Eliminar contenedores, volúmenes e imágenes"
	@echo "  make prune      - Limpiar recursos no utilizados de Docker"

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

restart:
	docker-compose restart

ps:
	docker-compose ps

bash:
	docker-compose exec backend sh

db:
	docker-compose exec database psql -U postgres -d muebles_db

clean:
	docker-compose down -v --remove-orphans
	docker image prune -f

prune:
	docker system prune -f --volumes

# Comandos específicos para desarrollo
dev:
	docker-compose up

dev-build:
	docker-compose up --build

logs-backend:
	docker-compose logs -f backend

logs-frontend:
	docker-compose logs -f frontend

logs-db:
	docker-compose logs -f database

# Comandos para testing
test-backend:
	docker-compose exec backend npm test

test-frontend:
	docker-compose exec frontend npm test

# Comandos para migración de base de datos
migrate:
	docker-compose exec backend npm run migrate

seed:
	docker-compose exec backend npm run seed

# Health check
health:
	docker-compose exec backend curl http://localhost:3001/health
	docker-compose exec frontend curl http://localhost:3000/health
	docker-compose exec database pg_isready -U postgres

# Estadísticas
stats:
	docker stats --no-stream