# QA Doctorado 2026 - Equipo 6

## Descripción del Proyecto

Este repositorio contiene el trabajo y la documentación del **Equipo 6**, que tiene como base los fundamentos de software testing, calidad de software y recolección de evidencia verificable.

El repositorio sirve como base común para la ejecución de pruebas, medición de calidad y desarrollo progresivo del estudio durante el módulo.

## System Under Test (SUT)

El sistema seleccionado para pruebas es:

Nombre: Swagger Petstore API  
Tipo: API REST (OpenAPI)  
Repositorio oficial: https://github.com/swagger-api/swagger-petstore  

El Swagger Petstore es un sistema open-source ampliamente utilizado para pruebas de APIs, con documentación clara y ejecución local reproducible mediante Docker.

## Justificación del SUT (resumen)

El SUT es adecuado para el módulo porque:
- Expone una interfaz observable HTTP (API REST).
- Permite ejecución local reproducible usando Docker.
- Facilita pruebas repetibles y recolección de evidencia sin uso de datos sensibles ni credenciales privadas.

## Estructura del Repositorio

- `setup/` - Scripts de configuración del entorno
- `scripts/` - Scripts de pruebas y mediciones
- `evidence/` - Recolección de evidencias semanales
- `quality/` - Escenarios de calidad y glosario
- `risk/` - Evaluación de riesgos y estrategia de pruebas
- `design/` - Diseño de casos de prueba y reglas de oráculo
- `ci/` - Configuración de integración continua
- `memos/` - Memorandums de progreso semanal
- `reports/` - Reportes de unidad
- `study/` - Materiales del estudio de investigación
- `paper/` - Paper final
- `slides/` - Materiales de presentación
- `peer_review/` - Materiales de revisión por pares

## Primeros Pasos

Revisar los acuerdos de equipo. [Agreements](./AGREEMENTS.md)

## Instalación docker

Requiere un entorno con docker instalado. [configuracion](./SUT_ENVIRONMENT.md)

### Instrucciones de ejecución del proyecto

Ejecute `make` para ver la lista de commandos disponibles.

Si su entorno (SO), no cuenta con con `make` entonces revise y ejecute los scripts de configuración en `setup/`, en el orden conveniente.

## Flujo de Trabajo del Proyecto

Una vez que el SUT se encuentra en ejecución, se debe seguir el siguiente flujo de trabajo para el desarrollo del proyecto:

1. **Verificación  del SUT**  
   Se valida que el sistema esté operativo mediante los scripts de healthcheck ubicados en la carpeta `setup/`.

2. **Identificación de atributos de calidad**  
   Se analizan y documentan los atributos de calidad relevantes del sistema (disponibilidad, confiabilidad, seguridad, mantenibilidad, etc.) en la carpeta `quality/`.

3. **Análisis de riesgos**  
   Se identifican y priorizan los riesgos técnicos y de pruebas asociados al SUT, documentados en la carpeta `risk/`.

4. **Diseño de pruebas**  
   Se definen escenarios de prueba, criterios de aceptación y reglas en la carpeta `design/` antes de la ejecución de pruebas.

5. **Ejecución de pruebas**  
   Las pruebas manuales y/o automatizadas se ejecutan mediante scripts ubicados en la carpeta `scripts/`.

6. **Recolección de evidencia**  
   Los resultados, logs y salidas de prueba se almacenan como evidencia objetiva en la carpeta `evidence/`, organizada por iteraciones o semanas.

7. **Documentación y reflexión**  
   El progreso, hallazgos y ajustes se registran en memorándums semanales ubicados en la carpeta `memos/`.


## Miembros del Equipo

- BALCAZAR VEIZAGA EVANS
- ROSALES FUENTES JORGE MARCELO
- CORDERO FLORES MARCELO
- PEREZ DELGADILLO SHIRLEY EULALIA
