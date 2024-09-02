import Foundation

class PharmacyViewModel: ObservableObject {
    @Published var pharmacies: [Pharmacy] = []
    @Published var isLoading = false
    @Published var city :String = ""
    @Published var district:String = ""
    private let apiKey = "0dhoNryXafOIbjFs5jk8L8:5Xchk0xydzVFY48DKWyd6w"
    
    func fetchDutyPharmacies() {
        isLoading = true
        let headers = [
            "content-type": "application/json",
            "authorization": "apikey \(apiKey)"
        ]

        guard let url = URL(string: "https://api.collectapi.com/health/dutyPharmacy?ilce=\(district)&il=\(city)") else {
            print("Geçersiz URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            if let jsonData = data, let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Gelen JSON: \(jsonString)")
            }

            
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Veri alınamadı")
                return
            }
            

            do {
                
                let decodedResponse = try JSONDecoder().decode(PharmacyResponse.self, from: data)
                if decodedResponse.success, let pharmacies = decodedResponse.result {
                    DispatchQueue.main.async {
                        self?.pharmacies = pharmacies
                    }
                } else {
                    print("API isteği başarısız oldu veya sonuçlar yok")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Veri bozulmuş: \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Anahtar bulunamadı: \(key) context: \(context)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Tip uyuşmazlığı: \(type) context: \(context)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Değer bulunamadı: \(value) context: \(context)")
            } catch {
                print("Genel hata: \(error.localizedDescription)")
            }
        }.resume()
    }
}
