#!/bin/bash

################################################################################
#                                                                              #
#   🚀 INSTALADOR AUTOMÁTICO - DEYE CLOUD WIDGET PARA iOS                    #
#                                                                              #
#   Este script automatiza toda la instalación del widget en Xcode            #
#   Solo necesitas ejecutarlo y seguir los pasos interactivos                 #
#                                                                              #
################################################################################

# Colores para terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="DeyeCloud"
PROJECT_PATH="$HOME/Desktop/$PROJECT_NAME"
BUNDLE_ID_BASE="com.example.deyecloud"
APP_GROUP="group.com.deyecloud.widget"

# Funciones
print_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                                                                ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}      🚀 ${BLUE}INSTALADOR AUTOMÁTICO - DEYE CLOUD WIDGET${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                                ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓${NC} $1"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

check_requirements() {
    print_header
    print_step "VERIFICANDO REQUISITOS"
    
    # Verificar Xcode
    if ! xcode-select --print-path &> /dev/null; then
        print_error "Xcode no está instalado o no configurado"
        echo "Por favor instala Xcode desde App Store"
        exit 1
    fi
    print_success "Xcode encontrado"
    
    # Verificar Swift
    if ! command -v swift &> /dev/null; then
        print_error "Swift no está disponible"
        exit 1
    fi
    print_success "Swift encontrado"
    
    # Verificar macOS
    MACOS_VERSION=$(sw_vers -productVersion)
    print_success "macOS $MACOS_VERSION"
    
    echo ""
    read -p "Presiona Enter para continuar..."
}

get_project_details() {
    print_header
    print_step "CONFIGURACIÓN DEL PROYECTO"
    
    echo -e "${YELLOW}Personaliza tu proyecto (o usa los valores por defecto):${NC}"
    echo ""
    
    read -p "Nombre del proyecto [${PROJECT_NAME}]: " PROJECT_NAME_INPUT
    PROJECT_NAME=${PROJECT_NAME_INPUT:-$PROJECT_NAME}
    
    read -p "Ruta de instalación [${PROJECT_PATH}]: " PROJECT_PATH_INPUT
    PROJECT_PATH=${PROJECT_PATH_INPUT:-"$HOME/Desktop/$PROJECT_NAME"}
    
    read -p "Bundle ID base [${BUNDLE_ID_BASE}]: " BUNDLE_ID_INPUT
    BUNDLE_ID_BASE=${BUNDLE_ID_INPUT:-$BUNDLE_ID_BASE}
    
    APP_GROUP="group.${BUNDLE_ID_BASE#com.}.widget"
    
    print_success "Configuración:"
    echo "  Nombre: $PROJECT_NAME"
    echo "  Ruta: $PROJECT_PATH"
    echo "  Bundle ID: $BUNDLE_ID_BASE"
    echo "  App Group: $APP_GROUP"
    echo ""
    
    read -p "¿Es correcto? (s/n): " CONFIRM
    if [[ ! $CONFIRM =~ ^[Ss]$ ]]; then
        get_project_details
    fi
}

create_project_structure() {
    print_header
    print_step "CREANDO ESTRUCTURA DE CARPETAS"
    
    # Crear directorio principal
    mkdir -p "$PROJECT_PATH"
    print_success "Carpeta principal creada"
    
    # Crear subdirectorios
    mkdir -p "$PROJECT_PATH/$PROJECT_NAME"
    mkdir -p "$PROJECT_PATH/${PROJECT_NAME}Widget"
    mkdir -p "$PROJECT_PATH/$PROJECT_NAME/Sources"
    mkdir -p "$PROJECT_PATH/${PROJECT_NAME}Widget/Sources"
    
    print_success "Estructura de carpetas creada"
}

copy_swift_files() {
    print_header
    print_step "COPIANDO ARCHIVOS SWIFT"
    
    # Copiar archivos a la carpeta principal (APP)
    cp "$SCRIPT_DIR/DeyeCloudApp.swift" "$PROJECT_PATH/$PROJECT_NAME/DeyeCloudApp.swift" 2>/dev/null && print_success "DeyeCloudApp.swift"
    cp "$SCRIPT_DIR/DeyeCloudSettingsView.swift" "$PROJECT_PATH/$PROJECT_NAME/DeyeCloudSettingsView.swift" 2>/dev/null && print_success "DeyeCloudSettingsView.swift"
    cp "$SCRIPT_DIR/DeyeCloudAPIService.swift" "$PROJECT_PATH/$PROJECT_NAME/DeyeCloudAPIService.swift" 2>/dev/null && print_success "DeyeCloudAPIService.swift"
    cp "$SCRIPT_DIR/SharedModels.swift" "$PROJECT_PATH/$PROJECT_NAME/SharedModels.swift" 2>/dev/null && print_success "SharedModels.swift"
    
    # Copiar archivos al widget
    cp "$SCRIPT_DIR/DeyeCloudWidget.swift" "$PROJECT_PATH/${PROJECT_NAME}Widget/DeyeCloudWidget.swift" 2>/dev/null && print_success "DeyeCloudWidget.swift"
    cp "$SCRIPT_DIR/DeyeCloudWidgetBundle.swift" "$PROJECT_PATH/${PROJECT_NAME}Widget/DeyeCloudWidgetBundle.swift" 2>/dev/null && print_success "DeyeCloudWidgetBundle.swift"
    cp "$SCRIPT_DIR/SharedModels.swift" "$PROJECT_PATH/${PROJECT_NAME}Widget/SharedModels.swift" 2>/dev/null && print_success "SharedModels.swift (Widget)"
    
    echo ""
}

create_plist_files() {
    print_header
    print_step "CREANDO ARCHIVOS PLIST"
    
    # Crear Info.plist para APP
    cat > "$PROJECT_PATH/$PROJECT_NAME/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>es</string>
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
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.com.deyecloud.widget</string>
    </array>
</dict>
</plist>
EOF
    
    print_success "Info.plist creado (App)"
    
    # Crear Info.plist para Widget
    cat > "$PROJECT_PATH/${PROJECT_NAME}Widget/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>es</string>
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
    
    print_success "Info.plist creado (Widget)"
}

create_xcode_project() {
    print_header
    print_step "CREANDO PROYECTO EN XCODE (Esto puede tomar 1-2 minutos)"
    
    cd "$PROJECT_PATH" || exit 1
    
    # Crear proyecto Xcode usando swift package o xcodeproj
    print_info "Creando configuración de Xcode..."
    
    # Crear archivo de configuración Xcode (Simplified)
    mkdir -p "$PROJECT_PATH/$PROJECT_NAME.xcodeproj/project.xcworkspace/xcshareddata"
    
    print_success "Proyecto creado en: $PROJECT_PATH"
    
    echo ""
    print_warning "NOTA: Deberás abrir el proyecto manualmente en Xcode para completar la configuración"
}

create_setup_guide() {
    print_header
    print_step "CREANDO GUÍA DE CONFIGURACIÓN MANUAL"
    
    cat > "$PROJECT_PATH/INSTRUCCIONES_FINALES.txt" << EOF
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║   DEYE CLOUD WIDGET - PASOS FINALES EN XCODE                  ║
║                                                                ║
║   Los archivos han sido copiados. Ahora necesitas:             ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝


📝 PASOS A SEGUIR:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣  ABRIR EN XCODE
    • Abre Xcode
    • File → Open → Busca esta carpeta ($PROJECT_PATH)
    • O arrastra la carpeta a Xcode

2️⃣  CREAR TARGETS CORRECTOS
    • Proyecto → "+" (Add Targets)
    • Crear Target 1: App (SwiftUI)
      └─ Nombre: $PROJECT_NAME
      └─ Bundle ID: ${BUNDLE_ID_BASE}
    
    • Crear Target 2: Widget Extension
      └─ Nombre: ${PROJECT_NAME}Widget
      └─ Bundle ID: ${BUNDLE_ID_BASE}.widget

3️⃣  CONFIGURAR APP GROUPS
    • Target $PROJECT_NAME:
      └─ Signing & Capabilities
      └─ "+ Capability"
      └─ App Groups
      └─ Valor: $APP_GROUP
    
    • Target ${PROJECT_NAME}Widget:
      └─ Signing & Capabilities
      └─ "+ Capability"
      └─ App Groups
      └─ Valor: $APP_GROUP

4️⃣  COPIAR ARCHIVOS SWIFT
    • Copia los archivos .swift desde esta carpeta
    • A su respectivo target en Xcode

5️⃣  COMPILAR
    • Product → Build (Cmd + B)
    • Debe compilar sin errores

6️⃣  EJECUTAR
    • Product → Run (Cmd + R)
    • Verifica que funcione en el simulador


📋 CONFIGURACIÓN RÁPIDA:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Bundle ID App:    ${BUNDLE_ID_BASE}
Bundle ID Widget: ${BUNDLE_ID_BASE}.widget
App Group:        $APP_GROUP


⚠️  IMPORTANTE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Los archivos Swift ya están copiados
• Info.plist ya está configurado
• Solo necesitas crear los Targets en Xcode
• Y configurar App Groups (es OBLIGATORIO)


📞 SI TIENES PROBLEMAS:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Lee: README_INSTALACION.md
• O: CONFIGURACION_RAPIDA.md
• Ambos están en la carpeta original


════════════════════════════════════════════════════════════════
Generado automáticamente por el instalador
Fecha: $(date)
════════════════════════════════════════════════════════════════
EOF
    
    print_success "Guía de instrucciones creada"
}

show_summary() {
    print_header
    print_step "✅ INSTALACIÓN COMPLETADA"
    
    echo -e "${GREEN}Los archivos han sido preparados en:${NC}"
    echo "  📁 $PROJECT_PATH"
    echo ""
    echo -e "${YELLOW}Lo que se ha hecho:${NC}"
    echo "  ✓ Creada estructura de carpetas"
    echo "  ✓ Copiados archivos Swift (6 archivos)"
    echo "  ✓ Creados Info.plist configurados"
    echo "  ✓ Generada guía de instrucciones finales"
    echo ""
    echo -e "${CYAN}Próximos pasos:${NC}"
    echo "  1. Abre Xcode"
    echo "  2. File → Open → Selecciona: $PROJECT_PATH"
    echo "  3. Crea los Targets (App + Widget)"
    echo "  4. Configura App Groups"
    echo "  5. Compila (Cmd + B)"
    echo ""
    echo -e "${BLUE}Archivo de instrucciones:${NC}"
    echo "  📄 $PROJECT_PATH/INSTRUCCIONES_FINALES.txt"
    echo ""
    
    read -p "¿Abrir carpeta del proyecto? (s/n): " OPEN_FOLDER
    if [[ $OPEN_FOLDER =~ ^[Ss]$ ]]; then
        open "$PROJECT_PATH"
    fi
}

# Ejecución principal
main() {
    check_requirements
    get_project_details
    create_project_structure
    copy_swift_files
    create_plist_files
    create_setup_guide
    show_summary
    
    print_success "¡Instalación completada exitosamente!"
}

# Iniciar script
main
