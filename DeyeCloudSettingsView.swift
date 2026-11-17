import SwiftUI
import WidgetKit

// MARK: - Vista de Configuración del Widget
struct DeyeCloudSettingsView: View {
    @State private var apiKey: String = ""
    @State private var deviceID: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertType: AlertType = .success
    
    var onSave: (() -> Void)?
    
    enum AlertType {
        case success, error
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Instrucciones
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                        Text("¿Dónde obtener tus credenciales?")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        StepTextView(step: "1", text: "Ve a https://www.deyecloud.com")
                        StepTextView(step: "2", text: "Inicia sesión con tu cuenta")
                        StepTextView(step: "3", text: "Ve a Configuración > API")
                        StepTextView(step: "4", text: "Genera una nueva API Key")
                        StepTextView(step: "5", text: "Encuentra tu Device ID en dispositivos")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding()
                
                // Formulario
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("API Key", systemImage: "key.fill")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        SecureField("Pega tu API Key aquí", text: $apiKey)
                            .textContentType(.password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Device ID", systemImage: "iphone")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        TextField("Pega tu Device ID aquí", text: $deviceID)
                            .textContentType(.none)
                            .autocorrectionDisabled()
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                // Botón Guardar
                VStack(spacing: 12) {
                    Button(action: saveCredentials) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Guardar Credenciales")
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .fontWeight(.semibold)
                    }
                    
                    Text("Tus credenciales se guardarán de forma segura en el App Group del widget")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .textAlignment(.center)
                }
                .padding()
                
                Spacer()
            }
        }
        .alert("Resultado", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                if alertType == .success {
                    onSave?()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func saveCredentials() {
        guard !apiKey.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Por favor ingresa tu API Key"
            alertType = .error
            showAlert = true
            return
        }
        
        guard !deviceID.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Por favor ingresa tu Device ID"
            alertType = .error
            showAlert = true
            return
        }
        
        // Guardar credenciales
        DeyeCloudWidgetDefaults.saveAPIKey(apiKey)
        DeyeCloudWidgetDefaults.saveDeviceID(deviceID)
        
        // Configurar el servicio
        DeyeCloudAPIService.shared.configure(
            apiKey: apiKey,
            deviceID: deviceID
        )
        
        // Recargar widget
        WidgetCenter.shared.reloadAllTimelines()
        
        alertMessage = "✅ Credenciales guardadas correctamente.\nEl widget se actualizará en breve."
        alertType = .success
        showAlert = true
    }
}

struct StepTextView: View {
    let step: String
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(step)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(Color.blue)
                .cornerRadius(10)
            
            Text(text)
                .font(.caption)
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    DeyeCloudSettingsView()
}

// MARK: - Versión SwiftUI para tu Aplicación
// Utiliza este código en tu aplicación principal

class DeyeCloudWidgetManager {
    
    static let shared = DeyeCloudWidgetManager()
    
    /// Verifica si el widget está disponible en el dispositivo
    func isWidgetAvailable() -> Bool {
        // Widget está disponible en iOS 17+
        if #available(iOS 17.0, *) {
            return true
        }
        return false
    }
    
    /// Abre la pantalla de agregar widget en el sistema
    func openWidgetLibrary() {
        WidgetCenter.shared.reloadAllTimelines()
        
        // Instrucciones para el usuario:
        // 1. Home screen → Long press
        // 2. Tap "+" en la esquina superior izquierda
        // 3. Busca "Deye Cloud"
        // 4. Selecciona tamaño (Compacto o Normal)
        // 5. Tap "Agregar widget"
    }
    
    /// Verifica si las credenciales están configuradas
    func areCredentialsConfigured() -> Bool {
        return DeyeCloudWidgetDefaults.getAPIKey() != nil &&
               DeyeCloudWidgetDefaults.getDeviceID() != nil
    }
    
    /// Fuerza la actualización del widget
    func updateWidget() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    /// Elimina las credenciales guardadas
    func clearCredentials() {
        DeyeCloudWidgetDefaults.saveAPIKey("")
        DeyeCloudWidgetDefaults.saveDeviceID("")
        WidgetCenter.shared.reloadAllTimelines()
    }
}
