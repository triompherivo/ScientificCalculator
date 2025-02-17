import SwiftUI

struct ConversionResponse: Decodable {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let query: Query?
    let info: Info?
    let result: Double?
}

struct Query: Decodable {
    let from: String
    let to: String
    let amount: Double
}

struct Info: Decodable {
    let timestamp: Int
    let quote: Double
}

struct CurrencyView: View {
    @State private var amountText: String = "1200000"
    @State private var conversionResult: String = ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Ariary to Euro Converter")
                .font(.title)
                .padding(.top)

            TextField("Enter amount in Ariary", text: $amountText)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            Button(action: {
                convertCurrency()
            }) {
                Text("Convert to Euro")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            if isLoading {
                ProgressView()
            }
            
            if !conversionResult.isEmpty {
                Text("Converted Amount: \(conversionResult) €")
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
    
    func convertCurrency() {
        guard let amount = Double(amountText) else {
            conversionResult = "Invalid amount"
            return
        }
        
        isLoading = true
        
        // Use the correct URL with your API key or use a free API if available.
        // For example, using CurrencyLayer API:
        let apiKey = "a854195e924794cc97441af2bdfd3340"  // Replace with your API key
        let urlString = "https://api.currencylayer.com/convert?from=MGA&to=EUR&amount=\(amount)&access_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            conversionResult = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        // If your provider requires the API key in a header instead:
        // request.addValue(apiKey, forHTTPHeaderField: "apikey")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.conversionResult = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.conversionResult = "No data returned"
                }
                return
            }
            
            // Debug: Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let resultResponse = try decoder.decode(ConversionResponse.self, from: data)
                DispatchQueue.main.async {
                    if let result = resultResponse.result {
                        self.conversionResult = String(format: "%.2f", result)
                    } else {
                        print("Decoded response: \(resultResponse)")
                        self.conversionResult = "Conversion result missing"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.conversionResult = "Parsing error: \(error.localizedDescription)"
                }
            }
        }
        .resume()
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
