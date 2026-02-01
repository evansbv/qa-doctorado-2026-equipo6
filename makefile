# Makefile para el Proyecto QA - Evidencias de Calidad de Software
# SUT: Swagger Petstore (OpenAPI 3.0)

.PHONY: help setup start-petstore stop-petstore restart-petstore healthcheck smoke SC-01 SC-02 SC-03 SC-04 SC-05 SC-06 QA-week2 clean

# Objetivo por defecto: mostrar ayuda
help:
	@echo "Objetivos disponibles:"
	@echo ""
	@echo "Configuración del SUT:"
	@echo "  setup           - Preparar permisos de scripts y entorno"
	@echo "  start-petstore  - Iniciar el contenedor Petstore (SUT)"
	@echo "  stop-petstore   - Detener el contenedor Petstore"
	@echo "  restart-petstore- Reiniciar el contenedor Petstore"
	@echo "  healthcheck     - Verificar que el SUT responde en puerto 8080"
	@echo "  clean           - Eliminar el contenedor Petstore (datos in-memory se pierden)"
	@echo ""
	@echo "Pruebas de Calidad - Semana 2:"
	@echo "  SC-01           - Escenario SC-01: Creación exitosa de mascota (Happy Path / Contract)"
	@echo "  SC-02           - Escenario SC-02: Consulta de mascota por ID"
	@echo "  SC-03           - Escenario SC-03: Actualización de mascota"
	@echo "  SC-04           - Escenario SC-04: Creación inválida (Robustness / Error Handling)"
	@echo "  SC-05           - Escenario SC-05: Latencia básica en /store/inventory (Performance - Local)"
	@echo "  SC-06           - Escenario SC-06: Validación de forma en inventario (Data Shape Sanity)"
	@echo "  QA-week2        - Ejecutar todos los escenarios SC-01 a SC-06"
	@echo ""
	@echo "  Risk-based testing - Semana 3:"
	@echo "  Risk01 			 - Disponibilidad (SC-01)"
	@echo "  Risk02 		 	 - Rendimiento (SC-05)"
	@echo "  Risk03 			 - Consistencia (SC-06)"
	@echo "  RBT-week3       - Ejecutar todos los escenarios de Risk-based testing"
	@echo ""
	@echo "Pruebas Legacy / Rápidas:"
	@echo "  smoke           - Ejecutar smoke test completo (endpoints críticos)"
	@echo ""
	@echo "Utilidades:"
	@echo "  clean           - Eliminar evidencias temporales de week2 (opcional)"
	@echo "  clean-rbt       - Eliminar evidencias temporales de week3 (opcional)"

# Configuración inicial
setup:
	@echo "Configurando permisos de ejecución en scripts..."
	@chmod +x setup/*.sh scripts/*.sh 2>/dev/null || true
	@echo "OK: Entorno de scripts preparado"

# Gestión del SUT (usando el script principal)
start-petstore:
	./setup/manage-petstore.sh start

stop-petstore:
	./setup/manage-petstore.sh stop

restart-petstore:
	./setup/manage-petstore.sh restart

healthcheck:
	./setup/manage-petstore.sh health

clean:
	./setup/manage-petstore.sh clean

# Smoke test actualizado
smoke:
	@echo "Ejecutando smoke test..."
	@./scripts/smoke.sh

# Escenarios de la Semana 2
SC-01:
	@echo "Ejecutando SC-01 - Creación exitosa de mascota"
	@./scripts/sc-01-create-pet.sh

SC-02:
	@echo "Ejecutando SC-02 - Consulta de mascota por ID"
	@./scripts/sc-02-get-pet.sh

SC-03:
	@echo "Ejecutando SC-03 - Actualización de mascota"
	@./scripts/sc-03-update-pet.sh

SC-04:
	@echo "Ejecutando SC-04 - Creación inválida"
	@./scripts/sc-04-invalid-create.sh

SC-05:
	@echo "Ejecutando SC-05 - Latencia básica en /store/inventory"
	@./scripts/sc-05-latency.sh

SC-06:
	@echo "Ejecutando SC-06 - Validación de forma en inventario"
	@./scripts/sc-06-inventory-shape.sh

# Ejecución completa de la semana 2
QA-week2: SC-01 SC-02 SC-03 SC-04 SC-05 SC-06
	@echo ""
	@echo "========================================"
	@echo "OK: Todos los escenarios SC-01 a SC-06 completados"
	@echo "OK: Evidencias generadas en evidence/week2/"
	@echo "========================================"

# Escenarios de la Semana 3
Risk01:  # R01 - Disponibilidad (SC-01)
	@echo "Ejecutando Risk01 - Disponibilidad (SC-01)"
	@./scripts/risk01_SC_01.sh

Risk02:  # R02 - Latencia (SC-05)
	@echo "Ejecutando Risk02 - Latencia (SC-05)"
	@./scripts/risk02_SC_05.sh 30  # 30 reps por default

Risk03:  # R03 - Consistencia (SC-06)
	@echo "Ejecutando Risk03 - Validación de forma en inventario"
	@./scripts/risk03_SC_06.sh 5  # 5 reps por default

# Target para generar todas las evidencias de Semana 3
RBT-week3: Risk01 Risk02 Risk03  # Ejecuta todos los riesgos Top 3
	@echo ""
	@echo "========================================"
	@echo "OK: Todos los Riegos completados"
	@echo "OK: Evidencias generadas en evidence/week3/"
	@echo "========================================"

# Limpieza
clean:
	@echo "Limpiando evidencias temporales..."
	@rm -rf evidence/week2/*.log evidence/week2/*.json evidence/week2/*.txt evidence/week2/*.csv 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week2 eliminados)"

	# Limpieza específica para week3
clean-rbt:
	@echo "Limpiando evidencias temporales..."
	@rm -rf evidence/week3/*.log evidence/week3/*.json evidence/week3/*.txt evidence/week3/*.csv 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week3 eliminados)"