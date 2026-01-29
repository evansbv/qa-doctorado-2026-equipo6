# ACTA DE REUNIÓN N° 01  
Proyecto: QA Doctorado 2026 – Equipo 6  
Sistema: https://github.com/swagger-api/swagger-petstore
---

## 1. Información General

- **Fecha:** 17/1/2026
- **Hora de inicio:** [15:mm]
- **Hora de cierre:** [18:mm]
- **Modalidad:** Reunión virtual
- **Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO  

---

## 2. Objetivo de la Reunión

Definir el sistema bajo prueba (SUT), establecer el flujo de trabajo del proyecto y acordar la metodología inicial para el desarrollo del repositorio correspondiente a la Tarea Grupal

## 3. Temas Tratados

### 3.1 Selección del System Under Test (SUT)

El equipo acordó utilizar como SUT el sistema **Swagger Petstore API**, por las siguientes razones:

- Es un sistema open-source ampliamente utilizado para pruebas de APIs.
- Expone una interfaz observable HTTP (API REST).
- Permite ejecución local reproducible mediante Docker.
- No requiere el uso de datos sensibles ni credenciales privadas.

Se definió que la justificación formal, junto con los riesgos y limitaciones, será documentada en el archivo `SUT_SELECTION.md`.

### 3.2 Estructura del Repositorio

Se revisó y validó la estructura base del repositorio, acordando mantener una organización por dominios de trabajo, que permita trazabilidad y escalabilidad del proyecto.

Las carpetas principales incluyen:
- `setup/`
- `scripts/`
- `evidence/`
- `quality/`
- `risk/`
- `design/`
- `ci/`
- `memos/`
- `reports/`
- `study/`
- `paper/`
- `slides/`
- `peer_review/`


### 3.3 Flujo de Trabajo del Proyecto

El equipo acordó el siguiente flujo de trabajo metodológico:

1. Ejecución y verificación de salud del SUT.
2. Identificación de atributos de calidad relevantes.
3. Análisis y priorización de riesgos.
4. Diseño de escenarios de prueba y reglas de oráculo.
5. Ejecución de pruebas manuales y/o automatizadas.
6. Recolección de evidencia verificable.
7. Documentación del progreso mediante memorándums semanales.

Este flujo fue definido con el objetivo de asegurar pruebas repetibles, trazables y sustentadas en evidencia objetiva.

### 3.4 Uso de Docker y Scripts de Ejecución

Se acordó que el SUT será ejecutado mediante Docker y que se crearán scripts específicos para:
- Inicio del sistema (`run_sut.sh`)
- Detención del sistema (`stop_sut.sh`)
- Verificación de estado (`healthcheck_sut.sh`)

Estos scripts se ubicarán en la carpeta `setup/`.


## 4. Acuerdos

- El README del repositorio deberá reflejar explícitamente el SUT, el flujo de trabajo y las instrucciones de ejecución.
- Toda prueba ejecutada deberá contar con evidencia almacenada en la carpeta `evidence/`.
- Las decisiones técnicas y metodológicas relevantes serán registradas en actas o memorándums semanales.
- El repositorio será mantenido como público y actualizado por todos los integrantes del equipo.

## 5. Próximos Pasos

- Elaborar el archivo `SUT_SELECTION.md`.
- Completar los scripts de ejecución en la carpeta `setup/`.
- Documentar los primeros atributos de calidad en la carpeta `quality/`.
- Preparar el análisis inicial de riesgos en la carpeta `risk/`.

## 6. Cierre de la Reunión

No habiendo más temas que tratar, se dio por concluida la reunión, quedando los acuerdos establecidos como base para el desarrollo del proyecto.

**Hora de cierre:** [18:00]
**Elaboró:** Equipo 6  
**Revisó:** Equipo 6
