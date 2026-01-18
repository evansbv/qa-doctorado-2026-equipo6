# SUT_SELECTION.md
## Selección del Sistema Bajo Prueba (SUT)

---

## SUT elegido

**Nombre:** Swagger Petstore  

**Tipo:**  
API REST de referencia (aplicación de demostración basada en OpenAPI)

**Fuente:**  
Repositorio oficial Swagger API  
https://github.com/swagger-api/swagger-petstore  
Imagen Docker oficial: `swaggerapi/swagger-petstore`

---

## Descripción general del SUT

Swagger Petstore es una aplicación de ejemplo ampliamente utilizada para demostrar, documentar y probar APIs REST basadas en la especificación OpenAPI. Proporciona un conjunto completo de endpoints que permiten operaciones CRUD sobre entidades como mascotas, usuarios y pedidos, sirviendo como un sistema representativo para actividades de testing y evaluación de calidad de software.

El SUT puede desplegarse de manera reproducible mediante contenedores Docker, lo que facilita su uso en entornos controlados de prueba.

---

## Motivos de selección

1. **Representatividad técnica**  
   El SUT implementa una API REST completa con operaciones CRUD, permitiendo evaluar múltiples aspectos de calidad como funcionalidad, confiabilidad, rendimiento y seguridad.

2. **Estándar abierto y ampliamente aceptado**  
   Swagger Petstore está basado en la especificación OpenAPI, un estándar reconocido en la industria para la documentación y validación de servicios REST.

3. **Disponibilidad de documentación formal**  
   El SUT cuenta con documentación clara y estructurada a través de Swagger UI, lo que facilita la definición de casos de prueba y la validación del contrato API.

4. **Reproducibilidad del entorno**  
   La existencia de una imagen Docker oficial permite desplegar el SUT de manera consistente, eliminando dependencias del entorno y favoreciendo la repetibilidad de las pruebas.

5. **Adecuación para pruebas automatizadas**  
   El SUT es compatible con herramientas de testing funcional, de carga y de seguridad como Postman, Newman, k6 y OWASP ZAP.

6. **Separación clara entre testing y QA**  
   Al ser un sistema de referencia, el SUT permite centrarse en la generación de evidencias de pruebas sin mezclar aspectos de gestión del proceso de calidad (QA).

7. **Uso extendido en contextos académicos y profesionales**  
   Swagger Petstore es ampliamente utilizado en formación, investigación y demostraciones técnicas, lo que facilita la comparación de resultados y la validación externa.

---



