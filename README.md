# CRM App - Flutter & Kotlin Integration

## Descripción

Este proyecto es una aplicación móvil desarrollada en **Flutter** con integración de **Kotlin** en el backend para la autenticación y manejo de contactos de un sistema CRM. La app permite a los usuarios autenticarse, obtener un token de acceso, y mostrar una lista de contactos del CRM utilizando una API.

## Características principales:

- **Autenticación de usuario**: Login basado en un token de acceso obtenido a través de la API del CRM.
- **Validación del formulario**: Verifica que los campos de usuario y contraseña no estén vacíos antes de realizar la autenticación.
- **Manejo de errores**: Muestra mensajes de error visuales en caso de fallos durante la autenticación o la obtención del token.
- **Lista de contactos**: Obtención y visualización de contactos en una tabla después de un login exitoso.
- **Uso de Kotlin**: Las solicitudes HTTP a la API (como la obtención de contactos y autenticación) se gestionan desde Kotlin mediante `MethodChannel`.
  
## Requerimientos

- **Flutter** 3.x
- **Kotlin** 1.x
- **API CRM**: Utiliza la API de un CRM para obtener el token de autenticación, iniciar sesión, y obtener los contactos.

## Funcionalidades:

1. **Pantalla de Login**:
   - Permite ingresar un **nombre de usuario** y **contraseña**.
   - Incluye un botón para **obtener el token** necesario para la autenticación.
   - **Validación de campos**: No permite que los campos estén vacíos.

2. **Obtención del Token**:
   - El token es generado y mostrado en la pantalla, con la opción de copiarlo al portapapeles.

3. **Autenticación**:
   - El usuario puede iniciar sesión utilizando el **nombre de usuario** y la **accessKey** generada.
   - Al iniciar sesión correctamente, se obtiene el `sessionName`.

4. **Visualización de contactos**:
   - Tras una autenticación exitosa, se obtiene una lista de **contactos** desde la API CRM, que se muestra en una tabla con el **ID** y **nombre** de cada contacto.

5. **Manejo de errores**:
   - Si hay errores en el login o en la obtención del token, se muestra un mensaje de error en la pantalla.
   - Si los campos no están completos, se muestra un mensaje de advertencia.

## Estructura del proyecto:

- **lib/main.dart**: Pantalla principal de login y manejo de la lógica de autenticación.
- **lib/contacts_table_screen.dart**: Pantalla que muestra la tabla de contactos después de una autenticación exitosa.
- **android/app/src/main/kotlin/com/example/crm_app/RequestHandler.kt**: Archivo en Kotlin que gestiona las solicitudes HTTP a la API del CRM.
- **android/app/src/main/kotlin/com/example/crm_app/ChallengeResponse.kt**: Modelo de respuesta que define la estructura de la respuesta de la API para el token.
  
## Instrucciones para clonar y ejecutar el proyecto:

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/crm_app.git
