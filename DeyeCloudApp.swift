import SwiftUI
import WidgetKit

@main
struct DeyeCloudApp: App {
    @State private var showSettings = false
    @State private var credentialsConfigured = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.yellow)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Deye Cloud Widget")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("Monitor tu instalación solar")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .background(Color(.systemBackground))
                    .border(width: 1, edges: [.bottom], color: Color(.separator))
                    
                    // Main Content
                    ScrollView {
                        VStack(spacing: 20) {
                            // Status Card
                            StatusCardView(isConfigured: credentialsConfigured)
                            
                            // Widget Preview
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Vista Previa del Widget")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                // Small Widget Preview
                                VStack(spacing: 8) {
                                    HStack {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundColor(.yellow)
                                        Text("Deye Cloud")
                                            .font(.headline)
                                        Spacer()
                                        HStack(spacing: 4) {
                                            Circle()
                                                .fill(Color.green)
                                                .frame(width: 8, height: 8)
                                            Text("Online")
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Label("Generación", systemImage: "arrow.up.circle.fill")
                                                .font(.caption)
                                                .foregroundColor(.green)
                                            Spacer()
                                            Text("2.5 kW")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                        }
                                        
                                        HStack {
                                            Label("Consumo", systemImage: "arrow.down.circle.fill")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                            Spacer()
                                            Text("1.8 kW")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                            
                            // Instructions
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Pasos para Usar")
                                    .font(.headline)
                                
                                InstructionStepView(
                                    number: 1,
                                    title: "Configurar Credenciales",
                                    description: "Ingresa tu API Key y Device ID de Deye Cloud"
                                )
                                
                                InstructionStepView(
                                    number: 2,
                                    title: "Agregar Widget",
                                    description: "Long press en home → '+' → Busca 'Deye Cloud'"
                                )
                                
                                InstructionStepView(
                                    number: 3,
                                    title: "Seleccionar Tamaño",
                                    description: "Elige entre Compacto (2x2) o Normal (4x2)"
                                )
                                
                                InstructionStepView(
                                    number: 4,
                                    title: "¡Listo!",
                                    description: "Tu widget mostrará datos en tiempo real"
                                )
                            }
                            .padding()
                            .background(Color(.systemBlue).opacity(0.1))
                            .cornerRadius(12)
                            .padding()
                            
                            // Action Buttons
                            VStack(spacing: 12) {
                                Button(action: { showSettings = true }) {
                                    HStack {
                                        Image(systemName: "gear")
                                        Text("Configurar Credenciales")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    DeyeCloudWidgetManager.shared.updateWidget()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.clockwise")
                                        Text("Actualizar Widget Ahora")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                                
                                if credentialsConfigured {
                                    Button(action: {
                                        DeyeCloudWidgetManager.shared.clearCredentials()
                                        credentialsConfigured = false
                                    }) {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Limpiar Credenciales")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding()
                            
                            // Footer Info
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Información")
                                    .font(.headline)
                                
                                InfoRowView(
                                    icon: "shield.fill",
                                    title: "Seguridad",
                                    description: "Tus credenciales se guardan de forma segura usando App Groups"
                                )
                                
                                InfoRowView(
                                    icon: "wifi",
                                    title: "Conectividad",
                                    description: "El widget se actualiza cada 15 minutos automáticamente"
                                )
                                
                                InfoRowView(
                                    icon: "battery.100",
                                    title: "Caché",
                                    description: "Los datos se almacenan localmente para funcionar sin internet"
                                )
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding()
                        }
                        .padding(.vertical)
                    }
                }
                
                // Settings Sheet
                if showSettings {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showSettings = false
                        }
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Configurar Widget")
                                .font(.headline)
                            Spacer()
                            Button(action: { showSettings = false }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .border(width: 1, edges: [.bottom], color: Color(.separator))
                        
                        DeyeCloudSettingsView(
                            onSave: {
                                credentialsConfigured = true
                                showSettings = false
                            }
                        )
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
                }
            }
            .onAppear {
                credentialsConfigured = DeyeCloudWidgetManager.shared.areCredentialsConfigured()
            }
        }
    }
}

// MARK: - Helper Views

struct StatusCardView: View {
    let isConfigured: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: isConfigured ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(isConfigured ? .green : .orange)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(isConfigured ? "Configurado" : "No Configurado")
                        .font(.headline)
                    Text(isConfigured ? 
                        "Tu widget está listo para usar" : 
                        "Configura tus credenciales para comenzar")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(isConfigured ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
            .cornerRadius(12)
            .padding()
        }
    }
}

struct InstructionStepView: View {
    let number: Int
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.blue)
                .frame(width: 32, height: 32)
                .overlay(
                    Text("\(number)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
        }
    }
}

struct InfoRowView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

// Helper extension para border
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(
            VStack(spacing: 0) {
                ForEach(edges, id: \.self) { edge in
                    if edge == .top {
                        color.frame(height: width)
                    } else if edge == .bottom {
                        Spacer()
                        color.frame(height: width)
                    } else if edge == .leading {
                        EmptyView()
                    }
                }
            }
        )
    }
}

#Preview {
    DeyeCloudApp()
}
