import WidgetKit
import SwiftUI

// MARK: - Data Models
struct DeyeCloudData: Codable {
    let powerGeneration: Double      // Potencia generada (kW)
    let powerConsumption: Double     // Potencia consumida (kW)
    let status: SystemStatus         // Estado del sistema
    let lastUpdate: Date
    
    enum SystemStatus: String, Codable {
        case online = "online"
        case offline = "offline"
        case error = "error"
        case standby = "standby"
    }
}

// MARK: - Data Provider
class DeyeCloudProvider: TimelineProvider {
    
    // Simulación de datos para desarrollo
    // En producción, aquí consumirías la API de Deye Cloud
    func placeholder(in context: Context) -> DeyeCloudEntry {
        DeyeCloudEntry(
            date: Date(),
            data: DeyeCloudData(
                powerGeneration: 2.5,
                powerConsumption: 1.8,
                status: .online,
                lastUpdate: Date()
            )
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DeyeCloudEntry) -> ()) {
        let entry = DeyeCloudEntry(
            date: Date(),
            data: DeyeCloudData(
                powerGeneration: 3.2,
                powerConsumption: 2.1,
                status: .online,
                lastUpdate: Date()
            )
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DeyeCloudEntry>) -> ()) {
        // Actualizar cada 15 minutos
        let currentDate = Date()
        let entries: [DeyeCloudEntry] = [
            DeyeCloudEntry(
                date: currentDate,
                data: DeyeCloudData(
                    powerGeneration: 2.8,
                    powerConsumption: 1.9,
                    status: .online,
                    lastUpdate: currentDate
                )
            )
        ]
        
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

// MARK: - Timeline Entry
struct DeyeCloudEntry: TimelineEntry {
    let date: Date
    let data: DeyeCloudData
}

// MARK: - Widget Views
struct DeyeCloudWidgetSmall: View {
    var entry: DeyeCloudProvider.Entry
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                Text("Deye Cloud")
                    .font(.headline)
                Spacer()
                statusIndicator
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Label("Generación", systemImage: "arrow.up.circle.fill")
                        .font(.caption)
                        .foregroundColor(.green)
                    Spacer()
                    Text("\(String(format: "%.1f", entry.data.powerGeneration)) kW")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Label("Consumo", systemImage: "arrow.down.circle.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Spacer()
                    Text("\(String(format: "%.1f", entry.data.powerConsumption)) kW")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
    
    private var statusIndicator: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            Text(entry.data.status.rawValue.capitalized)
                .font(.caption2)
                .fontWeight(.semibold)
        }
    }
    
    private var statusColor: Color {
        switch entry.data.status {
        case .online:
            return .green
        case .offline:
            return .gray
        case .error:
            return .red
        case .standby:
            return .orange
        }
    }
}

struct DeyeCloudWidgetMedium: View {
    var entry: DeyeCloudProvider.Entry
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                    .font(.title3)
                Text("Deye Cloud")
                    .font(.headline)
                Spacer()
                statusIndicator
            }
            
            HStack(spacing: 20) {
                // Generación
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.green)
                        Text("Generando")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text("\(String(format: "%.1f", entry.data.powerGeneration)) kW")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Divider()
                    .frame(height: 40)
                
                // Consumo
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundColor(.blue)
                        Text("Consumiendo")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text("\(String(format: "%.1f", entry.data.powerConsumption)) kW")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            
            HStack {
                Text("Actualizado: \(entry.data.lastUpdate.formatted(date: .omitted, time: .shortened))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
    
    private var statusIndicator: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor)
                .frame(width: 10, height: 10)
            Text(entry.data.status.rawValue.capitalized)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
    
    private var statusColor: Color {
        switch entry.data.status {
        case .online:
            return .green
        case .offline:
            return .gray
        case .error:
            return .red
        case .standby:
            return .orange
        }
    }
}

// MARK: - Widget Bundle
@main
struct DeyeCloudWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        DeyeCloudSmallWidget()
        DeyeCloudMediumWidget()
    }
}

struct DeyeCloudSmallWidget: Widget {
    let kind: String = "com.deyecloud.widget.small"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeyeCloudProvider()) { entry in
            DeyeCloudWidgetSmall(entry: entry)
        }
        .configurationDisplayName("Deye Cloud (Compacto)")
        .description("Muestra potencia generada y consumida en tiempo real")
        .supportedFamilies([.systemSmall])
    }
}

struct DeyeCloudMediumWidget: Widget {
    let kind: String = "com.deyecloud.widget.medium"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeyeCloudProvider()) { entry in
            DeyeCloudWidgetMedium(entry: entry)
        }
        .configurationDisplayName("Deye Cloud (Normal)")
        .description("Visualización completa de la potencia solar")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: - Preview
#Preview(as: .systemSmall) {
    DeyeCloudSmallWidget()
} timeline: {
    DeyeCloudEntry(
        date: .now,
        data: DeyeCloudData(
            powerGeneration: 2.5,
            powerConsumption: 1.8,
            status: .online,
            lastUpdate: .now
        )
    )
}

#Preview(as: .systemMedium) {
    DeyeCloudMediumWidget()
} timeline: {
    DeyeCloudEntry(
        date: .now,
        data: DeyeCloudData(
            powerGeneration: 3.2,
            powerConsumption: 2.1,
            status: .online,
            lastUpdate: .now
        )
    )
}
