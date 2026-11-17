# 📱 GUÍA: CÓMO AGREGAR EL WIDGET A TU IPHONE

## 🎯 Resumen Rápido

```
1. Compilar en Xcode (Cmd + B)
2. Ejecutar en tu iPhone (Cmd + R)
3. Configurar credenciales
4. Agregar widget a home screen
5. ¡Disfrutar! ☀️
```

---

## 🔧 PARTE 1: PREPARAR EL PROYECTO

### Paso 1.1: Abrir Xcode

```bash
# En Terminal:
open -a Xcode ~/Desktop/DeyeCloud
```

O simplemente:
- Abre Xcode
- File → Open
- Busca la carpeta del proyecto

### Paso 1.2: Seleccionar Device

```
Xcode top bar:
┌─────────────────────────────────────────┐
│ DeyeCloud        ▼  iPhone 15 Pro  ▼   |
│ (nombre proyecto)    (tu dispositivo)   |
└─────────────────────────────────────────┘
```

**OPCIÓN A: Simulador (Más fácil para pruebas)**
- Haz clic en "iPhone 15 Pro"
- Selecciona "iPhone 15 Pro Simulator"

**OPCIÓN B: iPhone Real (Requiere certificado)**
- Conecta tu iPhone con cable USB
- Aparecerá en la lista
- Confía en el certificado si es necesario

### Paso 1.3: Verificar Signing & Capabilities

```
Proyecto → DeyeCloud Target
├─ Signing & Capabilities
├─ ✓ Debe haber "App Groups"
├─ ✓ Con valor: group.com.deyecloud.widget
└─ ✓ Sin errores (rojo)
```

---

## 🛠️ PARTE 2: COMPILAR Y EJECUTAR

### Paso 2.1: Compilar

```
Xcode → Product → Build
O: Cmd + B

Espera a ver: ✅ Build Succeeded
```

Si hay errores:
1. Verifica App Groups configurado
2. Limpia: Cmd + Shift + K
3. Recompila: Cmd + B

### Paso 2.2: Ejecutar en Dispositivo

```
Xcode → Product → Run
O: Cmd + R

La app se abrirá en tu iPhone/simulador
```

**Esperado:** Pantalla con logo "Deye Cloud" y botones

### Paso 2.3: Permitir Acceso

Si aparecen mensajes:
- "Confiar en Developer Certificate" → Toca "Confiar"
- "Allow Deye Cloud to access your data" → Toca "Allow"

---

## 🔑 PARTE 3: CONFIGURAR CREDENCIALES

### Paso 3.1: Obtener Tus Credenciales

Ve a: https://www.deyecloud.com

1. Inicia sesión con tu cuenta
2. Ve a: **Configuración → API**
3. Haz clic: **"Generar nueva API Key"**
4. Copia tu **API Key** (larga cadena)
5. Ve a: **Dispositivos**
6. Copia tu **Device ID** (números y letras)

Ejemplo:
```
API Key:    abc123def456ghi789jkl012...
Device ID:  DS123456789ABCDEF
```

### Paso 3.2: Ingresar en la App

En tu iPhone:

```
App Deye Cloud abierta
   ↓
Toca: "Configurar Credenciales" (botón azul)
   ↓
Ingresa tu API Key en el primer campo
   ↓
Ingresa tu Device ID en el segundo campo
   ↓
Toca: "Guardar Credenciales" (botón verde)
   ↓
✅ Verás: "Credenciales guardadas correctamente"
   ↓
Cierra la app
```

**Pantalla de Configuración:**
```
┌─────────────────────────────┐
│  Configurar Widget Deye Cloud│
├─────────────────────────────┤
│                             │
│ 🔑 Dónde obtener tus cred   │
│    1. Ve a deyecloud.com    │
│    2. Genera API Key        │
│    3. Copia Device ID       │
│                             │
│ ┌───────────────────────┐   │
│ │ API Key               │   │
│ │ Pega tu API Key aquí  │   │
│ └───────────────────────┘   │
│                             │
│ ┌───────────────────────┐   │
│ │ Device ID             │   │
│ │ Pega Device ID aquí   │   │
│ └───────────────────────┘   │
│                             │
│  [✓ Guardar Credenciales]   │
│                             │
└─────────────────────────────┘
```

