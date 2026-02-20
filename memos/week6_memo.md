# Memo - Semana 6: Gaming Drill y endurecimiento del Quality Gate

**Fecha**: 19 de febrero de 2026  
**Autor**: Evans  
**Curso**: Calidad de Software (DCC M10 T3-4)

## Objetivos de la semana

- Identificar un riesgo real de gaming (Goodhart) en el quality gate de Semana 5.
- Demostrar reproduciblemente el gaming con un experimento before/after.
- Aplicar una mejora técnica mínima que bloquee o detecte el intento de manipulación.
- Registrar el cambio y establecer una regla mínima de gobernanza.

## Logros alcanzados

- Gaming identificado: **ocultar fallos** en el Check 3 (Casos sistemáticos Semana 4) filtrando/ignorando líneas con "FAIL" en `systematic_summary.txt`.
- Evidencia before/after generada y comparada:
  - BEFORE: se logra pasar el gate manipulando el summary (sin corregir fallos reales).
  - AFTER: el gate falla correctamente al detectar la manipulación (falta línea de integridad `TOTAL_CASOS_EJECUTADOS: 14`).
- Defensa técnica aplicada: verificación de integridad del artefacto mediante contador fijo de casos ejecutados generado dentro del script y chequeado en el oráculo del gate.
- Lección aprendida: un oráculo basado solo en presencia/ausencia de una palabra es vulnerable a manipulación simple; agregar integridad estructural (contador verificable) aumenta la resiliencia del gate sin complejidad adicional.

## Evidencia principal

- Descripción del riesgo y táctica: `ci/gaming_drill.md`
- Script automatizado del drill: `ci/run_gate_gaming_drill.sh`
- Ejecución completa: `make gaming-drill`
- Evidencias comparables:
  - `evidence/week6/before/` → gaming exitoso (gate pasa)
  - `evidence/week6/after/` → gaming detectado (gate falla)
  - `evidence/week6/summary.txt` → resumen del drill
- Registro de cambio del gate: `ci/gate_change_log.md` (entrada 2026-02-19)

## Retos / Notas

- El principal reto fue lograr un endurecimiento mínimo que no requiriera herramientas externas ni cambios masivos.
- El contador fijo (14) es simple pero efectivo; en un entorno real se podría parametrizar o calcular dinámicamente (pero para este drill se mantuvo fijo por simplicidad).
- El experimento es 100% reproducible con `make gaming-drill`.

## Lecciones aprendidas

- Goodhart se manifiesta fácilmente cuando el oráculo es demasiado simple o basado solo en texto superficial.
- Un pequeño mecanismo de integridad (como un contador verificable) puede elevar significativamente la confianza en el gate.
- Automatizar el drill (before/after) en un script + Makefile facilita la explicación y la revisión por terceros.
- La gobernanza mínima (registro de cambios + revisión cruzada) es esencial para evitar que el gate mismo sea manipulado en el futuro.

## Próximos pasos

- Considerar agregar más chequeos de integridad en otros artefactos del gate (ej. hash del openapi.json, número de líneas esperadas en logs).
- Documentar en el README la posibilidad de ejecutar `make gaming-drill` para futuros revisores.
- Preparar entrega consolidada de Semanas 5–6 (repositorio + memos + evidencias descargadas de CI).

Firma: Evans  
Fecha: 19 de febrero de 2026