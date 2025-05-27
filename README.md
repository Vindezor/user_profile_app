# 📱 Prueba Técnica - Perfil de Usuario (Flutter)

Esta aplicación fue desarrollada como parte de una prueba técnica. El objetivo fue construir una pequeña app en Flutter que permita visualizar y editar el perfil de un usuario, simulando un entorno de aplicación laboral.

---

## 🧩 Funcionalidad principal

- Pantalla de **perfil de usuario** con:
  - Imagen de perfil
  - Nombre completo
  - Correo electrónico
  - Puesto de trabajo

- Pantalla de **edición de perfil** con:
  - Posibilidad de cambiar nombre y puesto
  - Cambio de imagen de perfil
  - Campo de correo visible pero no editable
  - Botón de guardar habilitado solo si hay cambios reales
  - Simulación de guardado con loading y mensajes de feedback

---

## 📦 Paquetes utilizados

| Paquete          | Descripción                                           |
|------------------|-------------------------------------------------------|
| flutter_riverpod | Manejador de estado reactivo                          |
| go_router        | Para el manejo de rutas                               |
| http             | Cliente HTTP nativo para llamadas a API               |
| image_picker     | Selección de imágenes desde galería o cámara          |
| google_fonts     | Integración de fuentes tipográficas de Google Fonts   |

---

## 🚀 Cómo correr el proyecto

### Requisitos

- Flutter SDK (3.10 o superior)
- Dart SDK (3.0 o superior)
- Un emulador de android o un telefono físico en modo depuración USB

### Pasos

```bash
git clone https://github.com/tuusuario/flutter-user-profile.git
cd flutter-user-profile
flutter pub get
flutter run
```

---

## 📝 Notas adicionales

- La aplicación no persiste los cambios de manera permanente, pero refleja las modificaciones en la interfaz.

- El manejo del estado está basado en Riverpod para mantener un flujo reactivo y limpio.

- La navegación se realiza con GoRouter, facilitando rutas declarativas y sencillas.