---

## 📲 PARTE 4: AGREGAR WIDGET A HOME SCREEN

### Paso 4.1: Ir a Home Screen

En tu iPhone:
```
Presiona Home button (lado)
O: Swipe desde arriba a la derecha
   (si usas Face ID)
```

Deberías ver tu home screen con aplicaciones.

### Paso 4.2: Acceder a Widgets

**Método 1: Long Press (Recomendado)**
```
1. Long press en espacio vacío de la home screen
   (mantén presionado 1-2 segundos)

2. Aparecerá menú flotante

3. Toca: "+" (en la esquina superior izquierda)
   O "Editar" si ya tienes widgets
```

**Método 2: Swipe Izquierda**
```
1. Home Screen
2. Swipe izquierda (hacia la izquierda)
3. Baja hasta abajo
4. Toca: "+" para agregar widget
```

### Paso 4.3: Buscar "Deye Cloud"

```
Pantalla de selección de widgets:
┌──────────────────────────────┐
│  🔍 Buscar widgets           │
│  ┌────────────────────────┐  │
│  │ [Deye Cloud          ] │  │
│  └────────────────────────┘  │
├──────────────────────────────┤
│                              │
│ ⭐ Deye Cloud (Compacto)     │
│    Monitor solar en tiempo   │
│    real - 2x2               │
│                              │
│ ⭐ Deye Cloud (Normal)       │
│    Visualización completa    │
│    del sistema solar - 4x2  │
│                              │
└──────────────────────────────┘
```

**Busca escribiendo:**
```
Toca en la barra de búsqueda
Escribe: "Deye Cloud"
Aparecerán los 2 widgets
```

### Paso 4.4: Seleccionar Tamaño

Tienes **2 opciones:**

**Opción A: Widget Compacto (2x2)**
```
✓ Deye Cloud (Compacto)
│
└─ Muestra:
   ☀️  Potencia generada
   ⚡ Potencia consumida
   🟢 Estado
   
✓ Perfecto para: Espacios pequeños
✓ Tamaño: 2x2 en home screen
```

**Opción B: Widget Normal (4x2)**
```
✓ Deye Cloud (Normal)
│
└─ Muestra:
   ☀️  Potencia generada (grande)
   ⚡ Potencia consumida (grande)
   🟢 Estado
   🕐 Hora de actualización
   
✓ Perfecto para: Más información
✓ Tamaño: 4x2 en home screen
```

### Paso 4.5: Agregar Widget

```
1. Toca en el widget que quieras
   (Compacto o Normal)

2. Aparecerá vista previa

3. Toca: "Agregar widget" (botón azul)

4. Elige donde colocarlo en home screen

5. Toca: "Agregar" (esquina superior derecha)

6. ✅ ¡Widget agregado!
```

---

## ✅ VERIFICACIÓN: ¿El Widget Funciona?

### ¿Qué deberías ver?

**Inmediatamente:**
```
┌─────────────────────────┐
│ ☀️ Deye Cloud      🟢   │
├─────────────────────────┤
│ Generando:        3.2 kW│
│ Consumiendo:      1.8 kW│
└─────────────────────────┘
```

**El indicador de estado debe ser:**
- 🟢 Verde = Online (todo bien)
- 🔴 Gris = Offline (sin conexión)
- ⚠️ Rojo = Error (problema con API)
- 🟡 Naranja = Standby (en espera)

### ¿El widget no muestra datos?

**Espera 15 minutos:**
- El widget se actualiza cada 15 minutos
- La primera actualización puede tardar

**Si sigue vacío:**
1. Revisa que ingresaste credenciales correctas
2. Verifica que tu instalación solar esté conectada
3. Abre la app → Toca "Actualizar Widget Ahora"
4. Largo press en widget → "Editar" → Reinicia

---

## 🔄 EDITAR O ELIMINAR WIDGET

### Editar Widget

```
1. Long press en el widget
2. Toca: "Editar widget"
3. Puedes cambiar:
   - Tamaño
   - Ubicación
   - Configuración
4. Toca: Fuera del widget para guardar
```

### Eliminar Widget

