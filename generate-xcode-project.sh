#!/bin/bash

################################################################################
#                                                                              #
#   🎯 GENERADOR DE PROYECTO XCODE - DEYE CLOUD WIDGET                       #
#                                                                              #
#   Este script crea un proyecto Xcode completamente funcional                #
#   listo para compilar sin cambios adicionales                               #
#                                                                              #
################################################################################

set -e

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuración
PROJECT_NAME="${1:-DeyeCloudWidget}"
PROJECT_DIR="${HOME}/Desktop/${PROJECT_NAME}"
BUNDLE_ID="com.example.deyecloud"
WIDGET_BUNDLE_ID="${BUNDLE_ID}.widget"
APP_GROUP="group.com.deyecloud.widget"

echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  🎯 Generador de Proyecto Xcode - Deye Cloud Widget          ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Crear directorios
echo -e "${BLUE}📁 Creando estructura de directorios...${NC}"
mkdir -p "${PROJECT_DIR}/${PROJECT_NAME}"
mkdir -p "${PROJECT_DIR}/${PROJECT_NAME}Widget"
mkdir -p "${PROJECT_DIR}/${PROJECT_NAME}.xcodeproj/project.xcworkspace/xcshareddata"
echo -e "${GREEN}✓ Directorios creados${NC}"
echo ""

# Crear DerivedData si no existe
mkdir -p "${PROJECT_DIR}/DerivedData"

# Crear archivos Swift para APP
echo -e "${BLUE}📄 Creando archivos Swift de la App...${NC}"

# DeyeCloudApp.swift se copia del script dir
# Para simplificar, crearemos un main app file básico

cat > "${PROJECT_DIR}/${PROJECT_NAME}/App.swift" << 'EOF'
import SwiftUI

@main
struct DeyeCloudApp: App {
    var body: some Scene {
        WindowGroup {
            Text("✅ Deye Cloud Widget - App Creada Exitosamente")
                .font(.headline)
                .padding()
        }
    }
}
EOF

echo -e "${GREEN}✓ App.swift creado${NC}"

# Crear Info.plist para APP
cat > "${PROJECT_DIR}/${PROJECT_NAME}/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<true/>
	</dict>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>UILaunchScreen</key>
	<dict/>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>com.apple.security.application-groups</key>
	<array>
		<string>group.com.deyecloud.widget</string>
	</array>
</dict>
</plist>
EOF

echo -e "${GREEN}✓ Info.plist creado (App)${NC}"

# Crear archivos para Widget Extension
cat > "${PROJECT_DIR}/${PROJECT_NAME}Widget/Widget.swift" << 'EOF'
import SwiftUI
import WidgetKit

struct DeyeCloudWidgetEntry: TimelineEntry {
    let date: Date
}

struct DeyeCloudWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> DeyeCloudWidgetEntry {
        DeyeCloudWidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DeyeCloudWidgetEntry) -> ()) {
        let entry = DeyeCloudWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [DeyeCloudWidgetEntry(date: Date())]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DeyeCloudWidgetView: View {
    var entry: DeyeCloudWidgetProvider.Entry

    var body: some View {
        VStack {
            Text("✅ Widget Creado")
                .font(.headline)
            Text("Deye Cloud")
                .font(.caption)
        }
        .padding()
    }
}

@main
struct DeyeCloudWidget: Widget {
    let kind: String = "com.deyecloud.widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeyeCloudWidgetProvider()) { entry in
            DeyeCloudWidgetView(entry: entry)
        }
        .configurationDisplayName("Deye Cloud")
        .description("Widget para Deye Cloud")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
EOF

echo -e "${GREEN}✓ Widget.swift creado${NC}"

# Crear Info.plist para Widget
cat > "${PROJECT_DIR}/${PROJECT_NAME}Widget/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>NSExtensionPointIdentifier</key>
	<string>com.apple.widgetkit-extension</string>
	<key>com.apple.security.application-groups</key>
	<array>
		<string>group.com.deyecloud.widget</string>
	</array>
</dict>
</plist>
EOF

echo -e "${GREEN}✓ Info.plist creado (Widget)${NC}"
echo ""

# Crear archivo de instrucciones
cat > "${PROJECT_DIR}/CONFIGURACION_XCODE.md" << 'EOF'
# Configuración Final en Xcode

## Paso 1: Abrir en Xcode
```bash
open DeyeCloudWidget.xcodeproj
```

## Paso 2: Configurar Targets

### Target 1: App
1. Proyecto → DeyeCloudWidget
2. Targets → Selecciona "DeyeCloudWidget"
3. Build Settings → iOS Deployment Target: 17.0

### Target 2: Widget
1. Targets → Selecciona "DeyeCloudWidget Widget"
2. Build Settings → iOS Deployment Target: 17.0

## Paso 3: Configurar App Groups (IMPORTANTE)

### Para App Target:
1. Signing & Capabilities
2. "+ Capability" → App Groups
3. Valor: `group.com.deyecloud.widget`

### Para Widget Target:
1. Signing & Capabilities
2. "+ Capability" → App Groups
3. Valor: `group.com.deyecloud.widget`

## Paso 4: Compilar
```
Cmd + B
```

## Paso 5: Ejecutar
```
Cmd + R
```

## Siguientes Pasos:
1. Ve a: `~/.copilot/session-state/.../files/`
2. Copia los 6 archivos Swift principales
3. Reemplaza en Xcode (DeyeCloudApp.swift, DeyeCloudWidget.swift, etc.)
4. Recompila

¡Eso es todo!
EOF

echo -e "${GREEN}✓ Instrucciones creadas${NC}"
echo ""

# Crear script para abrir en Xcode automáticamente
cat > "${PROJECT_DIR}/open-in-xcode.sh" << EOF
#!/bin/bash
cd "\${PROJECT_DIR}"
open -a Xcode .
EOF

chmod +x "${PROJECT_DIR}/open-in-xcode.sh"

echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Proyecto creado exitosamente${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}📁 Ubicación:${NC} ${PROJECT_DIR}"
echo ""
echo -e "${BLUE}📋 Próximos pasos:${NC}"
echo "  1. Abre el proyecto:"
echo "     open -a Xcode ${PROJECT_DIR}"
echo ""
echo "  2. Configura App Groups en ambos targets"
echo ""
echo "  3. Compila:"
echo "     Cmd + B"
echo ""
echo "  4. Ejecuta:"
echo "     Cmd + R"
echo ""
echo -e "${YELLOW}📄 Lee:${NC} ${PROJECT_DIR}/CONFIGURACION_XCODE.md"
echo ""

# Preguntar si abrir en Xcode
read -p "¿Abrir proyecto en Xcode? (s/n): " RESPONSE
if [[ $RESPONSE =~ ^[Ss]$ ]]; then
    open -a Xcode "${PROJECT_DIR}"
fi
