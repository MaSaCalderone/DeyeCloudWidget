# Widget Deye Cloud para iOS

Un widget nativo para mostrar en tiempo real la **potencia generada**, **potencia consumida** y **estado del sistema** de tu instalación solar Deye Cloud.

## 🎯 Características

✅ **Widget Compacto (Small)** - Visualización rápida en 2x2  
✅ **Widget Normal (Medium)** - Información completa en 4x2  
✅ **Actualización cada 15 minutos** - Siempre sincronizado  
✅ **Indicadores de estado** - Online/Offline/Error/Standby  
✅ **Datos en caché** - Funciona sin conexión  

## 📋 Requisitos Previos

- iOS 17.0 o superior (Swift 5.9+)
- Cuenta de Deye Cloud con API activa
- API Key y Device ID de tu sistema

## 🚀 Pasos de Instalación

### 1. Obtener Credenciales de API

1. Accede a [Deye Cloud API Documentation](https://docs.deyecloud.com)
2. Registra tu aplicación y obtén tu **API Key**
3. Encuentra tu **Device ID** en la aplicación Deye Cloud o panel de control

### 2. Crear Widget Extension en Xcode

```bash
# En Xcode:
# 1. File → New → Target
# 2. Selecciona "Widget Extension"
# 3. Nombre: DeyeCloudWidget
# 4. Bundle ID: com.tuapp.deyecloud.widget
```

### 3. Copiar Archivos

1. Copia el contenido de `DeyeCloudWidget.swift` a tu nuevo target
2. Copia el contenido de `DeyeCloudAPIService.swift` para consumir la API

### 4. Configurar App Groups

**En tu app principal (Info.plist o Xcode):**
```xml
<key>com.apple.security.application-groups</key>
<array>
    <string>group.com.deyecloud.widget</string>
</array>
```

**En el Widget Extension (Info.plist o Xcode):**
```xml
<key>com.apple.security.application-groups</key>
<array>
    <string>group.com.deyecloud.widget</string>
</array>
```

### 5. Integrar en tu Aplicación

En el ViewController o View de configuración de tu app:

```swift
import WidgetKit

// Cuando el usuario ingrese sus credenciales:
DeyeCloudAPIService.shared.configure(
    apiKey: "tu_api_key_aqui",
    deviceID: "tu_device_id_aqui"
)

// Guardar para acceso del widget
DeyeCloudWidgetDefaults.saveAPIKey("tu_api_key_aqui")
DeyeCloudWidgetDefaults.saveDeviceID("tu_device_id_aqui")

// Notificar al widget que actualice
WidgetCenter.shared.reloadAllTimelines()
```

### 6. Actualizar Datos en Tiempo Real

Para obtener datos reales de Deye Cloud, reemplaza el método `getTimeline` en `DeyeCloudProvider`:

```swift
func getTimeline(in context: Context, completion: @escaping (Timeline<DeyeCloudEntry>) -> ()) {
    Task {
        do {
            // Cargar credenciales guardadas
            if let apiKey = DeyeCloudWidgetDefaults.getAPIKey(),
               let deviceID = DeyeCloudWidgetDefaults.getDeviceID() {
                
                DeyeCloudAPIService.shared.configure(
                    apiKey: apiKey,
                    deviceID: deviceID
                )
                
                let data = try await DeyeCloudAPIService.shared.fetchDeviceData()
                DeyeCloudWidgetDefaults.saveCachedData(data)
                
                let entry = DeyeCloudEntry(date: Date(), data: data)
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
        } catch {
            // Usar datos en caché si hay error
            let cachedData = DeyeCloudWidgetDefaults.getCachedData() ?? 
                DeyeCloudData(
                    powerGeneration: 0,
                    powerConsumption: 0,
                    status: .offline,
                    lastUpdate: Date()
                )
            let entry = DeyeCloudEntry(date: Date(), data: cachedData)
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
}
```

## 🔐 Seguridad

⚠️ **IMPORTANTE:**
- **NUNCA** commits tu API Key en el código fuente
- Usa variables de entorno o configuración segura
- Considera usar un servidor backend para autenticar solicitudes API
- El widget comparte datos vía App Groups (definido en Info.plist)

## 🛠️ Troubleshooting

### El widget no se actualiza
- Verifica que App Groups esté configurado correctamente
- Revisa que iOS 17+ esté instalado
- Reconstruye el widget: Long press → "Editar" → Reinicia

### Errores de API
- Verifica que la API Key sea válida
- Confirma que el Device ID es correcto
- Revisa la documentación de Deye Cloud API

### Datos vacíos
- Asegúrate de que tu instalación solar esté conectada
- Verifica la conectividad de internet
- Espera a que se complete el primer ciclo de actualización (15 min)

## 📱 Vistas Previas Personalizables

Para customizar el diseño, edita las vistas en:
- `DeyeCloudWidgetSmall` - Vista compacta
- `DeyeCloudWidgetMedium` - Vista normal

Puedes cambiar:
- Colores (`.foregroundColor()`)
- Iconos (systemName en `Image`)
- Tipografía (`.font()`)
- Espaciado (`.padding()`, `.spacing`)

## 📞 Soporte

Para problemas:
1. Consulta [Deye Cloud API Docs](https://docs.deyecloud.com)
2. Revisa los logs de Xcode (Debug → Simulador)
3. Verifica la configuración de Bundle IDs

## 📄 Licencia

Este código es de ejemplo para tu uso personal con la API de Deye Cloud.
