import Foundation

// MARK: - API Service for Deye Cloud
class DeyeCloudAPIService {
    
    static let shared = DeyeCloudAPIService()
    
    private let baseURL = "https://openapi.deyecloud.com"  // Verificar URL real
    private var apiKey: String?
    private var deviceID: String?
    
    // Configurar credenciales
    func configure(apiKey: String, deviceID: String) {
        self.apiKey = apiKey
        self.deviceID = deviceID
    }
    
    // Obtener datos del dispositivo
    func fetchDeviceData() async throws -> DeyeCloudData {
        guard let apiKey = apiKey, let deviceID = deviceID else {
            throw APIError.notConfigured
        }
        
        let endpoint = "\(baseURL)/device/\(deviceID)/realtime"
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try decoder.decode(APIResponse.self, from: data)
        return apiResponse.toDeyeCloudData()
    }
    
    enum APIError: Error {
        case notConfigured
        case invalidURL
        case invalidResponse
        case decodingFailed
    }
}

// MARK: - API Response Models
struct APIResponse: Codable {
    let code: Int
    let message: String
    let data: DeviceRealtimeData
    
    func toDeyeCloudData() -> DeyeCloudData {
        let status: DeyeCloudData.SystemStatus = {
            switch data.deviceStatus {
            case "online":
                return .online
            case "offline":
                return .offline
            case "error":
                return .error
            default:
                return .standby
            }
        }()
        
        return DeyeCloudData(
            powerGeneration: data.totalPower / 1000.0,  // Convertir W a kW
            powerConsumption: data.loadPower / 1000.0,
            status: status,
            lastUpdate: Date()
        )
    }
}

struct DeviceRealtimeData: Codable {
    let deviceStatus: String
    let totalPower: Double      // Potencia generada en Watts
    let loadPower: Double       // Potencia consumida en Watts
    let batteryPower: Double?   // Potencia de batería (opcional)
    
    enum CodingKeys: String, CodingKey {
        case deviceStatus = "status"
        case totalPower = "pv_power"
        case loadPower = "load_power"
        case batteryPower = "battery_power"
    }
}

// MARK: - UserDefaults Manager
class DeyeCloudWidgetDefaults {
    private static let suite = UserDefaults(suiteName: "group.com.deyecloud.widget")
    
    static func saveAPIKey(_ key: String) {
        suite?.set(key, forKey: "deyecloud_api_key")
    }
    
    static func saveDeviceID(_ id: String) {
        suite?.set(id, forKey: "deyecloud_device_id")
    }
    
    static func getAPIKey() -> String? {
        suite?.string(forKey: "deyecloud_api_key")
    }
    
    static func getDeviceID() -> String? {
        suite?.string(forKey: "deyecloud_device_id")
    }
    
    static func saveCachedData(_ data: DeyeCloudData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            suite?.set(encoded, forKey: "deyecloud_cached_data")
        }
    }
    
    static func getCachedData() -> DeyeCloudData? {
        guard let data = suite?.data(forKey: "deyecloud_cached_data") else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(DeyeCloudData.self, from: data)
    }
}