```
1. Long press en el widget
2. Toca: "Eliminar widget"
3. Toca: "Eliminar" para confirmar
4. ✓ Widget removido del home screen
   (La app sigue instalada)
```

---

## 🚀 PRÓXIMOS PASOS

### Personalizar

```
1. Cambiar colores en DeyeCloudWidget.swift
2. Agregar más datos de la API
3. Cambiar iconos
4. Ajustar intervalo de actualización
```

### Mejorar

```
1. Agregar widget de tamaño grande (4x4)
2. Agregar configuración interactiva
3. Implementar notificaciones
4. Agregar historial/gráficos
```

### Integrar

```
1. Conectar con Apple Health
2. Agregar Siri Shortcuts
3. Implementar iCloud Sync
4. Agregar análisis
```

---

## 🆘 TROUBLESHOOTING

### "Widget no aparece en la lista"

**Solución:**
1. Recompila en Xcode (Cmd + B)
2. Reinicia el simulador/iPhone
3. Cierra y abre home screen
4. Busca de nuevo

### "Dice 'Offline' aunque esté conectado"

**Solución:**
1. Verifica que API Key sea correcta
2. Verifica que Device ID sea correcto
3. Revisa conectividad de internet
4. Prueba la API desde Postman

### "Widget se congela o no se actualiza"

**Solución:**
1. Long press → "Editar widget"
2. Reinicia el widget
3. O elimina y agrega de nuevo
4. Revisa que App Groups esté configurado

### "Dice 'Error' en rojo"

**Solución:**
1. Abre la app
2. Toca "Actualizar Widget Ahora"
3. Verifica que tu sistema solar esté online
4. Revisa la API Key y Device ID

---

## 📱 COMPARACIÓN: SIMULADOR vs iPhone Real

| Aspecto | Simulador | iPhone Real |
|---------|-----------|-------------|
| **Requisito** | Xcode en Mac | iPhone + cable |
| **Velocidad** | Rápido | Normal |
| **Realismo** | Bueno | 100% real |
| **WiFi** | No necesario | Sí requiere |
| **Batería** | No aplica | Se usa batería |
| **Certificado** | No necesario | Puede requerir |
| **Facilidad** | Muy fácil | Fácil |

**Recomendación:** Comienza en simulador para probar, luego en iPhone real.

---

## 📸 PANTALLAS ESPERADAS

### Pantalla 1: App Abierta
```
┌────────────────────────────┐
│ ☀️ Deye Cloud Widget        │
│                            │
│ ✅ Configurado             │
│    Tu widget está listo    │
│                            │
│ [🔧 Configurar Credenciales│
│ [🔄 Actualizar Widget Ahora│
│                            │
│ Vista Previa del Widget:   │
│ ┌──────────────────────┐   │
│ │ ☀️ Deye Cloud  🟢    │   │
│ │ Generando:  2.5 kW   │   │
│ │ Consumiendo: 1.8 kW  │   │
│ └──────────────────────┘   │
└────────────────────────────┘
```

### Pantalla 2: Home Screen con Widget
```
┌─────────────────────────────────┐
│                                 │
│    Messages    FaceTime         │
│                                 │
│    ┌───────────────────────┐    │
│    │☀️ Deye Cloud      🟢   │    │
│    │                       │    │
│    │Generando:   3.2 kW    │    │
│    │Consumiendo: 1.8 kW    │    │
│    │                       │    │
│    └───────────────────────┘    │
│                                 │
│    Calendar    Weather          │
│                                 │
└─────────────────────────────────┘
```

---

## ✨ ¡LISTO!

Ahora tienes:
✅ App instalada en tu iPhone
✅ Widget agregado a home screen
✅ Monitoreo solar en tiempo real
✅ Actualización automática cada 15 minutos

**¡Disfruta tu widget!** ☀️📱

---

## 🎓 RECURSOS ADICIONALES

- Documentación de WidgetKit: https://developer.apple.com/documentation/widgetkit
- Deye Cloud API: https://docs.deyecloud.com
- Stack Overflow: Busca "iOS Widget" para más ejemplos

---

**Versión:** 1.0
**Probado en:** iOS 17.0+
**Última actualización:** 17 de noviembre de 2026
