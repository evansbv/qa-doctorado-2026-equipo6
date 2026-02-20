# Gaming Drill - Semana 6

## Táctica de gaming elegida
**Ocultar fallos (filtrar/ignorar errores para “pasar”)**

## Check afectado
Check 3: Casos sistemáticos Semana 4  
(Oráculo: no debe haber "FAIL" en systematic_summary.txt)

## Por qué esta táctica hace pasar el gate sin mejorar calidad
El oráculo actual del Check 3 es un grep simple que busca la palabra "FAIL" (insensible a mayúsculas) en el archivo `systematic_summary.txt` generado por `scripts/systematic_cases.sh`.  

Una persona malintencionada (o bajo presión fuerte) puede:
- Ejecutar el script normalmente.
- Filtrar la salida para eliminar líneas con "FAIL" (ej. `grep -v "FAIL" systematic_summary.txt > filtered_summary.txt && mv filtered_summary.txt systematic_summary.txt`)
- O editar manualmente el archivo después de generarlo.

Resultado: el grep no encuentra "FAIL" → el Check 3 pasa → el quality gate completo pasa → el cambio se integra y despliega.  
Sin embargo, los casos sistemáticos que fallaron **no fueron corregidos**, por lo que se introduce deuda técnica y riesgo real en producción (regresiones, bugs no detectados).  
El gate deja de ser una medida confiable de calidad y se convierte en una meta superficial que se puede “cumplir” sin valor real.

## Objetivo del drill
- Demostrar reproduciblemente que esta táctica permite pasar el gate sin solucionar los fallos reales.
- Aplicar una mejora técnica que haga detectable o imposible este gaming.
- Registrar el cambio en `ci/gate_change_log.md` y definir una regla de gobernanza mínima.


## Mejora técnica aplicada (hardening)

**Defensa implementada**:  
Verificación de integridad del artefacto mediante contador fijo de casos ejecutados (`TOTAL_CASOS_EJECUTADOS: 14`) generado dentro del script `systematic_cases.sh`. El oráculo falla si la línea no existe o el número es distinto.

**Cómo mitiga el gaming**:
- Filtrar "FAIL" con `grep -v` también elimina la línea del contador → el gate falla.
- Editar manualmente para borrar FAIL probablemente rompe o elimina el contador → falla.
- El número esperado (14) es fijo y conocido → no se puede falsificar sin modificar el código del gate o del script (lo cual queda registrado en git).

**Archivo modificado**: ci/run_quality_gate.sh (Check 3)  
**Script auxiliar**: scripts/systematic_cases_with_counter.sh  
**Registro**: ci/gate_change_log.md (entrada 2026-02-19)  
Fecha: 19 de febrero de 2026