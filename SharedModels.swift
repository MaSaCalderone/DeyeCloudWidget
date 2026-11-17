import Foundation

// MARK: - Modelos compartidos entre App y Widget
extension Codable {
    func toJSONData() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

extension Data {
    func fromJSON<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: self)
    }
}

// MARK: - Extension para UserDefaults
extension UserDefaults {
    static let widgetGroup = UserDefaults(suiteName: "group.com.deyecloud.widget")!
    
    func setCodable<T: Encodable>(_ value: T, forKey key: String) {
        if let data = value.toJSONData() {
            self.set(data, forKey: key)
        }
    }
    
    func codable<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        return data.fromJSON(type)
    }
}

// MARK: - Localizaciones
struct Strings {
    struct Widget {
        static let generation = "Generando"
        static let consumption = "Consumiendo"
        static let status = "Estado"
        static let lastUpdate = "Actualizado"
        static let online = "En línea"
        static let offline = "Desconectado"
        static let error = "Error"
        static let standby = "En espera"
    }
    
    struct App {
        static let configureCredentials = "Configurar Credenciales"
        static let updateWidget = "Actualizar Widget Ahora"
        static let clearCredentials = "Limpiar Credenciales"
        static let settings = "Configuración"
        static let instructions = "Pasos para Usar"
        static let information = "Información"
        static let security = "Seguridad"
        static let connectivity = "Conectividad"
        static let cache = "Caché"
        static let configured = "Configurado"
        static let notConfigured = "No Configurado"
    }
    
    struct Errors {
        static let apiKeyEmpty = "Por favor ingresa tu API Key"
        static let deviceIDEmpty = "Por favor ingresa tu Device ID"
        static let savingFailed = "Error al guardar credenciales"
        static let apiKeyInvalid = "API Key inválida"
        static let deviceIDInvalid = "Device ID inválido"
        static let networkError = "Error de conectividad"
    }
    
    struct Success {
        static let saved = "✅ Credenciales guardadas correctamente.\nEl widget se actualizará en breve."
        static let cleared = "✅ Credenciales eliminadas."
        static let updated = "✅ Widget actualizado."
    }
}

// MARK: - Constants
struct Constants {
    static let appGroupIdentifier = "group.com.deyecloud.widget"
    static let apiKeyKey = "deyecloud_api_key"
    static let deviceIDKey = "deyecloud_device_id"
    static let cachedDataKey = "deyecloud_cached_data"
    static let lastUpdateKey = "deyecloud_last_update"
    
    static let widgetUpdateInterval: TimeInterval = 15 * 60  // 15 minutos
    static let apiBaseURL = "https://openapi.deyecloud.com"
    
    struct Colors {
        static let primary = "PrimaryColor"
        static let success = "SuccessColor"
        static let warning = "WarningColor"
        static let error = "ErrorColor"
    }
}

// MARK: - Extensión para Logger
class WidgetLogger {
    static let shared = WidgetLogger()
    
    func log(_ message: String, level: LogLevel = .info) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        print("[\(timestamp)] [\(level.rawValue)] \(message)")
    }
    
    enum LogLevel: String {
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }
}
