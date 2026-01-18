# SUT_ENVIRONMENT.md
## Entorno de Ejecución del Sistema Bajo Prueba (SUT)

---

## 1. Propósito del documento

Este documento describe el **entorno de ejecución del Sistema Bajo Prueba (SUT)** utilizado en el proyecto *Repositorio de Evidencias para la Calidad de Software*. Su objetivo es garantizar la **reproducibilidad, trazabilidad y verificabilidad** de las evidencias de pruebas generadas.

---

## 2. Descripción general del entorno

El SUT se ejecuta en un entorno **contenedorizado**, utilizando Docker como plataforma de virtualización ligera. Este enfoque permite aislar el sistema, controlar dependencias y replicar el entorno de pruebas de forma consistente en diferentes equipos.

---

## 3. Sistema Operativo Host

- **Sistema Operativo:** Fedora Linux 43 (Workstation Edition)  
- **Arquitectura:** x86_64 (amd64)  
- **Kernel:** Linux (por defecto de la distribución)  

---

## 4. Plataforma de Contenedores

- **Tecnología:** Docker Engine  
- **Gestión de contenedores:** Docker CLI  
- **Modo de ejecución:** Contenedor individual  
- **Orquestación (opcional):** Docker Compose  

---

## 5. Configuración del SUT

| Elemento | Valor |
|--------|------|
| Nombre del contenedor | `petstore-sut` |
| Imagen Docker | `swaggerapi/swagger-petstore` |
| Versión de imagen | latest |
| Puerto del contenedor | 8080 |
| Puerto expuesto en host | 8080 |
| Protocolo | HTTP |

---

## 6. Comando de despliegue del SUT

El SUT se despliega utilizando el siguiente comando Docker:

```bash
docker run -d \
  --name petstore-sut \
  -p 8080:8080 \
  swaggerapi/swagger-petstore
