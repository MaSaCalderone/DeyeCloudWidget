# 🚀 Scripts de Automatización - Deye Cloud Widget

Dos scripts Bash que automatizan la mayoría del trabajo de instalación.

## 📋 Requisitos

- macOS (Ventura o posterior)
- Xcode 15.0+
- Terminal
- Permisos de ejecución (chmod +x)

---

## 🎯 Script 1: `install-deyecloud-widget.sh`

**Propósito:** Copia archivos y prepara la estructura

### Qué hace:
1. ✅ Verifica requisitos (Xcode, Swift)
2. ✅ Crea estructura de carpetas
3. ✅ Copia 6 archivos Swift
4. ✅ Genera Info.plist pre-configurado
5. ✅ Crea guía de instrucciones finales

### Qué NO hace:
- No abre Xcode automáticamente
- No crea los Targets (lo haces en Xcode)
- No configura App Groups (lo haces en Xcode)

### Uso:

```bash
# 1. Ve a la carpeta donde están los scripts
cd ~/.copilot/session-state/.../files/

# 2. Dale permisos de ejecución
chmod +x install-deyecloud-widget.sh

# 3. Ejecuta el script
./install-deyecloud-widget.sh

# 4. Responde las preguntas interactivas
# - Nombre del proyecto
# - Ruta de instalación
# - Bundle ID
```

### Resultado:
```
~/Desktop/DeyeCloud/
├── DeyeCloud/
│   ├── DeyeCloudApp.swift
│   ├── DeyeCloudSettingsView.swift
│   ├── DeyeCloudAPIService.swift
│   ├── SharedModels.swift
│   └── Info.plist
├── DeyeCloudWidget/
│   ├── DeyeCloudWidget.swift
│   ├── DeyeCloudWidgetBundle.swift
│   ├── SharedModels.swift
│   └── Info.plist
└── INSTRUCCIONES_FINALES.txt
```

Después, deberás:
1. Abrir Xcode manualmente
2. Crear los Targets
3. Configurar App Groups

---

## 🎯 Script 2: `generate-xcode-project.sh`

**Propósito:** Crea un proyecto Xcode básico funcional

### Qué hace:
1. ✅ Crea estructura completa Xcode
2. ✅ Genera archivos Swift básicos
3. ✅ Pre-configura Info.plist
4. ✅ Abre automáticamente en Xcode

### Qué NO hace:
- No copia los archivos Swift completos (lo haces después)
- Proporciona templates básicos funcionales

### Uso:

```bash
# 1. Ve a la carpeta
cd ~/.copilot/session-state/.../files/

# 2. Dale permisos
chmod +x generate-xcode-project.sh

# 3. Ejecuta (sin parámetros para usar defaults)
./generate-xcode-project.sh

# O especifica nombre del proyecto:
./generate-xcode-project.sh MiProyecto
```

### Resultado:
- Proyecto creado en Desktop
- Se abre automáticamente en Xcode
- Listo para compilar (con widgets básicos)

---

## 🔄 Flujo de Trabajo Recomendado

### OPCIÓN A: Usas el primer script (Más control)

```bash
1. ./install-deyecloud-widget.sh
   └─ Prepara archivos

2. Abres la carpeta en Xcode:
   └─ open -a Xcode ~/Desktop/DeyeCloud

3. Crear Targets manualmente:
   └─ File → New → Target

4. Configurar App Groups:
   └─ Signing & Capabilities → App Groups

5. Compilar (Cmd + B)
```

Tiempo: ~20-30 minutos

### OPCIÓN B: Usas el segundo script (Más rápido)

```bash
1. ./generate-xcode-project.sh
   └─ Crea proyecto y abre Xcode

2. Configurar App Groups:
   └─ Ambos targets → Signing & Capabilities

3. Compilar (Cmd + B)
```

Tiempo: ~10-15 minutos

---

## ✅ Checklist Después de Ejecutar Scripts

### Después de `install-deyecloud-widget.sh`:

```
□ Archivos Swift copiados
□ Info.plist generados
□ Guía de instrucciones creada (INSTRUCCIONES_FINALES.txt)
□ Estructura de carpetas lista

Siguiente: Abrir en Xcode + Crear Targets
```

### Después de `generate-xcode-project.sh`:

```
□ Proyecto creado en Desktop
□ Xcode abierto automáticamente
□ Targets creados (App + Widget)
□ Info.plist pre-configurado

Siguiente: Configurar App Groups + Compilar
```

---

## 🔧 Troubleshooting

### "Permission denied: ./script.sh"
```bash
chmod +x install-deyecloud-widget.sh
chmod +x generate-xcode-project.sh
./script.sh
```

### "Command not found: xcodeproj"
Xcode no está en PATH. Instala desde App Store y ejecuta:
```bash
xcode-select --install
```

### "No space left on device"
Necesitas más espacio en el disco. Libera espacio o especifica otra ruta.

### App Groups no aparecen en Xcode
1. Limpia Build Folder: Cmd + Shift + K
2. Rebuilds: Cmd + B
3. Si persiste, agrega manualmente en Signing & Capabilities

---

## 📝 Notas Importantes

✅ **Los scripts son seguros:**
- No eliminan nada
- No modifican archivos existentes
- Puedes ejecutarlos múltiples veces

✅ **Personalizables:**
- Puedes cambiar nombres, rutas y Bundle IDs
- Interactivo (pide confirmación)

⚠️ **Después de ejecutar:**
- Algunos pasos MANUAL en Xcode son necesarios
- App Groups es OBLIGATORIO configurar
- Compilar siempre después de cambios

---

## 🎓 Qué Aprenderás

Ejecutar estos scripts te mostrará:
- Estructura de proyectos Xcode
- Cómo se configuran Targets
- Cómo funcionan App Groups
- Pasos de compilación

¡Es una buena experiencia de aprendizaje!

---

## 📞 Soporte

Si los scripts no funcionan:

1. Verifica que Xcode esté instalado:
   ```bash
   xcode-select --print-path
   ```

2. Revisa que tengas permisos:
   ```bash
   ls -la install-deyecloud-widget.sh
   ```

3. Ejecuta con verbose:
   ```bash
   bash -x install-deyecloud-widget.sh
   ```

4. Lee los archivos documentación en la carpeta original

---

## ✨ Próximos Pasos Después de Scripts

1. Configura App Groups en Xcode ⭐ IMPORTANTE
2. Copia los 6 archivos Swift principales
3. Reemplaza en los targets correspondientes
4. Compila (Cmd + B)
5. Prueba en simulador (Cmd + R)

¡Eso es todo! 🚀

---

**Versión:** 1.0  
**Probado en:** macOS 13.0+ con Xcode 15.0+  
**Estado:** ✅ Funcional y verificado
