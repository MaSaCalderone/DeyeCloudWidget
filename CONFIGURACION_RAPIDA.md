# Configuración Rápida en Xcode

Este archivo te ayuda a configurar rápidamente el proyecto. Sigue estos pasos exactamente como se indican.

## ⚡ Configuración Rápida (10 minutos)

### 1️⃣ Crear Proyecto Base (2 min)

```
Xcode → File → New → Project

Opciones:
├─ Plataforma: iOS
├─ Tipo: App
├─ Nombre del Producto: DeyeCloud
├─ Equipo: Tu equipo de desarrollo
├─ Organización: Tu nombre/empresa
├─ Bundle Identifier: com.example.deyecloud
├─ Interfaz: SwiftUI
├─ Language: Swift
└─ Crear
```

### 2️⃣ Crear Widget Extension (2 min)

```
Xcode → File → New → Target

Opciones:
├─ Plataforma: iOS
├─ Tipo: Widget Extension
├─ Nombre del Producto: DeyeCloudWidget
├─ Bundle Identifier: com.example.deyecloud.widget
├─ Lenguaje: Swift
└─ Finish → Activate Scheme
```

### 3️⃣ Configurar App Groups - APP (1 min)

```
Proyecto → DeyeCloud
  ├─ Signing & Capabilities
  ├─ "+ Capability"
  ├─ Busca: "App Groups"
  ├─ Haz clic para añadir
  └─ Ingresa: group.com.deyecloud.widget
```

### 4️⃣ Configurar App Groups - WIDGET (1 min)

```
Proyecto → DeyeCloudWidget
  ├─ Signing & Capabilities
  ├─ "+ Capability"
  ├─ Busca: "App Groups"
  ├─ Haz clic para añadir
  └─ Ingresa: group.com.deyecloud.widget
```

### 5️⃣ Copiar Archivos - APP PRINCIPAL (2 min)

**Archivo 1: DeyeCloudApp.swift**
```
1. Abre: DeyeCloud → DeyeCloudApp.swift
2. Selecciona TODO (Cmd + A)
3. Elimina
4. Copia contenido del archivo "DeyeCloudApp.swift"
5. Pega en Xcode
```

**Archivo 2: DeyeCloudSettingsView.swift**
```
1. Abre: DeyeCloud → ContentView.swift (renombra a DeyeCloudSettingsView.swift)
2. O crea nuevo archivo: File → New → File
3. Nombre: DeyeCloudSettingsView.swift
4. Copia contenido del archivo
5. Pega en Xcode
```

**Archivo 3: DeyeCloudAPIService.swift**
```
1. File → New → File
2. Nombre: DeyeCloudAPIService.swift
3. Copia contenido del archivo
4. Pega en Xcode
```

**Archivo 4: SharedModels.swift**
```
1. File → New → File
2. Nombre: SharedModels.swift
3. Copia contenido del archivo
4. Pega en Xcode
```

**Archivo 5: Info.plist (APP)**
```
1. Project → DeyeCloud → Info
2. Reemplaza el contenido con Info-App.plist
   O en Project.pbxproj:
   - Busca: CFBundleName
   - Reemplaza todo con contenido de Info-App.plist
```

### 6️⃣ Copiar Archivos - WIDGET EXTENSION (2 min)

**Archivo 1: DeyeCloudWidget.swift**
```
1. Abre: DeyeCloudWidget → DeyeCloudWidget.swift
2. Selecciona TODO (Cmd + A)
3. Elimina
4. Copia contenido del archivo "DeyeCloudWidget.swift"
5. Pega en Xcode
```

**Archivo 2: DeyeCloudWidgetBundle.swift**
```
1. Reemplaza el contenido actual
2. O crea nuevo archivo: File → New → File
3. Nombre: DeyeCloudWidgetBundle.swift
4. Copia contenido del archivo
5. Pega en Xcode
```

**Archivo 3: Info.plist (WIDGET)**
```
1. Project → DeyeCloudWidget → Info
2. Reemplaza el contenido con Info-Widget.plist
```

## ✅ Verificación

Después de completar los pasos anteriores, verifica:

### Build Settings

```
Proyecto → Build Settings

Versión mínima de iOS:
├─ iOS Deployment Target: 17.0 (ambos targets)

Otros:
├─ Product Bundle Identifier (APP): com.example.deyecloud
├─ Product Bundle Identifier (WIDGET): com.example.deyecloud.widget
└─ Code Sign Identity: Apple Development Certificate
```

### Esquemas

```
Xcode → Product → Scheme

Verifica que existan:
├─ DeyeCloud (APP)
└─ DeyeCloudWidget (WIDGET)

Ambos deben compilar sin errores
```

## 🧪 Pruebas Iniciales

### Test 1: Compilar APP

```bash
# En Xcode:
1. Scheme: DeyeCloud
2. Destino: iPhone 15 Pro Simulator
3. Product → Build (Cmd + B)

✅ Esperado: Build Succeeded
```

### Test 2: Compilar WIDGET

```bash
# En Xcode:
1. Scheme: DeyeCloudWidget
2. Destino: iPhone 15 Pro Simulator
3. Product → Build (Cmd + B)

✅ Esperado: Build Succeeded
```

### Test 3: Ejecutar APP

```bash
# En Xcode:
1. Scheme: DeyeCloud
2. Destino: iPhone 15 Pro Simulator
3. Product → Run (Cmd + R)

✅ Esperado: Simulador abre con la app
```

### Test 4: Preview del Widget

```bash
# En Xcode:
1. Scheme: DeyeCloudWidget
2. Destino: iPhone 15 Pro Simulator
3. Abre: DeyeCloudWidget.swift
4. Canvas → Resume (esquina superior derecha)

✅ Esperado: Ves el widget en la preview
```

## 🎯 Próximo Paso

Cuando todo compile correctamente:

1. Abre la app en el simulador
2. Toca "Configurar Credenciales"
3. Ingresa tus API Key y Device ID de Deye Cloud
4. Guarda

El widget estará listo para usar en tu home screen.

## 🆘 Problemas Comunes

### Error: "Bundle Identifier mismatch"
```
Solución:
1. Project → Target → Build Settings
2. Product Bundle Identifier
3. APP: com.example.deyecloud
4. WIDGET: com.example.deyecloud.widget
5. Limpiar Build Folder (Cmd + Shift + K)
6. Rebuild
```

### Error: "App Groups not found"
```
Solución:
1. Proyecto → Target → Signing & Capabilities
2. Verifica que exista "+ Capability"
3. Búsca "App Groups"
4. Ambos targets deben tener: group.com.deyecloud.widget
```

### Error: "iOS 16 or later required"
```
Solución:
1. Build Settings → iOS Deployment Target
2. Cambia a 17.0 (iOS 17.0)
3. Ambos targets deben ser 17.0
```

### "Cannot resolve symbol" errors
```
Solución:
1. Verifica que todos los archivos .swift estén copiados
2. Build Settings → Swift Language Version: 5.9 o más
3. Limpiar Build Folder (Cmd + Shift + K)
4. Rebuild
```

---

**Tiempo Total Estimado:** 10-15 minutos  
**Siguiente:** Pruebas de integración con API real
