# SUT_ENVIRONMENT.md
## Entorno de Ejecución del Sistema Bajo Prueba (SUT)

---

## 1. Objetivo

Documentar de manera detallada el proceso de preparación del entorno necesario para la ejecución del Sistema Bajo Prueba (SUT) **Swagger Petstore**, garantizando reproducibilidad, trazabilidad y control del contexto experimental para la generación de evidencias de calidad de software.

---

## 2. Sistema Operativo Base

- **Sistema Operativo:** Fedora Linux 43
- **Edición:** Workstation
- **Arquitectura:** x86_64
- **Usuario:** Usuario estándar con privilegios administrativos (sudo)

---

## 3. Instalación de Docker Engine

### 3.1 Eliminación de posibles versiones previas

```bash
sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
```

---

### 3.2 Instalación de dependencias

```bash
sudo dnf install -y dnf-plugins-core
```

---

### 3.3 Adición del repositorio oficial de Docker

```bash
sudo dnf config-manager \
  --add-repo \
  https://download.docker.com/linux/fedora/docker-ce.repo
```

---

### 3.4 Instalación de Docker

```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

## 4. Activación del servicio Docker

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Verificación del estado:

```bash
systemctl status docker
```

---

## 5. Configuración de permisos de usuario

Para permitir el uso de Docker sin privilegios de superusuario:

```bash
sudo usermod -aG docker $USER
```

> **Nota:** Es necesario cerrar sesión y volver a iniciarla para que el cambio tenga efecto.

---

## 6. Verificación de la instalación

### 6.1 Verificación de versión

```bash
docker version
```

---

### 6.2 Prueba funcional con imagen de validación

```bash
docker run hello-world
```

Resultado esperado:

- Mensaje “Hello from Docker!”
- Confirmación de descarga y ejecución exitosa del contenedor

---

## 7. Obtención de la imagen del SUT

### 7.1 Descarga de la imagen oficial

```bash
docker pull swaggerapi/swagger-petstore
```

---

### 7.2 Verificación de la imagen descargada

```bash
docker images
```

---

## 8. Puesta en funcionamiento del SUT

### 8.1 Creación y ejecución del contenedor

```bash
docker run -d \
  --name petstore-sut \
  -p 8080:8080 \
  swaggerapi/swagger-petstore
```

---

### 8.2 Verificación del contenedor en ejecución

```bash
docker ps
```

---

## 9. Validación funcional del SUT

### 9.1 Acceso a la interfaz Swagger UI

Desde un navegador web:

```
http://localhost:8080
```

o

```
http://localhost:8080/swagger-ui.html
```

---

### 9.2 Prueba básica vía línea de comandos

```bash
curl http://localhost:8080/v2/pet/1
```

Respuesta esperada (ejemplo):

```json
{
  "id": 1,
  "name": "doggie",
  "status": "available"
}
```

---

## 10. Identificación del entorno para trazabilidad

- **SUT:** Swagger Petstore
- **Imagen Docker:** swaggerapi/swagger-petstore
- **Contenedor:** petstore-sut
- **Puerto expuesto:** 8080
- **Medio de ejecución:** Docker Engine
- **Host:** Fedora Linux 43

---

## 11. Consideraciones de reproducibilidad

- El uso de contenedores Docker elimina dependencias específicas del sistema anfitrión.
- El entorno puede ser replicado en cualquier host compatible con Docker.
- Las evidencias generadas deben registrar la versión de la imagen y la fecha de ejecución.

---

## 12. Alcance del entorno

Este entorno se utiliza exclusivamente para la **ejecución del SUT con fines de testing**, y no para despliegues productivos, garantizando la separación entre entornos de prueba y operación.

---
