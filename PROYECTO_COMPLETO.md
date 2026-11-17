# Proyecto iOS: Deye Cloud Widget - Guía Completa

## 📱 Resumen del Proyecto

Este es un **proyecto iOS completo** con:
- ✅ Aplicación principal con interfaz de configuración
- ✅ Widget Extension para iOS 17+
- ✅ Integración con API de Deye Cloud
- ✅ Almacenamiento seguro usando App Groups
- ✅ Dos tamaños de widget (Compacto y Normal)

## 📁 Estructura de Archivos

```
DeyeCloudWidget/
├── DeyeCloudApp/                    # APP PRINCIPAL
│   ├── DeyeCloudApp.swift           # Punto de entrada + UI principal
│   ├── DeyeCloudSettingsView.swift  # Formulario de configuración
│   ├── DeyeCloudAPIService.swift    # Servicio de API
│   ├── Info-App.plist               # Configuración de app
│   └── Assets.xcassets/             # Iconos e imágenes
│
├── DeyeCloudWidget/                 # WIDGET EXTENSION
│   ├── DeyeCloudWidget.swift        # Lógica del widget
│   ├── DeyeCloudWidgetBundle.swift  # Bundler del widget
│   ├── Info-Widget.plist            # Configuración del widget
│   └── Assets.xcassets/             # Iconos del widget
│
└── Documentación/
    ├── SETUP_GUIA.md                # Guía de instalación
    └── README.md                     # Este archivo
```

## 🚀 Creación Paso a Paso en Xcode

### Paso 1: Crear el Proyecto Base

```bash
# En Xcode:
1. File → New → Project
2. Selecciona "App" bajo iOS
3. Nombre del proyecto: DeyeCloud
4. Organization Identifier: com.example (o tu dominio)
5. Bundle Identifier: com.example.deyecloud
6. Language: Swift
7. Interface: SwiftUI
8. Marcar: Use Core Data (NO)
9. Create
```

### Paso 2: Crear el Widget Extension

```bash
# En Xcode:
1. File → New → Target
2. Selecciona "Widget Extension"
3. Product Name: DeyeCloudWidget
4. Bundle Identifier: com.example.deyecloud.widget
5. Finish
6. Activate Scheme: Select DeyeCloudWidget
```

### Paso 3: Configurar App Groups

#### Para la App Principal:

```
1. Proyecto → DeyeCloud Target
2. Signing & Capabilities
3. "+ Capability"
4. Busca "App Groups"
5. Añade: group.com.deyecloud.widget
```

#### Para el Widget:

```
1. Proyecto → DeyeCloudWidget Target
2. Signing & Capabilities
3. "+ Capability"
4. Busca "App Groups"
5. Añade: group.com.deyecloud.widget
```

### Paso 4: Copiar Archivos

**Para la App Principal:**

1. Reemplaza `DeyeCloudApp.swift`:
   - Copia contenido de `DeyeCloudApp.swift`

2. Reemplaza `ContentView.swift`:
   - Copia contenido de `DeyeCloudSettingsView.swift`

3. Añade nuevo archivo `DeyeCloudAPIService.swift`:
   - File → New → File
   - Nombre: DeyeCloudAPIService.swift
   - Copia contenido

4. Reemplaza `Info.plist`:
   - Copia contenido de `Info-App.plist`

**Para el Widget Extension:**

1. Borra `DeyeCloudWidget.swift` (el que viene por defecto)

2. Añade nuevo archivo `DeyeCloudWidget.swift`:
   - Copia contenido del archivo principal `DeyeCloudWidget.swift`

3. Reemplaza `DeyeCloudWidgetBundle.swift`:
   - Copia contenido de `DeyeCloudWidgetBundle.swift`

4. Reemplaza `Info.plist`:
   - Copia contenido de `Info-Widget.plist`

### Paso 5: Verificar Bundle IDs

```
App Principal:          com.example.deyecloud
Widget Extension:       com.example.deyecloud.widget
App Groups (ambos):     group.com.deyecloud.widget
```

