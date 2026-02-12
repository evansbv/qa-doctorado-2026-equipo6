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
	@echo "  clean-pc        - Eliminar evidencias temporales de week2 (opcional)"
	@echo ""
	@echo "Risk-based testing - Semana 3:"
	@echo "  Risk01 			 - Disponibilidad (SC-01)"
	@echo "  Risk02 		 	 - Rendimiento (SC-05)"
	@echo "  Risk03 			 - Consistencia (SC-06)"
	@echo "  RBT-week3       - Ejecutar todos los escenarios de Risk-based testing"
	@echo "  clean-rbt       - Eliminar evidencias temporales de week3 (opcional)"
	@echo ""
	@echo "Diseño sistemático - Semana 4:"
	@echo "  week4-cases     - Ejecutar los 14 casos sistemáticos (POST /store/order)"
	@echo "  week4-evidence  - Ejecutar casos + mostrar resumen de evidencias week4"
	@echo "  clean-week4     - Eliminar evidencias temporales de week4"
	@echo ""
	@echo "Pruebas Legacy / Rápidas:"
	@echo "  smoke           - Ejecutar smoke test completo (endpoints críticos)"
	@echo ""
	@echo "Quality Gate - Semana 5:"
	@echo "  QA-week5        - Ejecutar Quality Gate completo (setup + run + cleanup)"
	@echo "  clean-week5     - Eliminar evidencias temporales de week5"
	@echo "  quality-gate-only - Solo correr el quality gate (sin levantar automáticamente el SUT)"
	@echo "  QA-week5-summary - Ejecutar quality gate + mostrar summary inmediatamente después"
	@echo ""

# Configuración inicial
setup:
	@echo "Configurando permisos de ejecución en scripts..."
	@chmod +x setup/*.sh scripts/*.sh 2>/dev/null || true
	@chmod +x ci/run_quality_gate.sh
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

# Semana 4 - Diseño sistemático
week4-cases:
	@echo "Ejecutando 14 casos sistemáticos (Semana 4)..."
	@scripts/systematic_cases.sh

week4-evidence: week4-cases
	@echo ""
	@echo "========================================"
	@echo "OK: Casos sistemáticos ejecutados"
	@echo "OK: Evidencias generadas en evidence/week4/"
	@echo "Resumen más reciente:"
	@ls -t evidence/week4/summary_*.txt | head -1 | xargs cat
	@echo "========================================"

clean-week4:
	@echo "Limpiando evidencias temporales de Semana 4..."
	@rm -rf evidence/week4/*.txt evidence/week4/*.json evidence/week4/*.log 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week4 eliminados)"

# Limpieza específica para week2
clean-pc:
	@echo "Limpiando evidencias temporales..."
	@rm -rf evidence/week2/*.log evidence/week2/*.json evidence/week2/*.txt evidence/week2/*.csv 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week2 eliminados)"

# Limpieza específica para week3
clean-rbt:
	@echo "Limpiando evidencias temporales..."
	@rm -rf evidence/week3/*.log evidence/week3/*.json evidence/week3/*.txt evidence/week3/*.csv 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week3 eliminados)"

# Quality Gate - Semana 5
QA-week5: setup
	@echo ""
	@echo "========================================"
	@echo "Ejecutando Quality Gate - Semana 5"
	@echo "========================================"
	@echo ""
	@./ci/run_quality_gate.sh && { \
		echo ""; \
		echo "========================================"; \
		echo "OK: Quality Gate PASSED ✓"; \
		echo "Evidencias generadas en evidence/week5/"; \
		echo "========================================"; \
	} || { \
		echo ""; \
		echo "========================================"; \
		echo "ERROR: Quality Gate FALLÓ ✗"; \
		echo "Revisa evidence/week5/SUMMARY.md y RUNLOG.md"; \
		echo "========================================"; \
		exit 1; \
	}

# Opcional: target para limpiar evidencias de week5
clean-week5:
	@echo "Limpiando evidencias temporales de Semana 5..."
	@rm -rf evidence/week5/*.txt evidence/week5/*.md evidence/week5/*.log 2>/dev/null || true
	@echo "OK: Limpieza completada (archivos de week5 eliminados)"

# Solo correr el quality gate (sin levantar automáticamente el SUT)
quality-gate-only:
	@./ci/run_quality_gate.sh

# Ejecutar quality gate + mostrar summary inmediatamente después
QA-week5-summary: QA-week5
	@echo ""
	@echo "Resumen más reciente de Quality Gate:"
	@ls -t evidence/week5/SUMMARY.md | head -1 | xargs cat