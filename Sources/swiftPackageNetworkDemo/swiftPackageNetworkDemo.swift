

import Foundation

public class swiftPackageNetworkDemo {
    
    public init() {}
    
    public func post(
        url: String,
        latlong: Double = 0.0,
        longitude: Double = 0.0,
        time: Int64 = 0, // epoch timestamp in seconds
        callback: @escaping (Any) -> Void
    ) {
        
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        
        let parameterDictionary: [String: Any] = [
            "lat": latlong,
            "lon": longitude,
            "time": time,
            "ext": ext,
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
           
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    callback(json)
                } catch {
                    callback(error)
                }
            } else {
                callback(error!)
            }
        }.resume()
    }
}