## 🔧 Configuración Adicional

### Versión Mínima de iOS

```
Proyecto → Build Settings
Search: "Minimum Deployments"
iOS: 17.0
```

### Capacidades Requeridas

```
✅ App Groups (ya configurado)
✅ Network (incluido por defecto)
```

## ✅ Compilación y Prueba

### Compilar la App:

```bash
# Scheme: DeyeCloud
# Destination: iPhone 15 Pro Simulator (o tu dispositivo)
Cmd + B  # Build
Cmd + R  # Run
```

### Compilar el Widget:

```bash
# Scheme: DeyeCloudWidget
# Destination: iPhone 15 Pro Simulator (o tu dispositivo)
Cmd + B  # Build
Cmd + R  # Run (abre en widget preview)
```

### Probar en Dispositivo Real:

```bash
1. Conecta tu iPhone
2. Selecciona tu dispositivo en Device selector
3. Elige el Scheme (DeyeCloud o DeyeCloudWidget)
4. Cmd + R para compilar e instalar
5. Confía en el certificado de desarrollador si es necesario
```

## 🎯 Uso Final

### En tu iPhone:

1. **Abre la App**
   - Verás la pantalla de inicio
   - Toca "Configurar Credenciales"
   - Ingresa tu API Key y Device ID

2. **Guarda Credenciales**
   - La app confirmará la guardación
   - El widget se actualizará automáticamente

3. **Agrega el Widget a Home Screen**
   - Long press en home screen
   - Toca "+"
   - Busca "Deye Cloud"
   - Selecciona tamaño (Compacto o Normal)
   - Toca "Agregar widget"

4. **Visualiza Datos en Tiempo Real**
   - El widget se actualiza cada 15 minutos
   - Muestra potencia generada/consumida
   - Indicador de estado del sistema

## 🔐 Consideraciones de Seguridad

### App Groups

Los App Groups permiten compartir datos entre la app y el widget de forma segura:

```swift
// Guardando en App Group
let defaults = UserDefaults(suiteName: "group.com.deyecloud.widget")
defaults?.set(apiKey, forKey: "deyecloud_api_key")

// Leyendo desde App Group
let apiKey = defaults?.string(forKey: "deyecloud_api_key")
```

### Recomendaciones

⚠️ **NUNCA** hagas commit de API Keys en Git:

```bash
# Archivo .gitignore
*.key
*.secret
credentials.plist
```

✅ **MEJOR PRÁCTICA**: Usa un servidor backend para autenticar solicitudes API

## 🛠️ Troubleshooting

### "No App Groups found"

```
Solución:
1. Verifica que ambos targets tengan App Groups
2. Que usen el MISMO grupo: group.com.deyecloud.widget
3. Limpia Build Folder (Cmd + Shift + K)
4. Rebuild
```

### "Widget doesn't update"

```
Solución:
1. Widget debe estar en iOS 17+
2. Verifica que las credenciales estén guardadas
3. Long press widget → "Editar" → Reinicia
4. Revisa Console en Xcode (Cmd + Shift + C)
```

### "API request fails"

```
Solución:
1. Verifica conectividad de internet
2. Valida que API Key y Device ID sean correctos
3. Revisa documentación de Deye Cloud API
4. Prueba la API con cURL o Postman
```

## 📚 Recursos Útiles

- [Deye Cloud API Docs](https://docs.deyecloud.com)
- [Apple WidgetKit Documentation](https://developer.apple.com/documentation/widgetkit)
- [App Groups Documentation](https://developer.apple.com/documentation/foundation/userdefaults)
- [Swift UI Documentation](https://developer.apple.com/documentation/swiftui)

## 📞 Soporte

Para problemas específicos:

1. Revisa los logs en Xcode Console
2. Consulta la documentación de Deye Cloud
3. Verifica los requisitos de iOS 17+
4. Asegúrate de que los Bundle IDs sean consistentes

---

**Versión:** 1.0  
**Lenguaje:** Swift 5.9+  
**iOS Mínimo:** 17.0  
**Última actualización:** 2024
